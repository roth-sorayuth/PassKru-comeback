import React, { useEffect, useState } from 'react';
import { useApp } from '../../context/AppContext';
import { useLanguage } from '../../context/LanguageContext';
import { getQuizzes, getQuiz } from '../../services/quizService';
import { startAttempt, submitAttempt, getAttempt } from '../../services/attemptService';
import { ConfirmDialog } from '../ui/ConfirmDialog';
import { MathText } from '../ui/MathText';
import {
  isSubjectInSelection,
  withCoreSubjects,
  getExamCategoryTag,
} from '../../data/examSelectionData';
import { SEOHead } from '../common/SEOHead';
import {
  AlertTriangle,
  ArrowRight,
  ArrowLeft,
  CheckCircle2,
  CheckSquare,
  XCircle,
  Loader2,
  ListChecks,
  Play,
  RotateCcw,
  Clock,
  RefreshCw,
  Layers,
  Award,
  BookOpen,
  FileText,
  ChevronLeft,
  ChevronRight,
  Send,
  Sparkles,
  HelpCircle,
  ShieldCheck,
  Check,
} from 'lucide-react';
import { getSubjects } from '../../services/subjectService';
import { getSubjectMeta } from './PracticePage';

interface QuizOption {
  optionId: number;
  optionText: string;
}

interface QuizQuestion {
  questionId: number;
  topicId: number | null;
  topicName: string | null;
  questionText: string;
  questionOrder: number;
  options: QuizOption[];
}

interface QuizDetail {
  quizId: number;
  title: string;
  subjectName: string | null;
  durationMinutes: number | null;
  totalQuestions: number;
  questions: QuizQuestion[];
}

interface QuizListItem {
  quizId: number;
  rawQuizId?: string;
  title: string;
  subjectName: string | null;
  totalQuestions: number;
  durationMinutes: number | null;
  difficulty?: 'easy' | 'medium' | 'hard';
}

interface GradedAnswer {
  questionId: number;
  selectedOptionId: number | null;
  isCorrect: boolean;
  correctOptionId: number | null;
  explanation: string | null;
}

/**
 * Rebuilds the submit response from GET /attempts/:id. Used when a submit
 * reached the server but its response was lost (flaky mobile connection):
 * the retry is refused as "already submitted", yet the graded attempt exists.
 */
function resultFromGradedAttempt(attempt: any): AttemptResult {
  const answers: GradedAnswer[] = (attempt.answers || []).map((a: any) => ({
    questionId: a.questionId,
    selectedOptionId: a.selectedOptionId ?? null,
    isCorrect: Boolean(a.isCorrect),
    correctOptionId: (a.options || []).find((o: any) => o.isCorrect)?.optionId ?? null,
    explanation: a.explanation ?? null,
  }));
  return {
    attemptId: attempt.attemptId,
    score: attempt.score ?? 0,
    correctCount: answers.filter((a) => a.isCorrect).length,
    totalQuestions: answers.length,
    answers,
    topicStats: [],
  };
}

/** Submits an attempt; if it was already graded, returns the stored result instead of failing. */
async function submitOrRecover(attemptId: number, payload: { questionId: number; selectedOptionId: number | null }[]): Promise<AttemptResult> {
  try {
    const res = await submitAttempt(attemptId, payload);
    return res.result;
  } catch (err: any) {
    if (err?.statusCode === 400) {
      const existing = await getAttempt(attemptId).catch(() => null);
      if (existing?.attempt?.endTime) return resultFromGradedAttempt(existing.attempt);
    }
    throw err;
  }
}

/**
 * In-progress answers are mirrored to localStorage so a crash, reload or closed
 * tab doesn't lose them. Every open starts a new attempt on the server, so the
 * quiz id (plus mock set for mock-exam papers) is the stable key; the attempt
 * id lives in the entry and is only reused while that attempt is still open.
 */
interface SavedProgress {
  attemptId: number;
  answers: Record<number, number>;
  timeLeft: number | null;
  savedAt: number;
}

const PROGRESS_PREFIX = 'passkru_quiz_progress:';
const quizProgressKey = (quizId: number) => `${PROGRESS_PREFIX}quiz:${quizId}`;
const mockProgressKey = (setNum: number, quizId: number) => `${PROGRESS_PREFIX}mock:${setNum}:${quizId}`;

function readProgress(key: string): SavedProgress | null {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return null;
    const parsed = JSON.parse(raw);
    if (!parsed || typeof parsed.attemptId !== 'number' || typeof parsed.answers !== 'object' || !parsed.answers) return null;
    return parsed as SavedProgress;
  } catch {
    return null;
  }
}

function writeProgress(key: string, value: SavedProgress) {
  try {
    localStorage.setItem(key, JSON.stringify(value));
  } catch { }
}

function clearProgress(key: string) {
  try {
    localStorage.removeItem(key);
  } catch { }
}

/** The saved entry, if its attempt is still open on the server; a graded or unknown attempt is dropped. */
async function findOpenAttempt(key: string): Promise<SavedProgress | null> {
  const saved = readProgress(key);
  if (!saved) return null;
  try {
    const res = await getAttempt(saved.attemptId);
    if (res?.attempt && !res.attempt.endTime) return saved;
  } catch (err: any) {
    // Offline or server error: keep the entry for next time, but start fresh now.
    if (err?.statusCode !== 404 && err?.statusCode !== 403) return null;
  }
  clearProgress(key);
  return null;
}

type PendingResume =
  | { kind: 'quiz'; saved: SavedProgress; fullTime: number }
  | { kind: 'mock'; saved: Record<number, SavedProgress> };

interface AttemptResult {
  attemptId: number;
  score: number;
  correctCount: number;
  totalQuestions: number;
  answers: GradedAnswer[];
  topicStats: { topicId: number; accuracy: number; correct: number; total: number }[];
}

export interface MockSubjectPaper {
  subjectId: string;
  subjectName: string;
  subjectNameKm: string;
  subjectNameEn: string;
  quizId: number;
  attemptId: number | null;
  title: string;
  questions: QuizQuestion[];
  answers: Record<number, number>;
}

export interface MockExamSubjectResult {
  subjectName: string;
  subjectNameKm: string;
  subjectNameEn: string;
  quizId: number;
  score: number;
  correctCount: number;
  totalQuestions: number;
  answers: GradedAnswer[];
  questions: QuizQuestion[];
}

export interface MockExamResult {
  totalScore: number;
  totalCorrect: number;
  totalQuestions: number;
  passed: boolean;
  subjectResults: MockExamSubjectResult[];
}

type Stage = 'lobby' | 'taking' | 'result';

/** Label for the button that returns to the page which opened the quiz. */
const RETURN_LABELS: Record<string, { km: string; en: string }> = {
  'study-plan': { km: 'ត្រឡប់ទៅផែនការសិក្សា', en: 'Back to Study Plan' },
  dashboard: { km: 'ត្រឡប់ទៅផ្ទាំងគ្រប់គ្រង', en: 'Back to Dashboard' },
  weakness: { km: 'ត្រឡប់ទៅចំណុចខ្សោយ', en: 'Back to Weak Areas' },
};

export const formatSubjectName = (name: string | null | undefined, lang: string): string => {
  if (!name) return '';
  const lower = name.toLowerCase().trim();
  if (lower.includes('general') || lower.includes('culture') || lower.includes('knowledge') || lower.includes('វប្បធម៌') || lower === 'gk') {
    return lang === 'km' ? 'វប្បធម៌ទូទៅ' : 'General Knowledge';
  }
  if (lower.includes('english') || lower.includes('អង់គ្លេស')) {
    return lang === 'km' ? 'ភាសាអង់គ្លេស' : 'English Language';
  }
  if (lower.includes('khmer') || lower.includes('ខ្មែរ')) {
    return lang === 'km' ? 'ភាសាខ្មែរ' : 'Khmer Language';
  }
  if (lower.includes('math') || lower.includes('គណិត')) {
    return lang === 'km' ? 'គណិតវិទ្យា' : 'Mathematics';
  }
  if (lower.includes('phys') || lower.includes('រូប')) {
    return lang === 'km' ? 'រូបវិទ្យា' : 'Physics';
  }
  if (lower.includes('chem') || lower.includes('គីមី')) {
    return lang === 'km' ? 'គីមីវិទ្យា' : 'Chemistry';
  }
  if (lower.includes('bio') || lower.includes('ជីវ')) {
    return lang === 'km' ? 'ជីវវិទ្យា' : 'Biology';
  }
  if (lower.includes('hist') || lower.includes('ប្រវត្តិ')) {
    return lang === 'km' ? 'ប្រវត្តិវិទ្យា' : 'History';
  }
  if (lower.includes('geo') || lower.includes('ភូមិ')) {
    return lang === 'km' ? 'ភូមិវិទ្យា' : 'Geography';
  }
  if (lower.includes('civic') || lower.includes('moral') || lower.includes('សីលធម៌') || lower.includes('ពលរដ្ឋ')) {
    return lang === 'km' ? 'សីលធម៌-ពលរដ្ឋវិជ្ជា' : 'Civics & Ethics';
  }
  return name;
};

