import React, { useState, useMemo, useEffect } from 'react';
import {
  FileText,
  Loader2,
  Eye,
  Trash2,
  ChevronRight,
  ArrowLeft,
  Search,
  X,
  KeyRound,
  Plus,
  FolderOpen,
} from 'lucide-react';
import { PastPaper, Exam, Subject } from '../../types';
import { examService } from '../../services/examService';
import { PdfThumbnail } from '../common/PdfThumbnail';
import { getSubjectTheme } from '../../utils/subjectIcons';
import { canonicalSubjectName } from '../../utils/subjectNames';

interface PaperLibraryTabProps {
  papers: PastPaper[];
  exams: Exam[];
  subjects?: Subject[];
  mode?: 'past-paper' | 'prepare-paper' | 'all';
  title?: string;
  filteredPapers?: PastPaper[];
  loading: boolean;
  search?: string;
  setSearch?: (s: string) => void;
  filterExam: string | null;
  setFilterExam: (exam: string | null) => void;
  filterType?: string | null;
  setFilterType?: (type: string | null) => void;
  onUploadNew: () => void;
  onPreviewPdf: (url: string) => void;
  onDeletePaper: (id: number) => void;
  onRefreshMetadata?: () => void;
}

const khmerNumerals = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];

export const toKhmerNum = (num?: number | string) => {
  if (num === undefined || num === null || num === '') return '';
  return String(num)
    .split('')
    .map((c) => {
      const parsed = parseInt(c, 10);
      return isNaN(parsed) ? c : khmerNumerals[parsed];
    })
    .join('');
};

export const formatExamLevelName = (name?: string) => {
  if (!name) return '';
  if (name.includes('គ្រូបឋម') || name.includes('បឋមសិក្សា')) return 'កម្រិតបឋម';
  if (name.includes('គ្រូអនុវិទ្យាល័យ') || name.includes('មូលដ្ឋាន')) return 'កម្រិតមូលដ្ឋាន';
  if (name.includes('គ្រូវិទ្យាល័យ') || name.includes('ឧត្តម')) return 'កម្រិតឧត្តម';
  return name;
};

const DEFAULT_SUBJECT_NAME = 'មុខវិជ្ជាទូទៅ';
const ALL_LEVELS = 'all';