export const QuizPage: React.FC = () => {
  const {
    activeQuizId,
    setActiveQuizId,
    activeQuiz,
    setActiveQuiz,
    activeMockExam,
    setActiveMockExam,
    activeMockSetNumber,
    selectedPracticeSubject,
    setSelectedPracticeSubject,
    selectedPracticeSubjectId,
    saveSubjectScore,
    subjectScores,
    setPracticeViewMode,
    currentPage,
    setCurrentPage,
    userProfile,
    openExamSelection,
    quizReturnPage,
  } = useApp();
  const { lang } = useLanguage();

  // Mock exams open on the 'mock-exam' page. Don't read the practice tab saved in
  // sessionStorage here: it outlives the mock exam and would turn a later quiz
  // (e.g. one started from the dashboard) into a mock exam.
  const isMockExam = currentPage === 'mock-exam' || Boolean(activeMockExam);

  const [stage, setStage] = useState<Stage>('lobby');
  const [quizzes, setQuizzes] = useState<QuizListItem[]>([]);
  const [quiz, setQuiz] = useState<QuizDetail | null>(null);
  const [currentQuizKey, setCurrentQuizKey] = useState<string | null>(null);
  const [attemptId, setAttemptId] = useState<number | null>(null);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [result, setResult] = useState<AttemptResult | null>(null);
  const [timeLeft, setTimeLeft] = useState<number | null>(null);

  const [loading, setLoading] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Multi-subject Mock Exam state
  const [mockPapers, setMockPapers] = useState<MockSubjectPaper[]>([]);
  const [activePaperIndex, setActivePaperIndex] = useState<number>(0);
  const [mockResult, setMockResult] = useState<MockExamResult | null>(null);
  const [showSubmitConfirm, setShowSubmitConfirm] = useState<boolean>(false);
  const [showQuizSubmitConfirm, setShowQuizSubmitConfirm] = useState<boolean>(false);
  const [mockReviewSubjectFilter, setMockReviewSubjectFilter] = useState<string>('all');
  // Saved answers from an unfinished attempt, waiting for the learner to resume or start over.
  const [pendingResume, setPendingResume] = useState<PendingResume | null>(null);
  const [resumeBusy, setResumeBusy] = useState(false);

  const toKhmerNumeral = (num: number | string) =>
    String(num).replace(/[0-9]/g, (d) => '០១២៣៤៥៦៧៨៩'[Number(d)]);

  const formatTime = (seconds: number | null) => {
    if (seconds === null) return '--:--';
    const hrs = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    if (hrs > 0) {
      return `${hrs.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    }
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  };

  const formatTimeKm = (seconds: number | null) => {
    if (seconds === null) return '--:--';
    const hrs = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    if (hrs > 0) {
      return `${toKhmerNumeral(hrs)} ម៉ោង ${toKhmerNumeral(m.toString().padStart(2, '0'))} នាទី ${toKhmerNumeral(s.toString().padStart(2, '0'))} វិនាទី`;
    }
    return `${toKhmerNumeral(m.toString().padStart(2, '0'))} នាទី ${toKhmerNumeral(s.toString().padStart(2, '0'))} វិនាទី`;
  };

  // Quizzes and mock exams are real DB quizzes: the practice page, a course task
  // or the picker sets activeQuizId. There is no local question or answer source.
  useEffect(() => {
    if (activeQuizId) {
      openQuiz(activeQuizId);
    } else if (currentPage === 'mock-exam' || (isMockExam && !activeQuiz && !activeQuizId)) {
      loadMockExam(activeMockSetNumber || 1);
    } else if (!selectedPracticeSubject) {
      // No quiz and no subject (refresh, browser back): an all-subjects list isn't a page, so go to the subject list.
      returnToPracticeQuizList(true);
    } else {
      loadLobby();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentPage, activeQuizId, selectedPracticeSubject, activeMockSetNumber]);

  const loadLobby = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await getQuizzes({
        targetExam: userProfile?.targetExam,
        subjectName: selectedPracticeSubject || undefined,
      });
      let list: QuizListItem[] = (res.quizzes || []).map((q: any) => ({
        quizId: q.quizId,
        rawQuizId: String(q.quizId),
        title: (q.title || '').replace(/ឈុត/g, 'វិញ្ញាសារ'),
        subjectName: q.subjectName,
        totalQuestions: q.totalQuestions,
        durationMinutes: q.durationMinutes,
        difficulty: q.difficultyLevel,
      }));

      if (userProfile?.selectedSubjects && userProfile.selectedSubjects.length > 0) {
        const filtered = list.filter(q =>
          !q.subjectName ||
          isSubjectInSelection(q.subjectName, withCoreSubjects(userProfile.selectedSubjects)) ||
          isSubjectInSelection(q.title, withCoreSubjects(userProfile.selectedSubjects))
        );
        if (filtered.length > 0) list = filtered;
      }

      if (selectedPracticeSubject) {
        const subFiltered = list.filter(q =>
          q.subjectName && (
            isSubjectInSelection(q.subjectName, [selectedPracticeSubject]) ||
            q.subjectName.toLowerCase().includes(selectedPracticeSubject.toLowerCase()) ||
            selectedPracticeSubject.toLowerCase().includes(q.subjectName.toLowerCase()) ||
            isSubjectInSelection(q.title, [selectedPracticeSubject])
          )
        );
        if (subFiltered.length > 0) list = subFiltered;
      }

      setQuizzes(list);
    } catch (err: any) {
      setQuizzes([]);
      setError(err?.message || (lang === 'km' ? 'មិនអាចទាញយកកម្រងសំណួរបានទេ' : 'Failed to load quizzes'));
    } finally {
      setStage('lobby');
      setLoading(false);
    }
  };

  const loadMockExam = async (setNum: number = 1) => {
    setLoading(true);
    setError(null);
    try {
      const targetExam = userProfile?.targetExam || 'nie';

      let candidateSpecializations: string[] = [];
      if (userProfile?.selectedSubjects && userProfile.selectedSubjects.length > 0) {
        candidateSpecializations = userProfile.selectedSubjects;
      } else if (selectedPracticeSubject) {
        candidateSpecializations = [selectedPracticeSubject];
      }

      // Authentic Cambodian Teacher Recruitment Exam multi-subject structure:
      // 1. General Knowledge (វប្បធម៌ទូទៅ)
      // 2. English (ភាសាអង់គ្លេស)
      // 3. Candidate Specialization (ឯកទេស)
      const subjectQueue: { name: string; isCore: boolean }[] = [
        { name: 'General Knowledge', isCore: true },
        { name: 'English', isCore: true },
      ];

      if (candidateSpecializations.length > 0) {
        for (const spec of candidateSpecializations) {
          const lower = spec.toLowerCase();
          if (
            !lower.includes('general') &&
            !lower.includes('culture') &&
            !lower.includes('knowledge') &&
            !lower.includes('english') &&
            !lower.includes('អង់គ្លេស') &&
            !lower.includes('វប្បធម៌')
          ) {
            subjectQueue.push({ name: spec, isCore: false });
          }
        }
      } else {
        if (targetExam === 'pttc') {
          subjectQueue.push({ name: 'Mathematics', isCore: false });
          subjectQueue.push({ name: 'Khmer Literature', isCore: false });
        } else {
          subjectQueue.push({ name: 'Mathematics', isCore: false });
        }
      }

      const papers: MockSubjectPaper[] = [];
      const savedPapers: Record<number, SavedProgress> = {};

      for (const item of subjectQueue) {
        try {
          const qListRes = await getQuizzes({
            targetExam,
            subjectName: item.name,
          });
          const quizzesList = qListRes.quizzes || [];
          if (quizzesList.length === 0) continue;

          // Find quiz corresponding to setNum (វិញ្ញាសាទី ១, ២, ៣, ៤, ៥)
          const targetKmNum = toKhmerNumeral(setNum);
          let matchedQuiz = quizzesList.find((q: any) =>
            q.title && (
              q.title.includes(`វិញ្ញាសាទី ${targetKmNum}`) ||
              q.title.includes(`វិញ្ញាសាទី${targetKmNum}`) ||
              q.title.includes(`វិញ្ញាសាទី ${setNum}`) ||
              q.title.includes(`វិញ្ញាសាទី${setNum}`) ||
              q.title.includes(`Set ${setNum}`)
            )
          );
          if (!matchedQuiz) {
            matchedQuiz = quizzesList[(setNum - 1) % quizzesList.length] || quizzesList[0];
          }

          const quizDetailRes = await getQuiz(matchedQuiz.quizId);
          const fullQuiz = quizDetailRes.quiz;
          if (!fullQuiz || !fullQuiz.questions || fullQuiz.questions.length === 0) continue;

          // Reuse this paper's attempt if a crash or reload left it open.
          const saved = await findOpenAttempt(mockProgressKey(setNum, matchedQuiz.quizId));
          let attemptId: number | null = saved?.attemptId ?? null;
          if (saved) {
            savedPapers[matchedQuiz.quizId] = saved;
          } else {
            try {
              const attRes = await startAttempt({ attemptType: 'quiz', quizId: matchedQuiz.quizId });
              attemptId = attRes.attempt.attemptId;
            } catch (attErr) {
              console.warn('Could not start attempt for quiz', matchedQuiz.quizId, attErr);
            }
          }

          const meta = getSubjectMeta(fullQuiz.subjectName || item.name, targetExam);

          papers.push({
            subjectId: String(fullQuiz.subjectId || matchedQuiz.subjectId || item.name),
            subjectName: fullQuiz.subjectName || item.name,
            subjectNameKm: meta.nameKm || formatSubjectName(fullQuiz.subjectName || item.name, 'km'),
            subjectNameEn: meta.nameEn || formatSubjectName(fullQuiz.subjectName || item.name, 'en'),
            quizId: matchedQuiz.quizId,
            attemptId,
            title: fullQuiz.title || matchedQuiz.title,
            questions: fullQuiz.questions,
            answers: {},
          });
        } catch (err) {
          console.error('Failed to load mock exam paper for subject', item.name, err);
        }
      }

      if (papers.length === 0) {
        throw new Error(lang === 'km' ? 'មិនអាចទាញយកវិញ្ញាសាប្រឡងសាកល្បងបានទេ' : 'Failed to load mock exam papers');
      }

      setMockPapers(papers);

      // If user selected a specific subject, start on that subject tab
      if (selectedPracticeSubject) {
        const foundIdx = papers.findIndex((p) =>
          p.subjectName.toLowerCase().includes(selectedPracticeSubject.toLowerCase()) ||
          p.subjectNameKm.toLowerCase().includes(selectedPracticeSubject.toLowerCase()) ||
          selectedPracticeSubject.toLowerCase().includes(p.subjectNameKm.toLowerCase())
        );
        setActivePaperIndex(foundIdx >= 0 ? foundIdx : 0);
      } else {
        setActivePaperIndex(0);
      }

      setCurrentIndex(0);
      setMockResult(null);
      // Realistic official Cambodian teacher recruitment exam duration: 120 minutes (7,200 seconds)
      // A resumed exam keeps the time it had left at its last saved answer.
      const savedTimes = Object.values(savedPapers)
        .map((s) => s.timeLeft)
        .filter((t): t is number => typeof t === 'number' && t > 0);
      setTimeLeft(savedTimes.length > 0 ? Math.min(...savedTimes) : 120 * 60);
      if (Object.values(savedPapers).some((s) => Object.keys(s.answers).length > 0)) {
        setPendingResume({ kind: 'mock', saved: savedPapers });
      }
      setStage('taking');
    } catch (err: any) {
      setError(err?.message || (lang === 'km' ? 'មិនអាចចាប់ផ្តើមការប្រឡងសាកល្បងបានទេ' : 'Failed to start mock exam'));
      setStage('lobby');
    } finally {
      setLoading(false);
    }
  };

  const openQuiz = async (quizId: number, rawQuizId?: string) => {
    setLoading(true);
    setError(null);
    setCurrentQuizKey(rawQuizId || String(quizId));
    try {
      // Reuse the attempt left open by a crash or reload instead of starting another one.
      const [quizRes, saved] = await Promise.all([
        getQuiz(quizId),
        findOpenAttempt(quizProgressKey(quizId)),
      ]);
      const fullTime = (quizRes.quiz.durationMinutes || 50) * 60;
      setQuiz({ ...quizRes.quiz, questions: quizRes.quiz?.questions || [] });
      setAnswers({});
      setCurrentIndex(0);
      setResult(null);
      if (saved) {
        setAttemptId(saved.attemptId);
        setTimeLeft(saved.timeLeft && saved.timeLeft > 0 ? saved.timeLeft : fullTime);
        if (Object.keys(saved.answers).length > 0) setPendingResume({ kind: 'quiz', saved, fullTime });
      } else {
        const attempt = await startAttempt({ attemptType: 'quiz', quizId });
        setAttemptId(attempt.attempt.attemptId);
        setTimeLeft(fullTime);
      }
      setStage('taking');
    } catch (err: any) {
      setError(err?.message || 'Failed to start quiz');
      setStage('lobby');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async () => {
    if (!quiz || !attemptId || submitting) return;
    setSubmitting(true);
    setError(null);
    setTimeLeft(null);
    try {
      const payload = (quiz.questions || []).map((q) => ({
        questionId: q.questionId,
        selectedOptionId: answers[q.questionId] ?? null,
      }));
      const result = await submitOrRecover(attemptId, payload);
      clearProgress(quizProgressKey(quiz.quizId));
      setResult(result);

      // Save percentage to the subject & specific quiz card
      saveSubjectScore({
        subjectId: selectedPracticeSubjectId || undefined,
        subjectName: selectedPracticeSubject || quiz?.subjectName || '',
        quizId: currentQuizKey || (quiz?.quizId ? String(quiz.quizId) : activeQuizId ? String(activeQuizId) : undefined),
        mockSetNumber: activeMockSetNumber || 1,
        targetExam: userProfile?.targetExam,
        category: isMockExam ? 'mock-exam' : 'quiz',
        round: isMockExam ? (activeMockExam?.round || 1) : undefined,
        score: result.score,
      });

      setStage('result');
    } catch (err: any) {
      // Answers stay in state, so the learner can simply tap submit again.
      setError(err?.message || (lang === 'km' ? 'មិនអាចដាក់ស្នើចម្លើយបានទេ' : 'Failed to submit quiz'));
    } finally {
      setSubmitting(false);
    }
  };

  /** Submit button: asks first when questions are still unanswered (one stray tap must not end the quiz). */
  const requestSubmit = () => {
    if (!quiz) return;
    const unanswered = (quiz.questions || []).filter((q) => answers[q.questionId] == null).length;
    if (unanswered > 0) setShowQuizSubmitConfirm(true);
    else handleSubmit();
  };

  // Warn before closing or reloading the tab mid-quiz; unsent answers would be lost.
  useEffect(() => {
    if (stage !== 'taking' || submitting) return;
    const warn = (e: BeforeUnloadEvent) => {
      e.preventDefault();
      e.returnValue = '';
    };
    window.addEventListener('beforeunload', warn);
    return () => window.removeEventListener('beforeunload', warn);
  }, [stage, submitting]);

  // Mirror every pick to localStorage. Skipped while the resume prompt is open,
  // so the empty answer map can't overwrite the saved one before the learner chooses.
  useEffect(() => {
    if (stage !== 'taking' || pendingResume || !quiz || !attemptId) return;
    writeProgress(quizProgressKey(quiz.quizId), { attemptId, answers, timeLeft, savedAt: Date.now() });
    // timeLeft is read, not watched: saving once per pick is enough.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [stage, pendingResume, quiz, attemptId, answers]);

  useEffect(() => {
    if (stage !== 'taking' || pendingResume || mockPapers.length === 0) return;
    const setNum = activeMockSetNumber || 1;
    for (const paper of mockPapers) {
      if (!paper.attemptId) continue;
      writeProgress(mockProgressKey(setNum, paper.quizId), {
        attemptId: paper.attemptId,
        answers: paper.answers,
        timeLeft,
        savedAt: Date.now(),
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [stage, pendingResume, mockPapers, activeMockSetNumber]);

  const resumeSavedAnswers = () => {
    if (!pendingResume) return;
    // Only keep answers for questions the quiz still has, so the answered count stays honest.
    const onlyCurrent = (answers: Record<number, number>, questions: { questionId: number }[]) =>
      Object.fromEntries(Object.entries(answers).filter(([id]) => questions.some((q) => q.questionId === Number(id)))) as Record<number, number>;
    if (pendingResume.kind === 'quiz') {
      setAnswers(onlyCurrent(pendingResume.saved.answers, quiz?.questions || []));
    } else {
      const saved = pendingResume.saved;
      setMockPapers((prev) =>
        prev.map((p) => (saved[p.quizId] ? { ...p, answers: onlyCurrent(saved[p.quizId].answers, p.questions || []) } : p))
      );
    }
    setPendingResume(null);
  };

  /** Drops the saved answers and opens a fresh attempt in place of each resumable one. */
  const discardSavedAnswers = async () => {
    if (!pendingResume || resumeBusy) return;
    setResumeBusy(true);
    setError(null);
    try {
      if (pendingResume.kind === 'quiz') {
        if (!quiz) return;
        clearProgress(quizProgressKey(quiz.quizId));
        const attempt = await startAttempt({ attemptType: 'quiz', quizId: quiz.quizId });
        setAttemptId(attempt.attempt.attemptId);
        setAnswers({});
        setTimeLeft(pendingResume.fullTime);
      } else {
        const setNum = activeMockSetNumber || 1;
        const fresh: Record<number, number | null> = {};
        for (const quizId of Object.keys(pendingResume.saved).map(Number)) {
          clearProgress(mockProgressKey(setNum, quizId));
          try {
            const attRes = await startAttempt({ attemptType: 'quiz', quizId });
            fresh[quizId] = attRes.attempt.attemptId;
          } catch (attErr) {
            // Submit opens one later for a paper without an attempt.
            console.warn('Could not start attempt for quiz', quizId, attErr);
            fresh[quizId] = null;
          }
        }
        setMockPapers((prev) => prev.map((p) => (p.quizId in fresh ? { ...p, attemptId: fresh[p.quizId], answers: {} } : p)));
        setTimeLeft(120 * 60);
      }
      setCurrentIndex(0);
      setPendingResume(null);
    } catch (err: any) {
      setError(err?.message || 'Failed to start quiz');
    } finally {
      setResumeBusy(false);
    }
  };

  const handleSubmitMockExam = async () => {
    if (submitting || mockPapers.length === 0) return;
    setSubmitting(true);
    setShowSubmitConfirm(false);
    setError(null);
    setTimeLeft(null);

    try {
      const subjectResults: MockExamSubjectResult[] = [];
      let totalCorrect = 0;
      let totalQuestions = 0;

      for (const paper of mockPapers) {
        let paperResult: AttemptResult;
        const payload = (paper.questions || []).map((q) => ({
          questionId: q.questionId,
          selectedOptionId: paper.answers[q.questionId] ?? null,
        }));

        if (paper.attemptId) {
          // A retry after a partial failure must not get stuck on papers that were already graded.
          paperResult = await submitOrRecover(paper.attemptId, payload);
        } else {
          const newAtt = await startAttempt({ attemptType: 'quiz', quizId: paper.quizId });
          paper.attemptId = newAtt.attempt.attemptId;
          paperResult = await submitOrRecover(newAtt.attempt.attemptId, payload);
        }
        clearProgress(mockProgressKey(activeMockSetNumber || 1, paper.quizId));

        totalCorrect += paperResult.correctCount;
        totalQuestions += paperResult.totalQuestions;

        // Save score to subjectScores for mock-exam
        saveSubjectScore({
          subjectId: paper.subjectId,
          subjectName: paper.subjectName,
          quizId: String(paper.quizId),
          mockSetNumber: activeMockSetNumber || 1,
          targetExam: userProfile?.targetExam,
          category: 'mock-exam',
          round: 1,
          score: paperResult.score,
        });

        subjectResults.push({
          subjectName: paper.subjectName,
          subjectNameKm: paper.subjectNameKm,
          subjectNameEn: paper.subjectNameEn,
          quizId: paper.quizId,
          score: paperResult.score,
          correctCount: paperResult.correctCount,
          totalQuestions: paperResult.totalQuestions,
          answers: paperResult.answers || [],
          questions: paper.questions,
        });
      }

      const totalScore = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0;
      const passed = totalScore >= 50;

      setMockResult({
        totalScore,
        totalCorrect,
        totalQuestions,
        passed,
        subjectResults,
      });

      setStage('result');
    } catch (err: any) {
      setError(err?.message || (lang === 'km' ? 'មិនអាចដាក់ស្នើការប្រឡងសាកល្បងបានទេ' : 'Failed to submit mock exam'));
    } finally {
      setSubmitting(false);
    }
  };

  const handleSelectMockOption = (qId: number, optId: number) => {
    setMockPapers((prev) => {
      const next = [...prev];
      const curPaper = { ...next[activePaperIndex] };
      const curAnswers = { ...curPaper.answers };
      if (curAnswers[qId] === optId) {
        delete curAnswers[qId];
      } else {
        curAnswers[qId] = optId;
      }
      curPaper.answers = curAnswers;
      next[activePaperIndex] = curPaper;
      return next;
    });
  };

  const handleClearMockOption = (qId: number) => {
    setMockPapers((prev) => {
      const next = [...prev];
      const curPaper = { ...next[activePaperIndex] };
      const curAnswers = { ...curPaper.answers };
      delete curAnswers[qId];
      curPaper.answers = curAnswers;
      next[activePaperIndex] = curPaper;
      return next;
    });
  };

  const returnToMockExamPage = () => {
    try {
      sessionStorage.setItem('passkru_practice_category', 'mock-exam');
    } catch { }
    resetQuizState();
    setSelectedPracticeSubject(null);
    setPracticeViewMode('subject-select');
    setCurrentPage('practice');
  };

  const resetQuizState = () => {
    setTimeLeft(null);
    setActiveMockExam(null);
    setActiveQuizId(null);
    setActiveQuiz(null);
    setCurrentQuizKey(null);
    setQuiz(null);
    setAttemptId(null);
    setResult(null);
    setMockPapers([]);
    setActivePaperIndex(0);
    setMockResult(null);
    setShowSubmitConfirm(false);
    setPendingResume(null);
  };

  // The practice page's quiz subject list, for a quiz that has neither a subject nor an origin page.
  const returnToPracticeQuizList = (replace = false) => {
    try {
      sessionStorage.setItem('passkru_practice_category', 'quiz');
    } catch { }
    resetQuizState();
    setSelectedPracticeSubject(null);
    setPracticeViewMode('subject-select');
    setCurrentPage('practice', { replace });
  };

  // Exit / back: to the page that opened the quiz (study plan, dashboard …), else the subject's quiz list.
  const backToLobby = () => {
    if (quizReturnPage) {
      const origin = quizReturnPage;
      resetQuizState();
      setCurrentPage(origin);
      return;
    }
    if (isMockExam) {
      returnToMockExamPage();
      return;
    }
    if (!selectedPracticeSubject) {
      returnToPracticeQuizList();
      return;
    }
    resetQuizState();
    setStage('lobby');
    loadLobby();
  };

  const handleRetake = () => {
    if (isMockExam) {
      loadMockExam(activeMockSetNumber || 1);
    } else if (quiz) {
      openQuiz(quiz.quizId);
    }
  };

  // Countdown Timer Effect for Mock Exam / Timed Quiz
  useEffect(() => {
    // The clock waits while the learner decides whether to resume.
    if (stage !== 'taking' || timeLeft === null || pendingResume) return;

    if (timeLeft <= 0) {
      if (isMockExam && mockPapers.length > 0) {
        handleSubmitMockExam();
      } else {
        handleSubmit();
      }
      return;
    }

    const timerId = setInterval(() => {
      setTimeLeft((prev) => (prev !== null && prev > 0 ? prev - 1 : 0));
    }, 1000);

    return () => clearInterval(timerId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [stage, timeLeft, isMockExam, mockPapers, pendingResume]);

  if (loading) {
    return (
      <div className="flex items-center justify-center py-24">
        <Loader2 className="w-8 h-8 text-indigo-600 animate-spin" />
      </div>
    );
  }

  return (
    <div className={`${stage === 'taking' ? 'max-w-7xl xl:max-w-[1440px] 2xl:max-w-[1560px]' : stage === 'lobby' ? 'max-w-7xl' : 'max-w-4xl'} mx-auto px-4 sm:px-6 lg:px-8 py-6 sm:py-8 space-y-6 animate-fadeIn`}>
      <SEOHead
        title={lang === 'km' ? 'កម្រងសំណួរប្រឡងសាកល្បង' : 'Quiz & Mock Exams'}
        description={
          lang === 'km'
            ? 'តេស្តសមត្ថភាពជាមួយកម្រងសំណួរឆ្លាតវៃ កំណត់ម៉ោងដូចការប្រឡងពិតប្រាកដ និងទទួលបានពិន្ទុភ្លាមៗ។'
            : 'Simulated timed quiz modules and mock exam scoring for Cambodian Teacher Examination preparation.'
        }
        path="/quiz"
      />
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 text-xs font-semibold px-4 py-3 rounded-xl flex items-center gap-2">
          <AlertTriangle className="w-4 h-4 shrink-0" />
          <span>{error}</span>
        </div>
      )}

      {/* ---------- Lobby ---------- */}
      {stage === 'lobby' && (
        <>
          <div className="flex flex-wrap items-center justify-between gap-4">
            <button
              type="button"
              onClick={() => {
                setSelectedPracticeSubject(null);
                setPracticeViewMode('subject-select');
                setCurrentPage('practice');
              }}
              className="inline-flex items-center gap-2 px-4 py-2 rounded-2xl text-xs sm:text-sm font-bold text-slate-700 bg-white hover:bg-slate-100 border border-slate-200 shadow-2xs transition cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4" />
              <span>{lang === 'km' ? 'ថយក្រោយ' : 'Back'}</span>
            </button>
          </div>


          {quizzes.length === 0 ? (
            <div className="bg-white rounded-2xl border border-dashed border-slate-300 p-10 text-center space-y-3">
              <p className="text-sm text-slate-500">
                {lang === 'km' ? 'មិនទាន់មានកម្រងសំណួរសម្រាប់មុខវិជ្ជាដែលបានជ្រើសនៅឡើយទេ' : 'No quizzes available for your selected subjects yet'}
              </p>
              <button
                type="button"
                onClick={() => openExamSelection()}
                className="inline-flex items-center gap-1.5 px-4 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold transition cursor-pointer"
              >
                <RefreshCw className="w-3.5 h-3.5" />
                <span>{lang === 'km' ? 'ផ្លាស់ប្តូរក្របខណ្ឌប្រឡង' : 'Change Exam Category'}</span>
              </button>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-5">
              {quizzes.map((q) => (
                <div
                  key={q.rawQuizId || q.quizId}
                  className="bg-white rounded-2xl border border-slate-200 hover:border-[#0f3360]/40 hover:shadow-md transition p-5 shadow-xs flex flex-col justify-between gap-4"
                >
                  <div className="flex items-start justify-between gap-2">
                    <div className="space-y-2">
                      <h3 className="text-sm sm:text-base font-black text-slate-900 leading-snug">
                        {(q.title || '').replace(/ឈុត/g, 'វិញ្ញាសារ')}
                      </h3>
                      <div className="flex flex-wrap items-center gap-2 text-xs font-semibold text-slate-500 pt-0.5">
                        <span className="inline-flex items-center gap-1">
                          <Layers className="w-3.5 h-3.5 text-indigo-500" />
                          {q.totalQuestions} {lang === 'km' ? 'សំណួរ' : 'questions'}
                        </span>
                        <span>•</span>
                        <span className="inline-flex items-center gap-1">
                          <Clock className="w-3.5 h-3.5 text-slate-400" />
                          {q.durationMinutes ? `${q.durationMinutes} ${lang === 'km' ? 'នាទី' : 'min'}` : '50 min'}
                        </span>
                      </div>
                    </div>
                    {(() => {
                      const currentTarget = userProfile?.targetExam || 'nie';
                      const cardQuizId = q.rawQuizId;
                      if (!cardQuizId) return null;

                      // Strictly show percentage ONLY on this exact card in the active category
                      const qScore = subjectScores[`${currentTarget}::${cardQuizId}`]?.quizScore;
                      if (qScore === undefined) return null;

                      return (
                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold shadow-xs shrink-0 ${qScore >= 50
                          ? 'bg-emerald-600 text-white'
                          : 'bg-rose-600 text-white'
                          }`}>
                          <span>{qScore}%</span>
                        </span>
                      );
                    })()}
                  </div>
                  <button
                    onClick={() => openQuiz(q.quizId, q.rawQuizId)}
                    disabled={q.totalQuestions === 0}
                    className="w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl bg-[#0f3360] hover:bg-[#12427d] disabled:opacity-50 text-white text-xs font-bold transition shadow-xs cursor-pointer"
                  >
                    <Play className="w-3.5 h-3.5 fill-white" />
                    <span>{lang === 'km' ? 'ចាប់ផ្តើមធ្វើ Quiz នេះ' : 'Start This Quiz'}</span>
                  </button>
                </div>
              ))}
            </div>
          )}
        </>
      )}

      {/* ---------- Taking ---------- */}
      {stage === 'taking' && isMockExam && mockPapers.length > 0 && (() => {
        const currentPaper = mockPapers[activePaperIndex] || mockPapers[0];
        const paperQuestions = currentPaper?.questions || [];
        const currentQ = paperQuestions[currentIndex];
        const hasCurrentAnswer = currentQ ? currentPaper.answers[currentQ.questionId] !== undefined : false;

        const totalMockQuestions = mockPapers.reduce((sum, p) => sum + p.questions.length, 0);
        const totalMockAnswered = mockPapers.reduce((sum, p) => sum + Object.keys(p.answers).length, 0);
        const currentPaperAnswered = Object.keys(currentPaper.answers).length;

        const levelTag = getExamCategoryTag(userProfile?.targetExam || 'nie', lang);
        const formatLevel = (tag: string) => {
          if (tag.includes('ឧត្តម') || userProfile?.targetExam === 'nie') return 'ថ្នាក់ឧត្តម (វិទ្យាស្ថានជាតិអប់រំ NIE)';
          if (tag.includes('មូលដ្ឋាន') || userProfile?.targetExam === 'rttc') return 'ថ្នាក់មូលដ្ឋាន (គរុកោសល្យភូមិភាគ RTTC)';
          if (tag.includes('បឋម') || userProfile?.targetExam === 'pttc') return 'ថ្នាក់បឋមសិក្សា (គរុកោសល្យរាជធានី-ខេត្ត PTTC)';
          return tag;
        };
        const levelText = formatLevel(levelTag);

        return (
          <div className="space-y-6">
            {/* 1. Official Royal Cambodian Examination Header */}
            <div className="bg-gradient-to-b from-amber-50/70 via-white to-amber-50/40 rounded-3xl border-2 border-amber-200/80 p-5 sm:p-7 shadow-xs text-center space-y-2 relative overflow-hidden">
              <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#0a3263] via-amber-400 to-[#0a3263]" />
              <div className="space-y-1">
                <p className="text-base sm:text-xl font-black tracking-widest text-[#0a3263] font-serif">
                  ព្រះរាជាណាចក្រកម្ពុជា
                </p>
                <p className="text-xs sm:text-sm font-extrabold tracking-wider text-amber-700">
                  ជាតិ សាសនា ព្រះមហាក្សត្រ
                </p>
                <div className="w-28 h-0.5 bg-gradient-to-r from-transparent via-amber-500 to-transparent mx-auto my-1" />
              </div>

              <div className="flex flex-col sm:flex-row items-center justify-between gap-2 pt-2 border-t border-amber-200/50 text-xs sm:text-sm">
                <div className="font-extrabold text-[#0a3263] flex items-center gap-1.5">
                  <ShieldCheck className="w-4 h-4 text-amber-600 shrink-0" />
                  <span>ក្រសួងអប់រំ យុវជន និងកីឡា</span>
                </div>
                <div className="font-black text-slate-900 bg-amber-100/70 px-3 py-1 rounded-full text-xs">
                  វិញ្ញាសាប្រឡងប្រជែងជ្រើសរើសគ្រូបង្រៀន • {levelText}
                </div>
                <div className="font-bold text-slate-600">
                  សម័យប្រឡង៖ ២០២៤-២០២៥
                </div>
              </div>
            </div>

            {/* 2. Top Info & Live Timer Bar */}
            <div className="flex flex-wrap items-center justify-between gap-4 bg-white rounded-2xl border border-slate-200 p-4 shadow-xs">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="px-2.5 py-0.5 rounded-full text-xs font-black bg-[#0a3263] text-white">
                    វិញ្ញាសាទី {toKhmerNumeral(activeMockSetNumber || 1)}
                  </span>
                  <h2 className="text-sm sm:text-base font-extrabold text-slate-900">
                    ការប្រឡងសាកល្បងផ្លូវការ (រួមបញ្ចូល {toKhmerNumeral(mockPapers.length)} មុខវិជ្ជា)
                  </h2>
                </div>
                <p className="text-xs font-semibold text-slate-500">
                  បានឆ្លើយសរុប៖ <span className="font-bold text-[#0a3263]">{toKhmerNumeral(totalMockAnswered)}</span> / {toKhmerNumeral(totalMockQuestions)} សំណួរ • មុខវិជ្ជាបច្ចុប្បន្ន៖ <span className="font-bold text-indigo-700">{currentPaper.subjectNameKm}</span> ({toKhmerNumeral(currentPaperAnswered)}/{toKhmerNumeral(paperQuestions.length)})
                </p>
              </div>

              <div className="flex items-center gap-3">
                {/* Timer Display */}
                {timeLeft !== null && (
                  <div
                    className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs sm:text-sm font-mono font-black shadow-xs transition-all border ${
                      timeLeft < 600
                        ? 'bg-rose-50 text-rose-700 border-rose-300 animate-pulse'
                        : 'bg-[#0a3263] text-white border-[#0a3263]'
                    }`}
                    title={formatTimeKm(timeLeft)}
                  >
                    <Clock className={`w-4 h-4 ${timeLeft < 600 ? 'text-rose-600' : 'text-amber-300'}`} />
                    <span>នៅសល់៖ {formatTime(timeLeft)}</span>
                  </div>
                )}

                <button
                  type="button"
                  onClick={backToLobby}
                  className="px-3.5 py-2 rounded-xl border border-slate-200 text-xs font-bold text-slate-600 hover:text-rose-600 hover:bg-rose-50 transition cursor-pointer"
                >
                  {lang === 'km' ? 'ចាកចេញ' : 'Exit'}
                </button>
              </div>
            </div>

            {/* 3. Multi-Subject Stepper / Tabs Bar */}
            <div className="bg-slate-100/80 p-1.5 rounded-2xl border border-slate-200/80">
              <div className="text-[11px] font-bold text-slate-500 px-3 py-1 flex items-center justify-between">
                <span>មុខវិជ្ជាប្រឡង ({toKhmerNumeral(mockPapers.length)} មុខវិជ្ជា)៖</span>
                <span className="text-[11px] text-slate-400">ចុចលើមុខវិជ្ជា ឬប្រើប៊ូតុងខាងក្រោមដើម្បីប្តូរមុខវិជ្ជា</span>
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 pt-1">
                {mockPapers.map((paper, pIdx) => {
                  const isCurrent = pIdx === activePaperIndex;
                  const answeredCount = Object.keys(paper.answers).length;
                  const totalQ = paper.questions.length;
                  const isCompleted = answeredCount === totalQ && totalQ > 0;

                  return (
                    <button
                      key={paper.quizId || pIdx}
                      type="button"
                      onClick={() => {
                        setActivePaperIndex(pIdx);
                        setCurrentIndex(0);
                      }}
                      className={`flex items-center justify-between gap-3 px-4 py-3 rounded-xl text-left transition-all cursor-pointer border ${
                        isCurrent
                          ? 'bg-[#0a3263] text-white border-[#0a3263] shadow-sm ring-2 ring-[#0a3263]/20'
                          : 'bg-white text-slate-800 hover:bg-slate-50 border-slate-200'
                      }`}
                    >
                      <div className="flex items-center gap-2.5 min-w-0">
                        <span
                          className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-black shrink-0 ${
                            isCurrent
                              ? 'bg-amber-400 text-slate-900'
                              : isCompleted
                              ? 'bg-emerald-100 text-emerald-800'
                              : 'bg-slate-100 text-slate-700'
                          }`}
                        >
                          {toKhmerNumeral(pIdx + 1)}
                        </span>
                        <div className="truncate">
                          <p className={`text-xs sm:text-sm font-black truncate ${isCurrent ? 'text-white' : 'text-slate-900'}`}>
                            {paper.subjectNameKm}
                          </p>
                          <p className={`text-[11px] ${isCurrent ? 'text-blue-200' : 'text-slate-500'}`}>
                            {paper.questions.length} សំណួរ
                          </p>
                        </div>
                      </div>

                      <div className="flex items-center gap-1.5 shrink-0">
                        <span
                          className={`text-[11px] font-bold px-2 py-0.5 rounded-full ${
                            isCurrent
                              ? 'bg-white/20 text-white'
                              : isCompleted
                              ? 'bg-emerald-100 text-emerald-700'
                              : 'bg-slate-100 text-slate-600'
                          }`}
                        >
                          {toKhmerNumeral(answeredCount)}/{toKhmerNumeral(totalQ)}
                        </span>
                        {isCompleted && (
                          <CheckCircle2 className={`w-4 h-4 ${isCurrent ? 'text-amber-300' : 'text-emerald-500'}`} />
                        )}
                      </div>
                    </button>
                  );
                })}
              </div>
            </div>

            {/* 4. Active Question View (Responsive Layout) */}
            {paperQuestions.length === 0 ? (
              <div className="bg-white rounded-2xl border border-slate-200 p-8 text-center text-sm text-slate-500">
                មុខវិជ្ជានេះមិនទាន់មានសំណួរនៅឡើយទេ។
              </div>
            ) : (
              <div className="flex flex-col lg:flex-row gap-5 items-start">
                {/* Left/Main Column: Question Card */}
                <div className="flex-1 min-w-0 w-full">
                  {currentQ && (
                    <div className="bg-white rounded-3xl border border-slate-200 p-6 sm:p-8 shadow-xs flex flex-col justify-between min-h-[460px] space-y-6">
                      <div className="space-y-5">
                        {/* Question Title & Action */}
                        <div className="flex items-start justify-between gap-4 pb-3 border-b border-slate-100">
                          <div>
                            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-black bg-indigo-50 text-indigo-700">
                              <span>{currentPaper.subjectNameKm}</span>
                              <span>•</span>
                              <span>សំណួរទី {toKhmerNumeral(currentIndex + 1)} នៃ {toKhmerNumeral(paperQuestions.length)}</span>
                            </div>
                          </div>

                          {hasCurrentAnswer && (
                            <button
                              type="button"
                              onClick={() => handleClearMockOption(currentQ.questionId)}
                              className="shrink-0 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-500 hover:text-rose-600 hover:bg-rose-50 border border-slate-200 hover:border-rose-200 transition cursor-pointer"
                              title="ដកការជ្រើសរើសចម្លើយ"
                            >
                              <RotateCcw className="w-3 h-3" />
                              <span>ដកចម្លើយ</span>
                            </button>
                          )}
                        </div>

                        {/* Question Stem */}
                        <div className="text-base sm:text-lg font-bold text-slate-900 leading-relaxed">
                          <MathText text={currentQ.questionText} />
                        </div>

                        {/* Options List */}
                        <div className="space-y-3 pt-2">
                          {(currentQ.options || []).map((opt) => {
                            const selected = currentPaper.answers[currentQ.questionId] === opt.optionId;
                            return (
                              <button
                                key={opt.optionId}
                                type="button"
                                onClick={() => handleSelectMockOption(currentQ.questionId, opt.optionId)}
                                className={`w-full text-left py-3.5 px-5 rounded-2xl border transition-all cursor-pointer flex items-center gap-4 group ${
                                  selected
                                    ? 'bg-[#0a3263]/10 border-[#0a3263] text-[#0a3263] font-bold ring-2 ring-[#0a3263]/20 shadow-xs'
                                    : 'bg-white border-slate-200 text-slate-700 hover:border-[#0a3263]/40 hover:bg-slate-50/60'
                                }`}
                              >
                                <div
                                  className={`w-4 h-4 rounded-full border flex items-center justify-center shrink-0 transition-colors ${
                                    selected
                                      ? 'border-[#0a3263] bg-[#0a3263]'
                                      : 'border-slate-300 group-hover:border-slate-400 bg-white'
                                  }`}
                                >
                                  {selected && <div className="w-1.5 h-1.5 rounded-full bg-white" />}
                                </div>
                                <div className="flex-1 text-sm font-medium leading-relaxed">
                                  <MathText text={opt.optionText} />
                                </div>
                              </button>
                            );
                          })}
                        </div>
                      </div>

                      {/* Intra-Subject Question Navigation */}
                      <div className="flex items-center justify-between pt-6 border-t border-slate-100">
                        <button
                          type="button"
                          onClick={() => setCurrentIndex((i) => Math.max(0, i - 1))}
                          disabled={currentIndex === 0}
                          className="inline-flex items-center gap-1.5 px-4 sm:px-5 py-2.5 rounded-xl border border-slate-200 bg-white text-slate-600 hover:bg-slate-50 text-xs sm:text-sm font-bold shadow-2xs transition disabled:opacity-40 disabled:cursor-not-allowed cursor-pointer"
                        >
                          <ArrowLeft className="w-3.5 h-3.5" />
                          <span>សំណួរមុន</span>
                        </button>

                        <span className="text-xs font-bold text-slate-400">
                          {toKhmerNumeral(currentIndex + 1)} / {toKhmerNumeral(paperQuestions.length)}
                        </span>

                        {currentIndex < paperQuestions.length - 1 ? (
                          <button
                            type="button"
                            onClick={() => setCurrentIndex((i) => Math.min(paperQuestions.length - 1, i + 1))}
                            className="inline-flex items-center gap-1.5 px-4 sm:px-5 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs sm:text-sm font-bold shadow-xs transition cursor-pointer"
                          >
                            <span>សំណួរបន្ទាប់</span>
                            <ArrowRight className="w-3.5 h-3.5" />
                          </button>
                        ) : activePaperIndex < mockPapers.length - 1 ? (
                          <button
                            type="button"
                            onClick={() => {
                              setActivePaperIndex((i) => i + 1);
                              setCurrentIndex(0);
                            }}
                            className="inline-flex items-center gap-1.5 px-4 sm:px-5 py-2.5 rounded-xl bg-[#0a3263] hover:bg-[#082447] text-white text-xs sm:text-sm font-bold shadow-xs transition cursor-pointer"
                          >
                            <span>បន្តទៅមុខវិជ្ជាបន្ទាប់</span>
                            <ArrowRight className="w-3.5 h-3.5 text-amber-300" />
                          </button>
                        ) : (
                          <button
                            type="button"
                            onClick={() => setShowSubmitConfirm(true)}
                            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs sm:text-sm font-bold shadow-xs transition cursor-pointer"
                          >
                            <CheckCircle2 className="w-4 h-4" />
                            <span>បញ្ចប់ការប្រឡង</span>
                          </button>
                        )}
                      </div>
                    </div>
                  )}
                </div>

                {/* Right Column: Question Navigator Palette */}
                <div className="w-full lg:w-[280px] shrink-0">
                  <div className="bg-white rounded-3xl border border-slate-200 p-5 shadow-xs space-y-4 lg:sticky lg:top-24">
                    <div className="flex items-center justify-between pb-1 border-b border-slate-100 text-xs">
                      <div className="flex items-center gap-1.5 font-bold text-slate-900">
                        <CheckSquare className="w-4 h-4 text-[#0a3263]" />
                        <span>សំណួរក្នុងមុខវិជ្ជានេះ</span>
                      </div>
                      <span className="text-[11px] font-bold text-indigo-600">
                        {toKhmerNumeral(currentPaperAnswered)} / {toKhmerNumeral(paperQuestions.length)}
                      </span>
                    </div>

                    <div className="grid grid-cols-5 gap-2 max-h-[300px] overflow-y-auto p-0.5">
                      {paperQuestions.map((qItem, qIdx) => {
                        const isAnswered = currentPaper.answers[qItem.questionId] !== undefined;
                        const isCurrent = currentIndex === qIdx;
                        return (
                          <button
                            key={qItem.questionId || qIdx}
                            type="button"
                            onClick={() => setCurrentIndex(qIdx)}
                            className={`h-9 w-full rounded-xl text-xs font-black transition flex items-center justify-center cursor-pointer shadow-2xs ${
                              isCurrent
                                ? 'bg-[#0a3263] text-white shadow-sm ring-2 ring-[#0a3263]/30'
                                : isAnswered
                                ? 'bg-emerald-100 text-emerald-800 border border-emerald-300'
                                : 'bg-slate-100 text-slate-700 hover:bg-slate-200 border border-slate-200'
                            }`}
                          >
                            {toKhmerNumeral(qIdx + 1)}
                          </button>
                        );
                      })}
                    </div>

                    <div className="flex items-center justify-center gap-4 text-[11px] text-slate-500 pt-2 border-t border-slate-100">
                      <div className="flex items-center gap-1">
                        <span className="w-2 h-2 rounded-full bg-[#0a3263]" />
                        <span>កំពុងធ្វើ</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <span className="w-2 h-2 rounded-full bg-emerald-500" />
                        <span>បានឆ្លើយ</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <span className="w-2 h-2 rounded-full bg-slate-300" />
                        <span>មិនទាន់ឆ្លើយ</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* 5. Sequential Multi-Subject Navigation Bar (Prominent at Bottom) */}
            <div className="bg-white rounded-3xl border border-slate-200 p-5 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
              <div>
                {activePaperIndex > 0 ? (
                  <button
                    type="button"
                    onClick={() => {
                      setActivePaperIndex((i) => i - 1);
                      setCurrentIndex(0);
                    }}
                    className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-5 py-3 rounded-2xl border-2 border-slate-200 hover:border-slate-300 bg-white text-slate-700 text-xs sm:text-sm font-bold shadow-2xs transition cursor-pointer"
                  >
                    <ArrowLeft className="w-4 h-4 text-[#0a3263]" />
                    <span>ត្រឡប់ទៅមុខវិជ្ជាមុន ({mockPapers[activePaperIndex - 1].subjectNameKm})</span>
                  </button>
                ) : (
                  <div className="text-xs font-semibold text-slate-400">
                    មុខវិជ្ជាដំបូង ({currentPaper.subjectNameKm})
                  </div>
                )}
              </div>

              <div className="flex flex-col sm:flex-row items-center gap-3 w-full sm:w-auto">
                {activePaperIndex < mockPapers.length - 1 ? (
                  <button
                    type="button"
                    onClick={() => {
                      setActivePaperIndex((i) => i + 1);
                      setCurrentIndex(0);
                    }}
                    className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3 rounded-2xl bg-[#0a3263] hover:bg-[#082447] text-white text-xs sm:text-sm font-black shadow-md transition cursor-pointer"
                  >
                    <span>បន្តទៅមុខវិជ្ជាបន្ទាប់ ({mockPapers[activePaperIndex + 1].subjectNameKm})</span>
                    <ArrowRight className="w-4 h-4 text-amber-300" />
                  </button>
                ) : null}

                <button
                  type="button"
                  onClick={() => setShowSubmitConfirm(true)}
                  disabled={submitting}
                  className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3 rounded-2xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs sm:text-sm font-black shadow-md transition cursor-pointer"
                >
                  <CheckCircle2 className="w-4 h-4 text-white" />
                  <span>បញ្ចប់ និងដាក់ស្នើការប្រឡងទាំងមូល</span>
                </button>
              </div>
            </div>

            {/* 6. Submit Confirmation Modal in Khmer */}
            {showSubmitConfirm && (
              <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs animate-fadeIn">
                <div className="bg-white rounded-3xl border border-slate-200 max-w-lg w-full p-6 sm:p-8 space-y-6 shadow-2xl animate-scaleUp">
                  <div className="text-center space-y-2">
                    <div className="w-12 h-12 rounded-2xl bg-amber-100 text-amber-700 flex items-center justify-center mx-auto">
                      <HelpCircle className="w-6 h-6" />
                    </div>
                    <h3 className="text-lg sm:text-xl font-black text-slate-900">
                      បញ្ជាក់ការបញ្ចប់ និងដាក់ស្នើការប្រឡងសាកល្បង
                    </h3>
                    <p className="text-xs sm:text-sm text-slate-600 leading-relaxed">
                      អ្នកបានឆ្លើយចំនួន <span className="font-bold text-[#0a3263]">{toKhmerNumeral(totalMockAnswered)}</span> ក្នុងចំណោម <span className="font-bold text-slate-900">{toKhmerNumeral(totalMockQuestions)}</span> សំណួរ (នៅសល់ <span className="font-bold text-rose-600">{toKhmerNumeral(totalMockQuestions - totalMockAnswered)}</span> មិនទាន់ឆ្លើយ)។
                    </p>
                  </div>

                  {/* Summary of each subject */}
                  <div className="space-y-2 max-h-48 overflow-y-auto p-1 bg-slate-50 rounded-2xl border border-slate-100">
                    {mockPapers.map((p, idx) => {
                      const ansCount = Object.keys(p.answers).length;
                      const isAll = ansCount === p.questions.length;
                      return (
                        <div key={idx} className="flex items-center justify-between p-3 rounded-xl bg-white border border-slate-200/60 text-xs font-bold">
                          <span className="text-slate-800">{p.subjectNameKm}</span>
                          <span className={`px-2.5 py-0.5 rounded-full text-[11px] ${isAll ? 'bg-emerald-100 text-emerald-800' : 'bg-amber-100 text-amber-800'}`}>
                            បានឆ្លើយ {toKhmerNumeral(ansCount)} / {toKhmerNumeral(p.questions.length)}
                          </span>
                        </div>
                      );
                    })}
                  </div>

                  <div className="flex flex-col sm:flex-row items-center justify-end gap-3 pt-2">
                    <button
                      type="button"
                      onClick={() => setShowSubmitConfirm(false)}
                      className="w-full sm:w-auto px-5 py-2.5 rounded-xl border border-slate-200 text-slate-700 hover:bg-slate-100 text-xs sm:text-sm font-bold transition cursor-pointer"
                    >
                      ត្រឡប់ទៅពិនិត្យឡើងវិញ
                    </button>
                    <button
                      type="button"
                      onClick={handleSubmitMockExam}
                      disabled={submitting}
                      className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs sm:text-sm font-black shadow-sm transition cursor-pointer"
                    >
                      {submitting && <Loader2 className="w-4 h-4 animate-spin" />}
                      <span>យល់ព្រម ដាក់ស្នើការប្រឡង</span>
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        );
      })()}

      {/* ---------- Taking (Single Quiz) ---------- */}
      {stage === 'taking' && !isMockExam && quiz && (() => {
        const cleanQuizTitle = (quiz.title || '').replace(/ឈុត/g, 'វិញ្ញាសារ');
        const levelTag = getExamCategoryTag(userProfile?.targetExam || 'nie', lang);
        const formatLevel = (tag: string) => {
          if (tag.includes('ឧត្តម')) return 'ថ្នាក់ឧត្តម';
          if (tag.includes('មូលដ្ឋាន')) return 'ថ្នាក់មូលដ្ឋាន';
          if (tag.includes('បឋម')) return 'ថ្នាក់បឋម';
          return tag;
        };
        const levelText = formatLevel(levelTag);
        const localizedSubject = formatSubjectName(quiz.subjectName, lang);
        const fullExamTitle = cleanQuizTitle.includes(localizedSubject) || (quiz.subjectName && cleanQuizTitle.includes(quiz.subjectName))
          ? cleanQuizTitle
          : localizedSubject
            ? `${localizedSubject}${levelText ? ` (${levelText})` : ''} - ${cleanQuizTitle}`
            : cleanQuizTitle;
        const answeredCount = Object.keys(answers).length;
        const totalQuestions = quiz.questions.length;
        const toKhmerNumeral = (num: number | string) =>
          String(num).replace(/[0-9]/g, (d) => '០១២៣៤៥៦៧៨៩'[Number(d)]);

        const currentQ = quiz.questions[currentIndex];
        const hasCurrentAnswer = currentQ ? answers[currentQ.questionId] !== undefined : false;

        return (
          <>
            {/* Exam Header */}
            <div className="flex items-start justify-between gap-4 pb-2">
              <div className="space-y-1">
                <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight">
                  {fullExamTitle}
                </h1>
                <p className="text-xs sm:text-sm font-medium text-slate-500">
                  {localizedSubject ? `${localizedSubject} • ` : ''}{answeredCount}/{totalQuestions} {lang === 'km' ? 'បានឆ្លើយ' : 'answered'}
                </p>
                {/* Accent Purple Indicator Line */}
                <div className="w-12 h-1 bg-indigo-600 rounded-full mt-2.5" />
              </div>
              <div className="flex items-center gap-4 pt-1">
                {/* Active Countdown Timer Display */}
                {timeLeft !== null && (
                  <div
                    id="mock-exam-timer"
                    className="flex items-center gap-2 px-4 py-2 rounded-xl bg-indigo-50/90 text-indigo-700 text-xs sm:text-sm font-mono font-bold shadow-2xs transition-all"
                    title={lang === 'km' ? 'ពេលវេលានៅសល់' : 'Time remaining'}
                  >
                    <Clock className="w-4 h-4 text-indigo-600" />
                    <span>{formatTime(timeLeft)}</span>
                  </div>
                )}

                <button
                  type="button"
                  onClick={backToLobby}
                  className="text-xs sm:text-sm font-semibold text-slate-500 hover:text-slate-800 transition cursor-pointer"
                >
                  {lang === 'km' ? 'ចាកចេញ' : 'Exit'}
                </button>
              </div>
            </div>

            {totalQuestions === 0 ? (
              <div className="bg-white rounded-2xl border border-slate-200 p-8 text-center text-sm text-slate-500">
                {lang === 'km' ? 'កម្រងសំណួរនេះមិនទាន់មានសំណួរទេ' : 'This quiz has no questions yet'}
              </div>
            ) : (
              <>
                {/* ========================================================= */}
                {/* MOBILE SCREEN LAYOUT (< lg) - Unchanged Single-Column     */}
                {/* ========================================================= */}
                <div className="block lg:hidden space-y-5">
                  {/* Progress bar on mobile */}
                  <div className="w-full bg-slate-100 rounded-full h-1.5 overflow-hidden">
                    <div
                      className="bg-indigo-600 h-full rounded-full transition-all duration-300"
                      style={{ width: `${((currentIndex + 1) / totalQuestions) * 100}%` }}
                    />
                  </div>

                  {/* Question Quick-Jump Palette for mobile */}
                  {totalQuestions > 5 && (
                    <div className="bg-white rounded-2xl border border-slate-200 p-4 space-y-2.5 shadow-2xs animate-fadeIn">
                      <div className="flex items-center justify-between text-xs font-bold text-slate-700">
                        <div className="flex items-center gap-2">
                          <ListChecks className="w-4 h-4 text-[#0f3360]" />
                          <span>
                            {lang === 'km'
                              ? `ផ្ទាំងរុករកសំណួរ (${toKhmerNumeral(totalQuestions)} សំណួរ)`
                              : `Question navigation (${totalQuestions} questions)`}
                          </span>
                        </div>
                        <span className="text-xs font-extrabold text-[#0f3360]">
                          {answeredCount} / {totalQuestions} {lang === 'km' ? 'បានឆ្លើយ' : 'answered'}
                        </span>
                      </div>
                      <div className="flex flex-wrap gap-1.5 max-h-32 overflow-y-auto p-1">
                        {quiz.questions.map((qItem, qIdx) => {
                          const isAnswered = answers[qItem.questionId] !== undefined || answers[qIdx + 1] !== undefined;
                          const isCurrent = currentIndex === qIdx;
                          return (
                            <button
                              key={qItem.questionId || qIdx}
                              type="button"
                              onClick={() => setCurrentIndex(qIdx)}
                              className={`w-7 h-7 rounded-lg text-[11px] font-black transition flex items-center justify-center cursor-pointer ${
                                isCurrent
                                  ? 'bg-[#0f3360] text-white ring-2 ring-[#0f3360]/30 shadow-xs'
                                  : isAnswered
                                    ? 'bg-emerald-100 text-emerald-800 border border-emerald-300'
                                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200 border border-slate-200'
                              }`}
                            >
                              {qIdx + 1}
                            </button>
                          );
                        })}
                      </div>
                    </div>
                  )}

                  {currentQ && (
                    <div className="bg-white rounded-3xl border border-slate-200 p-6 sm:p-8 shadow-xs space-y-5">
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <p className="text-[11px] font-bold uppercase tracking-wider text-[#0f3360]">
                            {lang === 'km' ? 'សំណួរ' : 'Question'} {currentIndex + 1}/{totalQuestions}
                          </p>
                          <MathText as="p" className="text-base font-bold text-slate-900 mt-2" text={currentQ.questionText} />
                        </div>
                        {hasCurrentAnswer && (
                          <button
                            type="button"
                            onClick={() => {
                              setAnswers((prev) => {
                                const next = { ...prev };
                                delete next[currentQ.questionId];
                                return next;
                              });
                            }}
                            className="shrink-0 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-500 hover:text-rose-600 hover:bg-rose-50 border border-slate-200 hover:border-rose-200 transition cursor-pointer"
                            title={lang === 'km' ? 'ដកការជ្រើសរើសចម្លើយ' : 'Undo / Clear chosen answer'}
                          >
                            <RotateCcw className="w-3 h-3" />
                            <span>{lang === 'km' ? 'ដកចម្លើយ' : 'Undo'}</span>
                          </button>
                        )}
                      </div>

                      <div className="space-y-2.5">
                        {(currentQ.options || []).map((opt) => {
                          const selected = answers[currentQ.questionId] === opt.optionId;
                          return (
                            <button
                              key={opt.optionId}
                              type="button"
                              onClick={() => {
                                setAnswers((prev) => {
                                  if (prev[currentQ.questionId] === opt.optionId) {
                                    const next = { ...prev };
                                    delete next[currentQ.questionId];
                                    return next;
                                  }
                                  return { ...prev, [currentQ.questionId]: opt.optionId };
                                });
                              }}
                              className={`w-full text-left px-4 py-3 rounded-2xl border text-sm transition cursor-pointer ${
                                selected
                                  ? 'bg-indigo-50 border-indigo-500 text-indigo-900 ring-2 ring-indigo-500/20 font-semibold'
                                  : 'bg-white border-slate-200 text-slate-700 hover:border-indigo-300'
                              }`}
                            >
                              <MathText text={opt.optionText} />
                            </button>
                          );
                        })}
                      </div>
                    </div>
                  )}

                  {/* Mobile Navigation Prev / Next */}
                  <div className="flex items-center justify-between gap-3">
                    <button
                      type="button"
                      onClick={() => setCurrentIndex((i) => Math.max(0, i - 1))}
                      disabled={currentIndex === 0}
                      className="inline-flex items-center gap-1.5 px-4 py-2.5 rounded-xl border border-slate-200 text-slate-600 text-xs font-bold disabled:opacity-40 disabled:cursor-not-allowed hover:bg-slate-50 transition cursor-pointer"
                    >
                      <ArrowLeft className="w-3.5 h-3.5" />
                      <span>{lang === 'km' ? 'ថយក្រោយ' : 'Back'}</span>
                    </button>

                    {currentIndex < totalQuestions - 1 ? (
                      <button
                        type="button"
                        onClick={() => setCurrentIndex((i) => Math.min(totalQuestions - 1, i + 1))}
                        className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold transition cursor-pointer"
                      >
                        <span>{lang === 'km' ? 'បន្ទាប់' : 'Next'}</span>
                        <ArrowRight className="w-3.5 h-3.5" />
                      </button>
                    ) : (
                      <button
                        type="button"
                        onClick={requestSubmit}
                        disabled={submitting}
                        className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 disabled:opacity-60 text-white text-xs font-bold transition cursor-pointer"
                      >
                        {submitting && <Loader2 className="w-3.5 h-3.5 animate-spin" />}
                        <span>{lang === 'km' ? 'ដាក់ស្នើចម្លើយ' : 'Submit answers'}</span>
                      </button>
                    )}
                  </div>
                </div>

                {/* ========================================================= */}
                {/* DESKTOP SCREEN LAYOUT (>= lg) - Extended Responsive View   */}
                {/* ========================================================= */}
                <div className="hidden lg:flex gap-5 items-start">
                  {/* Left Column (flex-1): Question Card extends to fill available space */}
                  <div className="flex-1 min-w-0">
                    {currentQ && (
                      <div className="bg-white rounded-2xl border border-slate-200/80 p-8 shadow-xs flex flex-col justify-between min-h-[480px]">
                        <div className="space-y-6">
                          <div className="flex items-start justify-between gap-4">
                            <p className="text-base font-bold text-indigo-600">
                              {lang === 'km' ? 'សំណួរ' : 'Question'} {currentIndex + 1}/{totalQuestions}
                            </p>
                            {hasCurrentAnswer && (
                              <button
                                type="button"
                                onClick={() => {
                                  setAnswers((prev) => {
                                    const next = { ...prev };
                                    delete next[currentQ.questionId];
                                    return next;
                                  });
                                }}
                                className="shrink-0 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-500 hover:text-rose-600 hover:bg-rose-50 border border-slate-200 hover:border-rose-200 transition cursor-pointer"
                                title={lang === 'km' ? 'ដកការជ្រើសរើសចម្លើយ' : 'Undo / Clear chosen answer'}
                              >
                                <RotateCcw className="w-3 h-3" />
                                <span>{lang === 'km' ? 'ដកចម្លើយ' : 'Undo'}</span>
                              </button>
                            )}
                          </div>

                          {/* Question Stem */}
                          <div className="text-base sm:text-lg font-bold text-slate-900 leading-relaxed">
                            <MathText text={currentQ.questionText} />
                          </div>

                          {/* Options list with circular radio indicators */}
                          <div className="space-y-3 pt-2">
                            {(currentQ.options || []).map((opt) => {
                              const selected = answers[currentQ.questionId] === opt.optionId;
                              return (
                                <button
                                  key={opt.optionId}
                                  type="button"
                                  onClick={() => {
                                    setAnswers((prev) => {
                                      if (prev[currentQ.questionId] === opt.optionId) {
                                        const next = { ...prev };
                                        delete next[currentQ.questionId];
                                        return next;
                                      }
                                      return { ...prev, [currentQ.questionId]: opt.optionId };
                                    });
                                  }}
                                  className={`w-full text-left py-3.5 px-5 rounded-xl border transition-all cursor-pointer flex items-center gap-4 group ${
                                    selected
                                      ? 'bg-indigo-50/70 border-indigo-500 text-indigo-950 font-semibold ring-2 ring-indigo-500/20 shadow-xs'
                                      : 'bg-white border-slate-200 text-slate-700 hover:border-indigo-300 hover:bg-slate-50/50'
                                  }`}
                                >
                                  {/* Radio Circle */}
                                  <div
                                    className={`w-4 h-4 rounded-full border flex items-center justify-center shrink-0 transition-colors ${
                                      selected
                                        ? 'border-indigo-600 bg-white'
                                        : 'border-slate-300 group-hover:border-indigo-400 bg-white'
                                    }`}
                                  >
                                    {selected && <div className="w-2 h-2 rounded-full bg-indigo-600" />}
                                  </div>
                                  <div className="flex-1 text-sm font-medium leading-relaxed">
                                    <MathText text={opt.optionText} />
                                  </div>
                                </button>
                              );
                            })}
                          </div>
                        </div>

                        {/* Bottom Buttons inside the Left Card */}
                        <div className="flex items-center justify-between pt-8 mt-6">
                          <button
                            type="button"
                            onClick={() => setCurrentIndex((i) => Math.max(0, i - 1))}
                            disabled={currentIndex === 0}
                            className="px-5 py-2.5 rounded-xl border border-slate-200 bg-white text-slate-400 hover:text-slate-600 hover:bg-slate-50 text-xs sm:text-sm font-bold shadow-2xs transition disabled:opacity-40 disabled:cursor-not-allowed cursor-pointer"
                          >
                            {lang === 'km' ? 'ថយក្រោយ' : 'Back'}
                          </button>

                          {currentIndex < totalQuestions - 1 ? (
                            <button
                              type="button"
                              onClick={() => setCurrentIndex((i) => Math.min(totalQuestions - 1, i + 1))}
                              className="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs sm:text-sm font-bold shadow-xs transition cursor-pointer"
                            >
                              {lang === 'km' ? 'បន្ទាប់' : 'Next'}
                            </button>
                          ) : (
                            <button
                              type="button"
                              onClick={requestSubmit}
                              disabled={submitting}
                              className="px-6 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 disabled:opacity-60 text-white text-xs sm:text-sm font-bold shadow-xs transition cursor-pointer"
                            >
                              {submitting && <Loader2 className="w-4 h-4 animate-spin inline mr-1" />}
                              {lang === 'km' ? 'បញ្ចប់ការប្រឡង' : 'Submit'}
                            </button>
                          )}
                        </div>
                      </div>
                    )}
                  </div>

                  {/* Right Column: Compact Sticky Question Navigation Palette */}
                  <div className="w-[280px] shrink-0">
                    <div className="w-full bg-white rounded-2xl border border-slate-200/80 p-5 shadow-xs space-y-4 sticky top-24">
                      {/* Palette Header */}
                      <div className="flex items-center justify-between pb-1 text-xs">
                        <div className="flex items-center gap-1.5">
                          <CheckSquare className="w-3.5 h-3.5 text-slate-700 shrink-0" />
                          <h3 className="font-bold text-slate-900 text-xs">
                            {lang === 'km'
                              ? `ផ្ទាំងរុករកសំណួរ (${toKhmerNumeral(totalQuestions)} សំណួរ)`
                              : `Question Navigation (${totalQuestions})`}
                          </h3>
                        </div>
                        <span className="text-[11px] font-medium text-slate-500 shrink-0">
                          {answeredCount} / {totalQuestions} {lang === 'km' ? 'បានឆ្លើយ' : 'answered'}
                        </span>
                      </div>

                      {/* 5-Column Question Grid */}
                      <div className="grid grid-cols-5 gap-2 max-h-[340px] overflow-y-auto p-0.5">
                        {quiz.questions.map((qItem, qIdx) => {
                          const isAnswered = answers[qItem.questionId] !== undefined || answers[qIdx + 1] !== undefined;
                          const isCurrent = currentIndex === qIdx;
                          return (
                            <button
                              key={qItem.questionId || qIdx}
                              type="button"
                              onClick={() => setCurrentIndex(qIdx)}
                              className={`h-9 w-full rounded-lg text-xs font-bold transition flex items-center justify-center cursor-pointer shadow-2xs ${
                                isCurrent
                                  ? 'bg-[#0f172a] text-white shadow-xs'
                                  : isAnswered
                                    ? 'bg-emerald-50 text-emerald-800 border border-emerald-300'
                                    : 'bg-[#f8fafc] text-slate-700 hover:bg-slate-100 border border-slate-100/80'
                              }`}
                              title={`Question ${qIdx + 1}`}
                            >
                              {qIdx + 1}
                            </button>
                          );
                        })}
                      </div>

                      {/* Horizontal Status Legend */}
                      <div className="flex items-center justify-center gap-4 text-[11px] text-slate-500 pt-1">
                        <div className="flex items-center gap-1.5">
                          <span className="w-2 h-2 rounded-full bg-[#0f172a]" />
                          <span>{lang === 'km' ? 'កំពុងធ្វើ' : 'Current'}</span>
                        </div>
                        <div className="flex items-center gap-1.5">
                          <span className="w-2 h-2 rounded-full bg-[#10b981]" />
                          <span>{lang === 'km' ? 'បានឆ្លើយ' : 'Answered'}</span>
                        </div>
                        <div className="flex items-center gap-1.5">
                          <span className="w-2 h-2 rounded-full bg-[#cbd5e1]" />
                          <span>{lang === 'km' ? 'មិនទាន់ឆ្លើយ' : 'Unanswered'}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Centered Desktop Footer */}
                <div className="hidden lg:block text-center text-xs text-slate-400 pt-8 pb-2">
                  © វិទ្យាស្ថានអប់រំ - ប្រព័ន្ធប្រឡងអនឡាញ
                </div>
              </>
            )}
          </>
        );
      })()}

      {/* ---------- Mock Exam Result (Official Certificate in Khmer) ---------- */}
      {stage === 'result' && isMockExam && mockResult && (() => {
        const levelTag = getExamCategoryTag(userProfile?.targetExam || 'nie', lang);
        const formatLevel = (tag: string) => {
          if (tag.includes('ឧត្តម') || userProfile?.targetExam === 'nie') return 'ថ្នាក់ឧត្តម (វិទ្យាស្ថានជាតិអប់រំ NIE)';
          if (tag.includes('មូលដ្ឋាន') || userProfile?.targetExam === 'rttc') return 'ថ្នាក់មូលដ្ឋាន (គរុកោសល្យភូមិភាគ RTTC)';
          if (tag.includes('បឋម') || userProfile?.targetExam === 'pttc') return 'ថ្នាក់បឋមសិក្សា (គរុកោសល្យរាជធានី-ខេត្ត PTTC)';
          return tag;
        };
        const levelText = formatLevel(levelTag);

        const filteredSubjects = mockReviewSubjectFilter === 'all'
          ? mockResult.subjectResults
          : mockResult.subjectResults.filter(s => s.subjectName === mockReviewSubjectFilter || s.subjectNameKm === mockReviewSubjectFilter);

        return (
          <div className="space-y-8 animate-fadeIn max-w-5xl mx-auto">
            {/* 1. Official Certificate Header */}
            <div className="bg-gradient-to-b from-amber-50/80 via-white to-amber-50/60 rounded-3xl border-2 border-amber-300 p-6 sm:p-8 shadow-md text-center space-y-3 relative overflow-hidden">
              <div className="absolute top-0 left-0 right-0 h-2 bg-gradient-to-r from-[#0a3263] via-amber-400 to-[#0a3263]" />
              <p className="text-lg sm:text-2xl font-black tracking-widest text-[#0a3263] font-serif">
                ព្រះរាជាណាចក្រកម្ពុជា
              </p>
              <p className="text-xs sm:text-sm font-black tracking-wider text-amber-700">
                ជាតិ សាសនា ព្រះមហាក្សត្រ
              </p>
              <div className="w-32 h-0.5 bg-gradient-to-r from-transparent via-amber-500 to-transparent mx-auto my-2" />
              <h1 className="text-xl sm:text-3xl font-black text-slate-900 pt-1">
                លទ្ធផលផ្លូវការនៃការប្រឡងសាកល្បងជ្រើសរើសគ្រូបង្រៀន
              </h1>
              <p className="text-xs sm:text-sm font-bold text-slate-600">
                សម័យប្រឡង៖ ២០២៤-២០២៥ • វិញ្ញាសាប្រឡងសាកល្បងទី {toKhmerNumeral(activeMockSetNumber || 1)} • {levelText}
              </p>
            </div>

            {/* 2. Primary Status Card */}
            <div
              className={`rounded-3xl p-8 text-center text-white shadow-lg space-y-4 border ${
                mockResult.passed
                  ? 'bg-gradient-to-br from-emerald-800 via-teal-900 to-[#0a3263] border-emerald-400/40'
                  : 'bg-gradient-to-br from-rose-900 via-slate-900 to-[#0a3263] border-rose-400/40'
              }`}
            >
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full text-xs font-black shadow-xs bg-white/20 text-white border border-white/30 backdrop-blur-xs">
                {mockResult.passed ? (
                  <>
                    <Award className="w-4 h-4 text-amber-300" />
                    <span>ជាប់ជាស្ថាពរ (PASSED)</span>
                  </>
                ) : (
                  <>
                    <AlertTriangle className="w-4 h-4 text-amber-300" />
                    <span>មិនទាន់ជាប់ទេ (FAILED)</span>
                  </>
                )}
              </div>

              <div>
                <p className="text-5xl sm:text-6xl font-black tracking-tight text-white">
                  {mockResult.totalScore}%
                </p>
                <p className="text-sm sm:text-base font-bold text-white/90 mt-2">
                  ឆ្លើយត្រឹមត្រូវ {toKhmerNumeral(mockResult.totalCorrect)} លើ {toKhmerNumeral(mockResult.totalQuestions)} សំណួរ (រួមបញ្ចូល {toKhmerNumeral(mockResult.subjectResults.length)} មុខវិជ្ជា)
                </p>
              </div>

              <p className="text-xs sm:text-sm max-w-xl mx-auto leading-relaxed text-blue-100/90">
                {mockResult.passed
                  ? 'សូមអបអរសាទរ! អ្នកបានឆ្លងកាត់ការប្រឡងសាកល្បងផ្លូវការដោយជោគជ័យ ស្របតាមកម្រិតស្តង់ដារប្រឡងប្រជែងក្រសួងអប់រំ យុវជន និងកីឡា។'
                  : 'លទ្ធផលនេះមិនទាន់គ្រប់ ៥០% នៃពិន្ទុជាប់ឡើយ។ សូមពិនិត្យមើលចម្លើយកែតម្រូវ និងការពន្យល់ខាងក្រោមដើម្បីពង្រឹងសមត្ថភាពបន្ថែម។'}
              </p>
            </div>

            {/* 3. Subject-by-Subject Score Cards Grid */}
            <div className="space-y-3">
              <h2 className="text-base sm:text-lg font-extrabold text-slate-900 flex items-center gap-2">
                <Layers className="w-5 h-5 text-[#0a3263]" />
                <span>ពិន្ទុតាមមុខវិជ្ជានីមួយៗ</span>
              </h2>

              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                {mockResult.subjectResults.map((sub, sIdx) => {
                  const subPassed = sub.score >= 50;
                  return (
                    <div
                      key={sIdx}
                      className="bg-white rounded-2xl border border-slate-200 p-5 shadow-xs space-y-3 flex flex-col justify-between"
                    >
                      <div className="flex items-start justify-between gap-2">
                        <div>
                          <span className="text-[11px] font-bold text-slate-400">មុខវិជ្ជាទី {toKhmerNumeral(sIdx + 1)}</span>
                          <h3 className="text-sm sm:text-base font-black text-slate-900">
                            {sub.subjectNameKm}
                          </h3>
                        </div>
                        <span
                          className={`px-2.5 py-0.5 rounded-full text-xs font-black ${
                            subPassed ? 'bg-emerald-100 text-emerald-800' : 'bg-rose-100 text-rose-800'
                          }`}
                        >
                          {subPassed ? 'ជាប់' : 'ខ្សោយ'}
                        </span>
                      </div>

                      <div className="flex items-baseline justify-between pt-2 border-t border-slate-100">
                        <span className="text-2xl font-black text-slate-900">{sub.score}%</span>
                        <span className="text-xs font-semibold text-slate-500">
                          {toKhmerNumeral(sub.correctCount)} / {toKhmerNumeral(sub.totalQuestions)} ត្រឹមត្រូវ
                        </span>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* 4. Question Correction & Review Section */}
            <div className="space-y-4">
              <div className="flex flex-wrap items-center justify-between gap-3">
                <h2 className="text-base sm:text-lg font-extrabold text-slate-900 flex items-center gap-2">
                  <FileText className="w-5 h-5 text-[#0a3263]" />
                  <span>ការកែវិញ្ញាសា និងការពន្យល់ចម្លើយលម្អិត</span>
                </h2>

                {/* Filter Tabs by Subject */}
                <div className="flex flex-wrap gap-1.5 bg-slate-100 p-1 rounded-xl">
                  <button
                    type="button"
                    onClick={() => setMockReviewSubjectFilter('all')}
                    className={`px-3 py-1 rounded-lg text-xs font-bold transition cursor-pointer ${
                      mockReviewSubjectFilter === 'all'
                        ? 'bg-white text-slate-900 shadow-xs'
                        : 'text-slate-600 hover:text-slate-900'
                    }`}
                  >
                    ទាំងអស់ ({mockResult.totalQuestions})
                  </button>
                  {mockResult.subjectResults.map((s, idx) => (
                    <button
                      key={idx}
                      type="button"
                      onClick={() => setMockReviewSubjectFilter(s.subjectName)}
                      className={`px-3 py-1 rounded-lg text-xs font-bold transition cursor-pointer ${
                        mockReviewSubjectFilter === s.subjectName
                          ? 'bg-white text-slate-900 shadow-xs'
                          : 'text-slate-600 hover:text-slate-900'
                      }`}
                    >
                      {s.subjectNameKm}
                    </button>
                  ))}
                </div>
              </div>

              <div className="space-y-4">
                {filteredSubjects.map((sub) => (
                  <div key={sub.quizId} className="space-y-3">
                    <div className="bg-slate-50 border border-slate-200/80 px-4 py-2.5 rounded-xl flex items-center justify-between">
                      <span className="text-xs sm:text-sm font-black text-slate-900">
                        មុខវិជ្ជា៖ {sub.subjectNameKm} ({toKhmerNumeral(sub.correctCount)}/{toKhmerNumeral(sub.totalQuestions)} ត្រឹមត្រូវ)
                      </span>
                      <span className="text-xs font-bold text-slate-500">
                        ពិន្ទុ៖ {sub.score}%
                      </span>
                    </div>

                    {sub.questions.map((q, qIdx) => {
                      const graded = sub.answers?.find((a) => a.questionId === q.questionId);
                      const correctOpt = (q.options || []).find((o) => o.optionId === graded?.correctOptionId);
                      const chosenOpt = (q.options || []).find((o) => o.optionId === graded?.selectedOptionId);

                      return (
                        <div
                          key={q.questionId}
                          className="bg-white rounded-2xl border border-slate-200 p-5 space-y-3 shadow-2xs"
                        >
                          <div className="flex items-start gap-3">
                            {graded?.isCorrect ? (
                              <CheckCircle2 className="w-5 h-5 text-emerald-500 shrink-0 mt-0.5" />
                            ) : (
                              <XCircle className="w-5 h-5 text-rose-500 shrink-0 mt-0.5" />
                            )}
                            <div className="min-w-0 space-y-1.5 flex-1">
                              <p className="text-sm font-bold text-slate-900 leading-relaxed">
                                {toKhmerNumeral(qIdx + 1)}. <MathText text={q.questionText} />
                              </p>

                              <p className="text-xs text-slate-600">
                                ចម្លើយរបស់អ្នក៖{' '}
                                <span className={graded?.isCorrect ? 'text-emerald-600 font-bold' : 'text-rose-600 font-bold'}>
                                  {chosenOpt?.optionText ? <MathText text={chosenOpt.optionText} /> : 'មិនបានឆ្លើយ'}
                                </span>
                              </p>

                              {!graded?.isCorrect && correctOpt && (
                                <p className="text-xs text-slate-600">
                                  ចម្លើយត្រឹមត្រូវ៖{' '}
                                  <span className="text-emerald-700 font-bold">
                                    <MathText text={correctOpt.optionText} />
                                  </span>
                                </p>
                              )}

                              {graded?.explanation && (
                                <div className="text-xs text-slate-700 bg-amber-50/60 border border-amber-200/60 rounded-xl p-3 mt-2 leading-relaxed">
                                  <span className="font-bold text-amber-900">ការពន្យល់៖ </span>
                                  <MathText text={graded.explanation} />
                                </div>
                              )}
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                ))}
              </div>
            </div>

            {/* 5. Bottom Action Buttons */}
            <div className="flex flex-wrap items-center justify-center gap-4 pt-4 border-t border-slate-200">
              <button
                type="button"
                onClick={handleRetake}
                className="inline-flex items-center gap-2 px-6 py-3 rounded-2xl border-2 border-slate-200 hover:border-slate-300 text-slate-700 text-xs sm:text-sm font-bold bg-white hover:bg-slate-50 transition cursor-pointer"
              >
                <RotateCcw className="w-4 h-4" />
                <span>ធ្វើវិញ្ញាសានេះម្តងទៀត</span>
              </button>

              <button
                type="button"
                onClick={backToLobby}
                className="inline-flex items-center gap-2 px-6 py-3 rounded-2xl bg-[#0a3263] hover:bg-[#082447] text-white text-xs sm:text-sm font-black shadow-md transition cursor-pointer"
              >
                <span>ត្រឡប់ទៅជ្រើសរើសវិញ្ញាសា</span>
                <ArrowRight className="w-4 h-4 text-amber-300" />
              </button>
            </div>
          </div>
        );
      })()}

      {/* ---------- Result (Single Quiz) ---------- */}
      {stage === 'result' && !isMockExam && result && quiz && (
        <>
          <div className="bg-[#0a3263] rounded-3xl p-8 text-white text-center space-y-3">
            <p className="text-5xl font-extrabold">{result.score}%</p>
            <p className="text-sm text-blue-200">
              {result.correctCount}/{result.totalQuestions} {lang === 'km' ? 'ត្រឹមត្រូវ' : 'correct'}
            </p>
            <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full bg-emerald-500/20 border border-emerald-400/40 text-emerald-200 text-xs font-medium">
              <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400 shrink-0" />
              <span>
                {lang === 'km'
                  ? isMockExam
                    ? `បានរក្សាទុកពិន្ទុ ${result.score}% ក្នុងវិញ្ញាសាប្រឡងសាកល្បង ជុំទី ${activeMockExam?.round || 1} លើមុខវិជ្ជា «${formatSubjectName(selectedPracticeSubject || quiz.subjectName, lang)}» រួចរាល់`
                    : `បានរក្សាទុកពិន្ទុ ${result.score}% ក្នុងកម្រងសំណួរ Quiz លើមុខវិជ្ជា «${formatSubjectName(selectedPracticeSubject || quiz.subjectName, lang)}» រួចរាល់`
                  : isMockExam
                    ? `Score ${result.score}% saved to Mock Exam Round ${activeMockExam?.round || 1} for "${formatSubjectName(selectedPracticeSubject || quiz.subjectName, lang)}"`
                    : `Score ${result.score}% saved to Quiz for "${formatSubjectName(selectedPracticeSubject || quiz.subjectName, lang)}"`}
              </span>
            </div>
            <p className="text-xs text-blue-300">
              {lang === 'km'
                ? 'ចំណេះដឹង និងចំណុចខ្សោយរបស់អ្នកត្រូវបានធ្វើបច្ចុប្បន្នភាព។'
                : 'Your topic mastery and weak areas have been updated.'}
            </p>
          </div>

          <div className="space-y-3">
            {(quiz.questions || []).map((q, idx) => {
              const graded = result.answers?.find((a) => a.questionId === q.questionId);
              const correctOption = (q.options || []).find((o) => o.optionId === graded?.correctOptionId);
              const chosenOption = (q.options || []).find((o) => o.optionId === graded?.selectedOptionId);
              return (
                <div key={q.questionId} className="bg-white rounded-2xl border border-slate-200 p-5 space-y-2">
                  <div className="flex items-start gap-2.5">
                    {graded?.isCorrect ? (
                      <CheckCircle2 className="w-5 h-5 text-emerald-500 shrink-0 mt-0.5" />
                    ) : (
                      <XCircle className="w-5 h-5 text-red-500 shrink-0 mt-0.5" />
                    )}
                    <div className="min-w-0">
                      <p className="text-sm font-semibold text-slate-900">
                        {idx + 1}. <MathText text={q.questionText} />
                      </p>
                      <p className="text-xs text-slate-500 mt-1">
                        {lang === 'km' ? 'ចម្លើយរបស់អ្នក' : 'Your answer'}:{' '}
                        <span className={graded?.isCorrect ? 'text-emerald-600 font-semibold' : 'text-red-600 font-semibold'}>
                          {chosenOption?.optionText ? <MathText text={chosenOption.optionText} /> : lang === 'km' ? 'មិនបានឆ្លើយ' : 'Not answered'}
                        </span>
                      </p>
                      {!graded?.isCorrect && correctOption && (
                        <p className="text-xs text-slate-500">
                          {lang === 'km' ? 'ចម្លើយត្រឹមត្រូវ' : 'Correct answer'}:{' '}
                          <span className="text-emerald-600 font-semibold"><MathText text={correctOption.optionText} /></span>
                        </p>
                      )}
                      {graded?.explanation && (
                        <p className="text-xs text-slate-500 mt-1.5 bg-slate-50 border border-slate-100 rounded-lg px-3 py-2">
                          <MathText text={graded.explanation} />
                        </p>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>

          <div className="flex flex-wrap items-center justify-center gap-3 pt-2">
            {isMockExam ? (
              <>
                <button
                  type="button"
                  onClick={handleRetake}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl border border-slate-200 text-slate-700 text-xs font-bold hover:bg-slate-50 transition cursor-pointer"
                >
                  <RotateCcw className="w-3.5 h-3.5" />
                  <span>{lang === 'km' ? 'ធ្វើម្តងទៀត' : 'Retake'}</span>
                </button>
                <button
                  type="button"
                  onClick={backToLobby}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold transition cursor-pointer shadow-xs"
                >
                  <span>
                    {quizReturnPage
                      ? RETURN_LABELS[quizReturnPage]?.[lang] || (lang === 'km' ? 'ត្រឡប់ទៅទំព័រមុន' : 'Back')
                      : lang === 'km' ? 'ត្រឡប់ទៅវិញ្ញាសាប្រឡងសាកល្បង' : 'Back to Mock Exam Page'}
                  </span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </button>
              </>
            ) : (
              // Quiz Result: Quiz has only 1 round
              <>
                <button
                  type="button"
                  onClick={handleRetake}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl border border-slate-200 text-slate-700 text-xs font-bold hover:bg-slate-50 transition cursor-pointer"
                >
                  <RotateCcw className="w-3.5 h-3.5" />
                  <span>{lang === 'km' ? 'ធ្វើម្តងទៀត' : 'Retake'}</span>
                </button>
                {quizReturnPage ? (
                  // Opened from the study plan, dashboard or weak areas: go straight back there.
                  <button
                    type="button"
                    onClick={backToLobby}
                    className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl bg-[#0f3360] hover:bg-[#12427d] text-white text-xs font-bold transition cursor-pointer shadow-xs"
                  >
                    <ArrowLeft className="w-3.5 h-3.5" />
                    <span>{RETURN_LABELS[quizReturnPage]?.[lang] || (lang === 'km' ? 'ត្រឡប់ទៅទំព័រមុន' : 'Back')}</span>
                  </button>
                ) : (
                  <>
                    <button
                      type="button"
                      onClick={backToLobby}
                      className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl bg-[#0f3360] hover:bg-[#12427d] text-white text-xs font-bold transition cursor-pointer shadow-xs"
                    >
                      <ListChecks className="w-3.5 h-3.5" />
                      <span>{lang === 'km' ? 'បញ្ជី Quiz ផ្សេងទៀត' : 'All Quizzes'}</span>
                    </button>
                    <button
                      type="button"
                      onClick={() => returnToPracticeQuizList()}
                      className="inline-flex items-center gap-1.5 px-5 py-2.5 rounded-xl border border-slate-200 text-slate-700 hover:bg-slate-50 text-xs font-bold transition cursor-pointer"
                    >
                      <span>{lang === 'km' ? 'ត្រឡប់ទៅអនុវត្ត' : 'Back to Practice'}</span>
                      <ArrowRight className="w-3.5 h-3.5" />
                    </button>
                  </>
                )}
              </>
            )}
          </div>
        </>
      )}

      {/* Confirm before submitting a quiz with unanswered questions (wording mirrors the mock-exam modal). */}
      {quiz && (() => {
        const total = (quiz.questions || []).length;
        const answered = (quiz.questions || []).filter((q) => answers[q.questionId] != null).length;
        return (
          <ConfirmDialog
            open={showQuizSubmitConfirm}
            title={lang === 'km' ? 'ដាក់ស្នើចម្លើយ' : 'Submit answers?'}
            message={
              lang === 'km'
                ? `អ្នកបានឆ្លើយចំនួន ${toKhmerNumeral(answered)} ក្នុងចំណោម ${toKhmerNumeral(total)} សំណួរ (នៅសល់ ${toKhmerNumeral(total - answered)} មិនទាន់ឆ្លើយ)។`
                : `You answered ${answered} of ${total} questions (${total - answered} unanswered). Unanswered questions count as wrong.`
            }
            confirmLabel={lang === 'km' ? 'ដាក់ស្នើចម្លើយ' : 'Submit answers'}
            cancelLabel={lang === 'km' ? 'ត្រឡប់ទៅពិនិត្យឡើងវិញ' : 'Back to review'}
            busy={submitting}
            onCancel={() => setShowQuizSubmitConfirm(false)}
            onConfirm={() => {
              setShowQuizSubmitConfirm(false);
              handleSubmit();
            }}
          />
        );
      })()}

      {/* Offer to pick up answers saved before a crash, reload or closed tab. */}
      {pendingResume && (() => {
        let answered = 0;
        let total = 0;
        if (pendingResume.kind === 'quiz') {
          answered = Object.keys(pendingResume.saved.answers).length;
          total = (quiz?.questions || []).length;
        } else {
          for (const paper of mockPapers) {
            total += (paper.questions || []).length;
            answered += Object.keys(pendingResume.saved[paper.quizId]?.answers || {}).length;
          }
        }
        return (
          <ConfirmDialog
            open
            title={lang === 'km' ? 'បន្តតេស្ត' : 'Continue test'}
            message={
              lang === 'km'
                ? `ចម្លើយរបស់អ្នករក្សាទុករួចហើយ។ អ្នកបានឆ្លើយចំនួន ${toKhmerNumeral(answered)} ក្នុងចំណោម ${toKhmerNumeral(total)} សំណួរ។`
                : `Your answers are saved. You answered ${answered} of ${total} questions. Continue where you left off, or start over?`
            }
            confirmLabel={lang === 'km' ? 'បន្ត' : 'Continue'}
            cancelLabel={lang === 'km' ? 'ធ្វើម្តងទៀត' : 'Start over'}
            busy={resumeBusy}
            onConfirm={resumeSavedAnswers}
            onCancel={discardSavedAnswers}
          />
        );
      })()}
    </div>
  );
};