export const PaperLibraryTab: React.FC<PaperLibraryTabProps> = ({
  papers,
  exams,
  subjects = [],
  mode = 'past-paper',
  title,
  loading,
  filterExam,
  setFilterExam,
  onUploadNew,
  onPreviewPdf,
  onDeletePaper,
  onRefreshMetadata,
}) => {
  const isPrepare = mode === 'prepare-paper';

  const [selectedSubject, setSelectedSubjectState] = useState<string | null>(() => {
    const params = new URLSearchParams(window.location.search);
    return params.get('subject') || null;
  });
  const [query, setQuery] = useState('');
  const [isDeletingSubject, setIsDeletingSubject] = useState(false);

  const setSelectedSubject = (subj: string | null) => {
    setSelectedSubjectState(subj);
    setQuery('');
    const url = new URL(window.location.href);
    if (subj) {
      url.searchParams.set('subject', subj);
    } else {
      url.searchParams.delete('subject');
    }
    window.history.pushState({}, '', url.toString());
  };

  /* Sync with browser back/forward buttons */
  useEffect(() => {
    const handlePopState = () => {
      const params = new URLSearchParams(window.location.search);
      setSelectedSubjectState(params.get('subject') || null);
    };

    window.addEventListener('popstate', handlePopState);
    return () => window.removeEventListener('popstate', handlePopState);
  }, []);

  // Filter papers strictly by mode (past paper vs prepare paper)
  const modeFilteredPapers = useMemo(() => {
    return papers.filter((p) => {
      if (isPrepare) {
        return p.paperType === 'prepare-paper';
      }
      return p.paperType !== 'prepare-paper';
    });
  }, [papers, isPrepare]);

  // Helper to match a paper to the selected exam level
  const paperMatchesExam = (p: PastPaper, targetExam: string | null) => {
    if (!targetExam) return true;
    const targetLevel = formatExamLevelName(targetExam);
    return (
      p.exam?.examName === targetExam ||
      formatExamLevelName(p.exam?.examName) === targetLevel ||
      p.exam?.examType === targetExam ||
      formatExamLevelName(p.exam?.examType) === targetLevel ||
      p.subject?.exam?.examName === targetExam ||
      formatExamLevelName(p.subject?.exam?.examName) === targetLevel ||
      p.subject?.exam?.examType === targetExam ||
      formatExamLevelName(p.subject?.exam?.examType) === targetLevel
    );
  };

  // Extract available subjects and their counts for current filterExam, merged by
  // canonical name: "Math", "Mathematics" and "គណិតវិទ្យា" are one card.
  const availableSubjects = useMemo(() => {
    const subjectsMap = new Map<string, number>();
    const targetLevel = filterExam ? formatExamLevelName(filterExam) : null;

    // 1. Add all official database subjects matching the selected level
    subjects.forEach((s) => {
      if (
        !targetLevel ||
        s.exam?.examName === filterExam ||
        formatExamLevelName(s.exam?.examName) === targetLevel ||
        s.exam?.examType === filterExam ||
        formatExamLevelName(s.exam?.examType) === targetLevel
      ) {
        const name = canonicalSubjectName(s.subjectName);
        if (!subjectsMap.has(name)) subjectsMap.set(name, 0);
      }
    });

    // 2. Count papers for each subject
    modeFilteredPapers.forEach((p) => {
      if (paperMatchesExam(p, filterExam)) {
        const name = canonicalSubjectName(p.subject?.subjectName || DEFAULT_SUBJECT_NAME);
        const current = subjectsMap.get(name) || 0;
        subjectsMap.set(name, current + 1);
      }
    });

    return Array.from(subjectsMap.entries()).map(([name, count]) => ({ name, count }));
  }, [subjects, modeFilteredPapers, filterExam]);

  const q = query.trim().toLowerCase();

  // Filter subjects by search input
  const visibleSubjects = useMemo(() => {
    return availableSubjects
      .filter((s) => {
        if (!q) return true;
        return s.name.toLowerCase().includes(q);
      })
      .sort((a, b) => b.count - a.count || a.name.localeCompare(b.name));
  }, [availableSubjects, q]);

  // Papers to display for selected subject (sorted by year descending)
  const papersInView = useMemo(() => {
    if (!selectedSubject) return [];
    return modeFilteredPapers
      .filter((p) => canonicalSubjectName(p.subject?.subjectName || DEFAULT_SUBJECT_NAME) === canonicalSubjectName(selectedSubject))
      .filter((p) => paperMatchesExam(p, filterExam))
      .filter((p) => !q || p.title.toLowerCase().includes(q) || String(p.year).includes(q) || toKhmerNum(p.year).includes(q))
      .sort((a, b) => (b.year || 0) - (a.year || 0));
  }, [modeFilteredPapers, selectedSubject, filterExam, q]);

  // Group papers by Year
  const papersByYear = useMemo(() => {
    const groups = new Map<number, PastPaper[]>();
    papersInView.forEach((p) => {
      const y = p.year || 0;
      groups.set(y, [...(groups.get(y) || []), p]);
    });
    return Array.from(groups.entries()).sort((a, b) => b[0] - a[0]);
  }, [papersInView]);

  const currentSubjectObj = useMemo(() => {
    if (!selectedSubject) return null;
    // Delete is only offered when the card is exactly one subject row: a merged
    // card spans several rows (other levels, the flashcard rows), and deleting
    // one of them would be a guess.
    const matches = subjects.filter(
      (s) => canonicalSubjectName(s.subjectName) === canonicalSubjectName(selectedSubject)
    );
    return matches.length === 1 ? matches[0] : null;
  }, [subjects, selectedSubject]);

  const handleDeleteSubject = async () => {
    if (!currentSubjectObj) return;
    const confirmMessage = `តើអ្នកប្រាកដជាចង់លុបមុខវិជ្ជា "${selectedSubject}" នេះចេញពីប្រព័ន្ធមែនទេ?`;
    if (!window.confirm(confirmMessage)) return;

    try {
      setIsDeletingSubject(true);
      await examService.deleteSubject(currentSubjectObj.subjectId);
      setSelectedSubject(null);
      if (onRefreshMetadata) {
        onRefreshMetadata();
      }
    } catch (err: any) {
      alert(err.message || 'Failed to delete subject');
    } finally {
      setIsDeletingSubject(false);
    }
  };

  const displayTitle = title || (isPrepare ? 'វិញ្ញាសាត្រៀម' : 'វិញ្ញាសាចាស់ៗ');
  const displayDescription = isPrepare
    ? 'វិញ្ញាសាត្រៀមដែល PassKru ចងក្រងតាមទម្រង់ប្រឡងពិត។ ជ្រើសរើសកម្រិត រួចជ្រើសមុខវិជ្ជា។'
    : 'វិញ្ញាសាប្រឡងជាក់ស្ដែងពីឆ្នាំមុនៗ។ ជ្រើសរើសកម្រិត រួចជ្រើសមុខវិជ្ជា ដើម្បីមើលតាមឆ្នាំ។';

  const activeSubjectTheme = selectedSubject ? getSubjectTheme(selectedSubject) : null;
  const ActiveSubjectIcon = activeSubjectTheme?.icon || FileText;

  return (
    <div className="space-y-6">
      {/* 1. Header Hero Banner (Matching User Dashboard) */}
      <div className="bg-gradient-to-b from-[#0a3263] to-[#082447] text-white rounded-3xl p-6 sm:p-8 text-center relative overflow-hidden shadow-md">
        <div className="relative z-10 max-w-2xl mx-auto space-y-2">
          <h1 className="text-xl sm:text-2xl font-bold tracking-tight">{displayTitle}</h1>
          <p className="text-xs sm:text-sm text-slate-200/90 leading-relaxed font-normal">
            {displayDescription}
          </p>
        </div>
      </div>

      {/* 2. Top Search Bar */}
      <div className="relative w-full">
        <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={
            selectedSubject
              ? `ស្វែងរកវិញ្ញាសា ${selectedSubject} តាមចំណងជើង ឬឆ្នាំ...`
              : 'ស្វែងរកមុខវិជ្ជា...'
          }
          className="w-full bg-slate-50/80 hover:bg-slate-50 focus:bg-white border border-slate-200 rounded-2xl pl-11 pr-10 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-[#0a3263]/10 focus:border-[#0a3263] transition shadow-2xs font-normal"
        />
        {query && (
          <button
            type="button"
            onClick={() => setQuery('')}
            className="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 p-1"
          >
            <X className="w-3.5 h-3.5" />
          </button>
        )}
      </div>

      {/* 3. Horizontal Level Filter Pills (All Levels + Exams) */}
      <div className="flex items-center gap-2 overflow-x-auto pb-1 no-scrollbar">
        {/* All Levels Pill */}
        <button
          type="button"
          onClick={() => {
            setFilterExam(null);
            setSelectedSubject(null);
          }}
          className={`px-4 py-2 rounded-full text-xs transition shrink-0 cursor-pointer ${
            !filterExam
              ? 'bg-[#0a3263] text-white font-semibold shadow-xs'
              : 'bg-white hover:bg-slate-50 text-slate-700 border border-slate-200 font-medium'
          }`}
        >
          គ្រប់កម្រិត
        </button>

        {/* Exam Specific Pills */}
        {exams.map((exam) => {
          const isSelected = filterExam === exam.examName || filterExam === exam.examType;
          return (
            <button
              type="button"
              key={exam.examId}
              onClick={() => {
                setFilterExam(exam.examName);
                setSelectedSubject(null);
              }}
              className={`px-4 py-2 rounded-full text-xs transition shrink-0 cursor-pointer ${
                isSelected
                  ? 'bg-[#0a3263] text-white font-semibold shadow-xs'
                  : 'bg-white hover:bg-slate-50 text-slate-700 border border-slate-200 font-medium'
              }`}
            >
              {exam.examName}
            </button>
          );
        })}
      </div>

      {/* 4. Main Content Area */}
      {!selectedSubject ? (
        /* ================= STEP 1: SUBJECT CARDS GRID (Matching User Dashboard) ================= */
        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="text-base sm:text-lg font-bold text-slate-900">
              ជ្រើសរើសមុខវិជ្ជា
            </h2>
            <button
              type="button"
              onClick={onUploadNew}
              className="inline-flex items-center gap-1.5 px-3.5 py-1.5 bg-[#0a3263] hover:bg-[#082447] text-white rounded-xl text-xs font-bold transition cursor-pointer shadow-xs"
            >
              <Plus className="w-3.5 h-3.5" />
              <span>បញ្ចូលវិញ្ញាសាថ្មី</span>
            </button>
          </div>

          {loading ? (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {[...Array(6)].map((_, i) => (
                <div key={i} className="flex items-center gap-3 p-5 bg-white rounded-3xl border border-slate-200 animate-pulse">
                  <div className="w-11 h-11 rounded-2xl bg-slate-200 shrink-0" />
                  <div className="flex-1 space-y-2">
                    <div className="h-3.5 bg-slate-200 rounded w-2/3" />
                    <div className="h-3 bg-slate-100 rounded w-1/3" />
                  </div>
                </div>
              ))}
            </div>
          ) : visibleSubjects.length === 0 ? (
            <div className="bg-white border border-slate-200 rounded-3xl p-10 text-center space-y-3">
              <FolderOpen className="w-10 h-10 text-slate-300 mx-auto" />
              <p className="text-sm font-bold text-slate-800">
                {query ? 'រកមិនឃើញមុខវិជ្ជាទេ' : 'មិនទាន់មានមុខវិជ្ជាសម្រាប់កម្រិតនេះទេ'}
              </p>
              <p className="text-xs text-slate-500">
                {query ? 'សូមសាកល្បងពាក្យគន្លឹះផ្សេង ឬសម្អាតការស្វែងរក។' : 'សាកល្បងប្តូរទៅកម្រិតប្រឡងផ្សេង ឬមើលគ្រប់កម្រិតទាំងអស់។'}
              </p>
              {query && (
                <button
                  type="button"
                  onClick={() => setQuery('')}
                  className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-800 rounded-xl text-xs font-semibold transition"
                >
                  សម្អាតការស្វែងរក
                </button>
              )}
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {visibleSubjects.map((subj) => {
                const theme = getSubjectTheme(subj.name);
                const Icon = theme.icon;

                return (
                  <button
                    type="button"
                    key={subj.name}
                    onClick={() => setSelectedSubject(subj.name)}
                    className="group flex items-center gap-3.5 p-5 text-left bg-white rounded-3xl border border-slate-200/90 shadow-[0_4px_20px_-4px_rgba(0,0,0,0.05)] hover:border-[#c9d8ea] hover:shadow-lg transition cursor-pointer"
                  >
                    <div
                      className={`w-11 h-11 rounded-2xl ${theme.bg} border ${
                        theme.border || 'border-slate-200'
                      } shadow-2xs ${theme.text} flex items-center justify-center shrink-0 transition ${
                        theme.hoverBg || 'group-hover:border-[#0a3263]'
                      }`}
                    >
                      <Icon className="w-5 h-5" />
                    </div>
                    <div className="min-w-0 flex-1">
                      <p className="text-sm font-bold text-slate-900 truncate">{subj.name}</p>
                      <p className="text-xs font-medium text-slate-500 mt-0.5">
                        {subj.count > 0 ? `${toKhmerNum(subj.count)} វិញ្ញាសា` : 'មិនទាន់មានវិញ្ញាសា'}
                      </p>
                    </div>
                    <ChevronRight className="w-4 h-4 text-slate-400 group-hover:text-[#0a3263] group-hover:translate-x-0.5 transition shrink-0" />
                  </button>
                );
              })}
            </div>
          )}
        </section>
      ) : (
        /* ================= STEP 2: ACTIVE SUBJECT PAPERS BY YEAR (Matching User Dashboard) ================= */
        <section className="space-y-6 animate-fadeIn">
          {/* Active Subject Bar with Admin Controls & Back Button */}
          <div className="bg-white border border-slate-200/90 rounded-2xl p-4 sm:p-5 flex items-center justify-between shadow-2xs gap-3 flex-wrap">
            <div className="flex items-center gap-3 min-w-0">
              <div
                className={`w-10 h-10 rounded-xl ${activeSubjectTheme?.bg || 'bg-slate-100'} ${
                  activeSubjectTheme?.text || 'text-slate-800'
                } border ${activeSubjectTheme?.border || 'border-slate-200'} flex items-center justify-center shrink-0 shadow-2xs`}
              >
                <ActiveSubjectIcon className="w-5 h-5" />
              </div>
              <div className="min-w-0">
                <h2 className="text-base sm:text-lg font-bold text-slate-900 truncate">
                  {selectedSubject}
                </h2>
                <p className="text-xs text-slate-500 font-medium">
                  {papersInView.length > 0 ? `${toKhmerNum(papersInView.length)} វិញ្ញាសា` : 'មិនទាន់មានវិញ្ញាសា'}
                  {filterExam ? ` · ${filterExam}` : ''}
                </p>
              </div>
            </div>

            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={onUploadNew}
                className="inline-flex items-center gap-1.5 px-3 py-2 bg-[#0a3263] hover:bg-[#082447] text-white rounded-xl text-xs font-bold transition cursor-pointer shadow-xs"
              >
                <Plus className="w-3.5 h-3.5" />
                <span>បញ្ចូលវិញ្ញាសាថ្មី</span>
              </button>

              {currentSubjectObj && (
                <button
                  type="button"
                  onClick={handleDeleteSubject}
                  disabled={isDeletingSubject}
                  className="inline-flex items-center gap-1.5 px-3 py-2 bg-white hover:bg-red-50 disabled:opacity-50 text-red-600 border border-red-200 rounded-xl text-xs font-medium transition cursor-pointer"
                  title="លុបមុខវិជ្ជា"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                  <span>{isDeletingSubject ? 'កំពុងលុប...' : 'លុបមុខវិជ្ជា'}</span>
                </button>
              )}

              <button
                type="button"
                onClick={() => setSelectedSubject(null)}
                className="inline-flex items-center gap-1.5 px-3.5 py-2 bg-white hover:bg-slate-50 text-slate-700 border border-slate-200 rounded-xl text-xs font-semibold transition cursor-pointer"
              >
                <ArrowLeft className="w-3.5 h-3.5" />
                <span>ត្រឡប់ទៅមុខវិជ្ជា</span>
              </button>
            </div>
          </div>

          {/* Papers Grid grouped by Year */}
          {loading ? (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
              {[...Array(4)].map((_, i) => (
                <div key={i} className="bg-white rounded-3xl border border-slate-200 overflow-hidden animate-pulse">
                  <div className="aspect-[3/4] w-full bg-slate-200" />
                  <div className="p-4 space-y-2">
                    <div className="h-3.5 bg-slate-200 rounded w-5/6" />
                    <div className="h-3 bg-slate-100 rounded w-1/2 mt-3" />
                  </div>
                </div>
              ))}
            </div>
          ) : papersInView.length === 0 ? (
            <div className="bg-white border border-slate-200 rounded-3xl p-12 text-center space-y-3 shadow-2xs">
              <ActiveSubjectIcon className="w-12 h-12 mx-auto text-slate-300" />
              <p className="text-base font-bold text-slate-800">
                {query ? 'រកមិនឃើញវិញ្ញាសាទេ' : `មិនទាន់មានវិញ្ញាសាសម្រាប់ ${selectedSubject} នៅឡើយទេ`}
              </p>
              <p className="text-xs text-slate-500 max-w-md mx-auto">
                {query
                  ? 'សូមសាកល្បងពាក្យគន្លឹះ ឬឆ្នាំផ្សេង។'
                  : 'មុខវិជ្ជានេះមានក្នុងបញ្ជី ប៉ុន្តែឯកសារមិនទាន់បានបញ្ចូលទេ។ សូមបញ្ចូលវិញ្ញាសាថ្មី។'}
              </p>
              <button
                type="button"
                onClick={onUploadNew}
                className="mt-3 px-4 py-2 bg-[#0a3263] hover:bg-[#082447] text-white rounded-xl text-xs font-bold transition shadow-xs inline-flex items-center gap-1.5 cursor-pointer"
              >
                <Plus className="w-3.5 h-3.5" />
                <span>បញ្ចូលវិញ្ញាសាថ្មី</span>
              </button>
            </div>
          ) : (
            <div className="space-y-8">
              {papersByYear.map(([year, yearPapers]) => (
                <div key={year} className="space-y-4">
                  {/* Year Divider */}
                  <div className="flex items-center gap-3">
                    <h3 className="text-sm font-bold text-slate-900 shrink-0">
                      {year ? `ឆ្នាំ ${toKhmerNum(year)}` : 'មិនបញ្ជាក់ឆ្នាំ'}
                    </h3>
                    <div className="h-px bg-slate-200 flex-1" />
                  </div>

                  {/* Year's Paper Cards Grid in [3/4] Aspect Ratio */}
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
                    {yearPapers.map((paper) => {
                      const hasFile = !!paper.fileUrl && paper.fileUrl.startsWith('http');
                      const examLabel =
                        formatExamLevelName(paper.subject?.exam?.examName || paper.exam?.examName) || 'ផ្លូវការ';
                      const thumbGradient = isPrepare
                        ? 'from-[#486581] to-[#0a3263]'
                        : 'from-[#0a3263] to-[#082447]';

                      return (
                        <div
                          key={paper.paperId}
                          className="group flex flex-col bg-white rounded-3xl border border-slate-200/90 shadow-[0_4px_20px_-4px_rgba(0,0,0,0.05)] hover:border-[#c9d8ea] hover:shadow-lg transition overflow-hidden"
                        >
                          {/* Live PDF Page 1 Preview in [3/4] Aspect Ratio */}
                          <div
                            onClick={() => hasFile && onPreviewPdf(paper.fileUrl)}
                            className="relative aspect-[3/4] w-full overflow-hidden border-b border-slate-100 bg-slate-100 cursor-pointer"
                          >
                            {hasFile ? (
                              <PdfThumbnail
                                url={paper.fileUrl}
                                fallbackTitle={paper.title}
                                className="w-full h-full object-cover object-top"
                              />
                            ) : (
                              <div
                                className={`w-full h-full bg-gradient-to-br ${thumbGradient} flex flex-col items-center justify-center gap-2 p-4 text-center`}
                              >
                                <FileText className="w-10 h-10 text-white/40" />
                                <span className="text-xs font-semibold text-white/85 line-clamp-2">
                                  {paper.title}
                                </span>
                              </div>
                            )}

                            {/* Year Pill Badge on top-left */}
                            <span className="absolute top-3 left-3 z-30 px-3 py-1 rounded-full text-xs font-semibold bg-white text-slate-900 border border-slate-200 shadow-sm">
                              {paper.year ? toKhmerNum(paper.year) : 'ឆ្នាំ?'}
                            </span>

                            {/* Answer Key Badge on top-right */}
                            {paper.hasAnswerKey && (
                              <span className="absolute top-3 right-3 z-30 inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-semibold bg-emerald-700 text-white shadow-sm">
                                <KeyRound className="w-3.5 h-3.5" />
                                <span>មានចម្លើយ</span>
                              </span>
                            )}
                          </div>

                          {/* Paper Details & Admin Action Buttons */}
                          <div className="p-4 flex flex-col flex-1 gap-3">
                            <div className="flex-1 space-y-1">
                              <h4
                                onClick={() => hasFile && onPreviewPdf(paper.fileUrl)}
                                className="text-[14px] sm:text-base font-bold text-slate-900 leading-snug line-clamp-2 cursor-pointer hover:text-[#0a3263] transition"
                              >
                                {paper.title}
                              </h4>
                              <p className="text-xs font-medium text-slate-500 truncate" title={examLabel}>
                                {examLabel}
                              </p>
                            </div>

                            {/* Buttons Bar */}
                            <div className="flex items-center gap-2 mt-auto pt-1">
                              {hasFile && (
                                <button
                                  type="button"
                                  onClick={() => onPreviewPdf(paper.fileUrl)}
                                  className="flex-1 inline-flex justify-center items-center gap-1.5 px-3 py-2 rounded-xl bg-[#0a3263] text-white hover:bg-[#082447] shadow-sm font-bold text-xs transition cursor-pointer"
                                >
                                  <Eye className="w-3.5 h-3.5" />
                                  <span>មើលវិញ្ញាសា</span>
                                </button>
                              )}
                              <button
                                type="button"
                                onClick={() => onDeletePaper(paper.paperId)}
                                className="p-2 rounded-xl text-slate-400 hover:text-red-600 hover:bg-red-50 border border-slate-200 hover:border-red-200 transition cursor-pointer"
                                title="លុបវិញ្ញាសា"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              ))}
            </div>
          )}
        </section>
      )}
    </div>
  );
};
