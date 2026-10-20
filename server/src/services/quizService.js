import { prisma } from "../config/prisma.js";

/**
 * Read side of quiz/mock-exam taking.
 *
 * The "ForTaking" shapes deliberately strip `isCorrect` off every answer
 * option: the client renders these directly, so shipping the answer key with
 * the questions would make the quiz self-defeating. Grading happens server
 * side in scoringService against the DB rows instead.
 */

export function normalizeCategory(categoryOrTarget) {
  if (!categoryOrTarget) return null;
  const s = String(categoryOrTarget).toLowerCase().trim();
  if (s.includes('elem') || s.includes('primary') || s.includes('pttc') || s.includes('បឋម')) return 'pttc';
  if (s.includes('sec') || s.includes('basic') || s.includes('rttc') || s.includes('មូលដ្ឋាន') || s.includes('អនុវិទ្យាល័យ')) return 'rttc';
  if (s.includes('high') || s.includes('upper') || s.includes('nie') || s.includes('ឧត្តម') || s.includes('វិទ្យាល័យ')) return 'nie';
  return s;
}

export function isGeneralKnowledge(name) {
  if (!name) return false;
  const s = String(name).toLowerCase().trim();
  return (
    s.includes('general') ||
    s.includes('culture') ||
    s.includes('knowledge') ||
    s.includes('វប្បធម៌') ||
    s.includes('ចំណេះដឹង') ||
    s === 'gk'
  );
}

export function isEnglish(name) {
  if (!name) return false;
  const s = String(name).toLowerCase().trim();
  return s.includes('english') || s.includes('អង់គ្លេស') || s === 'eng';
}

export function isKhmer(name) {
  if (!name) return false;
  const s = String(name).toLowerCase().trim();
  return s.includes('khmer') || s.includes('ខ្មែរ');
}

export function mapSubjectName(name) {
  if (!name) return null;
  const s = String(name).toLowerCase().trim();
  if (isGeneralKnowledge(s)) return 'General Knowledge';
  if (isEnglish(s)) return 'English';
  if (s.includes('math') || s.includes('គណិត')) return 'Mathematics';
  if (s.includes('phys') || s.includes('រូប')) return 'Physics';
  if (s.includes('chem') || s.includes('គីមី')) return 'Chemistry';
  if (s.includes('bio') || s.includes('ជីវ')) return 'Biology';
  if (s.includes('hist') || s.includes('ប្រវត្តិ')) return 'History';
  if (s.includes('geo') || s.includes('ភូមិ')) return 'Geography';
  if (s.includes('khmer') || s.includes('ខ្មែរ')) return 'Khmer Literature';
  if (s.includes('civic') || s.includes('moral') || s.includes('សីលធម៌') || s.includes('ពលរដ្ឋ')) return 'Civics & Ethics';
  return name;
}

function toTakingQuestion(question, order) {
  return {
    questionId: question.questionId,
    topicId: question.topicId,
    topicName: question.topic?.topicName ?? null,
    subjectId: question.topic?.subjectId ?? null,
    subjectName: question.subjectName ?? question.topic?.subject?.subjectName ?? null,
    examName: question.examName ?? null,
    questionText: question.questionText,
    questionType: question.questionType,
    difficultyLevel: question.difficultyLevel,
    questionOrder: order,
    options: (question.answerOptions || []).map((o) => ({
      optionId: o.optionId,
      optionText: o.optionText,
    })),
  };
}

export const listQuizzes = async ({ subjectId, examId, targetExam, subjectName, category, selectedSubjects } = {}) => {
  const where = {};
  if (subjectId) {
    where.subjectId = Number(subjectId);
  }

  const cat = normalizeCategory(targetExam || category);

  let chosenSubjects = null;
  if (selectedSubjects) {
    const rawList = Array.isArray(selectedSubjects) ? selectedSubjects : String(selectedSubjects).split(',');
    chosenSubjects = rawList.map((s) => mapSubjectName(s.trim())).filter(Boolean);
  }

  if (subjectName) {
    const canonical = mapSubjectName(subjectName);
    if (canonical === 'General Knowledge') {
      // General Knowledge must show in all 3 categories
      where.OR = [
        { subjectId: 3 },
        { subject: { subjectName: { contains: 'General Knowledge', mode: 'insensitive' } } },
        { title: { contains: 'វប្បធម៌ទូទៅ' } }
      ];
    } else if (canonical === 'English') {
      // English must show in all 3 categories
      where.OR = [
        { subjectId: 20 },
        { subject: { subjectName: { contains: 'English', mode: 'insensitive' } } },
        { title: { contains: 'ភាសាអង់គ្លេស' } }
      ];
    } else if (canonical === 'Khmer Literature') {
      // Khmer Literature shows the same quizzes in all 3 categories if chosen
      where.OR = [
        { subjectId: 15 },
        { subject: { subjectName: { contains: 'Khmer', mode: 'insensitive' } } },
        { title: { contains: 'ខ្មែរ' } }
      ];
    } else {
      // Specialized subject: only show for the category the user chose
      const subjectFilter = {
        subject: {
          subjectName: { contains: canonical, mode: 'insensitive' },
          ...(cat
            ? {
                exam: {
                  targetCode: { equals: cat, mode: 'insensitive' },
                },
              }
            : {}),
        },
      };
      if (examId) {
        subjectFilter.subject.examId = Number(examId);
      }
      Object.assign(where, subjectFilter);
    }
  } else if (chosenSubjects && chosenSubjects.length > 0) {
    // Only show the chosen subjects, plus General Knowledge, English, and Khmer Literature if chosen
    const hasKhmer = chosenSubjects.includes('Khmer Literature');
    const commonIds = [3, 20, ...(hasKhmer ? [15] : [])];
    const allowedSubjects = Array.from(new Set([...chosenSubjects, 'General Knowledge', 'English']));
    where.OR = [
      // Core subjects always allowed
      { subjectId: { in: commonIds } },
      // Chosen specialization subjects scoped to the chosen category
      {
        subject: {
          subjectName: { in: allowedSubjects, mode: 'insensitive' },
          ...(cat ? { exam: { targetCode: { equals: cat, mode: 'insensitive' } } } : {}),
        },
      },
    ];
  } else if (cat || examId) {
    // User selected category without specific subject: return category's subjects + General Knowledge, English & Khmer Literature
    where.OR = [
      {
        subject: {
          exam: {
            OR: [
              ...(cat ? [{ targetCode: { equals: cat, mode: 'insensitive' } }] : []),
              ...(examId ? [{ examId: Number(examId) }] : []),
            ],
          },
        },
      },
      // General Knowledge (ID: 3), English (ID: 20), and Khmer Literature (ID: 15)
      { subjectId: { in: [3, 20, 15] } },
    ];
  }

  const quizzes = await prisma.quiz.findMany({
    where,
    orderBy: { quizId: "asc" },
    include: {
      subject: {
        select: {
          subjectId: true,
          subjectName: true,
          examId: true,
          exam: {
            select: {
              examId: true,
              examName: true,
              targetCode: true,
              category: true,
            },
          },
        },
      },
      _count: { select: { quizQuestions: true } },
    },
  });

  return quizzes.map((q) => ({
    quizId: q.quizId,
    title: q.title ? q.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : q.title,
    difficultyLevel: q.difficultyLevel,
    durationMinutes: q.durationMinutes,
    subjectId: q.subjectId,
    subjectName: q.subject?.subjectName ?? null,
    examId: q.subject?.examId ?? null,
    targetExam: q.subject?.exam?.targetCode ?? q.subject?.exam?.category ?? null,
    totalQuestions: q._count.quizQuestions,
  }));
};

export const getQuizForTaking = async (quizId) => {
  const quiz = await prisma.quiz.findUnique({
    where: { quizId: Number(quizId) },
    include: {
      subject: {
        select: {
          subjectId: true,
          subjectName: true,
          examId: true,
          exam: {
            select: {
              examId: true,
              examName: true,
              targetCode: true,
              category: true,
            },
          },
        },
      },
      quizQuestions: {
        orderBy: [{ questionOrder: "asc" }, { quizQuestionId: "asc" }],
        include: {
          question: {
            include: {
              answerOptions: { orderBy: { optionId: "asc" } },
              topic: { select: { topicId: true, topicName: true, subjectId: true } },
            },
          },
        },
      },
    },
  });

  if (!quiz) {
    const error = new Error(`Quiz ${quizId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const questions = quiz.quizQuestions
    .filter((qq) => qq.question)
    .map((qq, idx) => toTakingQuestion(qq.question, qq.questionOrder ?? idx + 1));

  return {
    quizId: quiz.quizId,
    title: quiz.title ? quiz.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : quiz.title,
    difficultyLevel: quiz.difficultyLevel,
    durationMinutes: quiz.durationMinutes,
    subjectId: quiz.subjectId,
    subjectName: quiz.subject?.subjectName ?? null,
    examId: quiz.subject?.examId ?? null,
    targetExam: quiz.subject?.exam?.targetCode ?? quiz.subject?.exam?.category ?? null,
    totalQuestions: questions.length,
    questions,
  };
};

const MAX_CATEGORY_QUESTIONS = 100;

/**
 * Retrieve questions in quiz format defined by each category.
 * Only returns questions for the category and subject the user has chosen,
 * while General Knowledge and English always show in all 3 categories.
 */
export const getCategoryQuestions = async ({
  category,
  targetExam,
  subjectName,
  selectedSubjects,
  limit: limitRaw,
  offset: offsetRaw,
} = {}) => {
  // Public endpoint: an uncapped limit would hand out the whole question bank
  // in one request, and a non-numeric one used to reach Prisma as NaN (500).
  const limit = Math.min(MAX_CATEGORY_QUESTIONS, Math.max(1, parseInt(limitRaw, 10) || 50));
  const offset = Math.max(0, parseInt(offsetRaw, 10) || 0);
  const cat = normalizeCategory(targetExam || category);
  const examNameFilter =
    cat === 'pttc' ? 'elementary' : cat === 'rttc' ? 'secondary' : cat === 'nie' ? 'highschool' : cat;

  const where = {};

  if (subjectName) {
    const canonical = mapSubjectName(subjectName);
    if (canonical === 'General Knowledge' || canonical === 'English' || canonical === 'Khmer Literature') {
      // General Knowledge, English & Khmer Literature show in all 3 categories (examName is "All")
      where.subjectName = canonical;
    } else {
      // Specific chosen subject in the category
      where.subjectName = canonical;
      if (examNameFilter) {
        where.examName = examNameFilter;
      }
    }
  } else if (selectedSubjects) {
    const rawList = Array.isArray(selectedSubjects) ? selectedSubjects : String(selectedSubjects).split(',');
    const mapped = rawList.map((s) => mapSubjectName(s.trim())).filter(Boolean);
    const hasKhmer = mapped.includes('Khmer Literature');
    const commonSubjects = ['General Knowledge', 'English', ...(hasKhmer ? ['Khmer Literature'] : [])];
    const allowed = Array.from(new Set([...mapped, 'General Knowledge', 'English']));

    where.OR = [
      { subjectName: { in: commonSubjects, mode: 'insensitive' } },
      {
        subjectName: { in: allowed, mode: 'insensitive' },
        ...(examNameFilter ? { examName: examNameFilter } : {}),
      },
    ];
  } else if (examNameFilter) {
    // Return questions for category, PLUS questions with examName "All" (General Knowledge, English, Khmer)
    where.OR = [{ examName: examNameFilter }, { examName: 'All' }];
  }

  const [total, questions] = await Promise.all([
    prisma.question.count({ where }),
    prisma.question.findMany({
      where,
      orderBy: { questionId: 'asc' },
      skip: offset,
      take: limit,
      include: {
        topic: { select: { topicId: true, topicName: true, subjectId: true } },
        answerOptions: { orderBy: { optionId: 'asc' } },
      },
    }),
  ]);

  return {
    category: cat || 'all',
    total,
    count: questions.length,
    questions: questions.map((q, idx) => toTakingQuestion(q, offset + idx + 1)),
  };
};

export const listMockExams = async ({ examId, targetExam } = {}) => {
  const where = {};
  if (examId) where.examId = Number(examId);
  if (targetExam) {
    where.exam = { targetCode: { equals: targetExam, mode: "insensitive" } };
  }

  const mockExams = await prisma.mockExam.findMany({
    where,
    orderBy: { mockExamId: "asc" },
    include: {
      exam: { select: { examId: true, examName: true, targetCode: true } },
      mockExamSections: { select: { sectionId: true, numberOfQuestions: true } },
    },
  });

  return mockExams.map((m) => ({
    mockExamId: m.mockExamId,
    title: m.title ? m.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : m.title,
    description: m.description ? m.description.replace(/ឈុត/g, 'វិញ្ញាសារ') : m.description,
    year: m.year,
    durationMinutes: m.durationMinutes,
    totalMarks: m.totalMarks !== null ? Number(m.totalMarks) : null,
    passingMarks: m.passingMarks !== null ? Number(m.passingMarks) : null,
    examId: m.examId,
    examName: m.exam?.examName ?? null,
    targetExam: m.exam?.targetCode ?? null,
    totalQuestions: m.mockExamSections.reduce((sum, s) => sum + (s.numberOfQuestions || 0), 0),
  }));
};

export const getMockExamForTaking = async (mockExamId) => {
  const mockExam = await prisma.mockExam.findUnique({
    where: { mockExamId: Number(mockExamId) },
    include: {
      exam: { select: { examId: true, examName: true } },
      mockExamSections: {
        orderBy: { sectionId: "asc" },
        include: {
          subject: { select: { subjectId: true, subjectName: true } },
          mockExamQuestions: {
            orderBy: [{ questionOrder: "asc" }, { mockExamQuestionId: "asc" }],
            include: {
              question: {
                include: {
                  answerOptions: { orderBy: { optionId: "asc" } },
                  topic: { select: { topicId: true, topicName: true, subjectId: true } },
                },
              },
            },
          },
        },
      },
    },
  });

  if (!mockExam) {
    const error = new Error(`Mock exam ${mockExamId} not found`);
    error.statusCode = 404;
    throw error;
  }

  let running = 0;
  const sections = mockExam.mockExamSections.map((section) => {
    const questions = section.mockExamQuestions
      .filter((mq) => mq.question)
      .map((mq) => toTakingQuestion(mq.question, ++running));
    return {
      sectionId: section.sectionId,
      subjectId: section.subjectId,
      subjectName: section.subject?.subjectName ?? null,
      questions,
    };
  });

  return {
    mockExamId: mockExam.mockExamId,
    title: mockExam.title ? mockExam.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : mockExam.title,
    description: mockExam.description ? mockExam.description.replace(/ឈុត/g, 'វិញ្ញាសារ') : mockExam.description,
    durationMinutes: mockExam.durationMinutes,
    totalMarks: mockExam.totalMarks !== null ? Number(mockExam.totalMarks) : null,
    passingMarks: mockExam.passingMarks !== null ? Number(mockExam.passingMarks) : null,
    examId: mockExam.examId,
    examName: mockExam.exam?.examName ?? null,
    sections,
    totalQuestions: running,
  };
};

// ---------------------------------------------------------------------------
// Admin write side (quiz builder)
// ---------------------------------------------------------------------------

export const createQuiz = async (data) => {
  const subjectId = Number(data.subjectId);
  const subjectExists = await prisma.subject.findUnique({ where: { subjectId } });
  if (!subjectExists) {
    const error = new Error(`Subject with ID ${subjectId} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.quiz.create({
    data: {
      subjectId,
      title: data.title,
      difficultyLevel: data.difficultyLevel || null,
      durationMinutes: data.durationMinutes !== undefined && data.durationMinutes !== null
        ? Number(data.durationMinutes)
        : null,
    },
  });
};

export const updateQuiz = async (quizId, data) => {
  const quizExists = await prisma.quiz.findUnique({ where: { quizId } });
  if (!quizExists) {
    const error = new Error(`Quiz ${quizId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const updateData = {};
  if (data.subjectId !== undefined) updateData.subjectId = Number(data.subjectId);
  if (data.title !== undefined) updateData.title = data.title;
  if (data.difficultyLevel !== undefined) updateData.difficultyLevel = data.difficultyLevel || null;
  if (data.durationMinutes !== undefined) {
    updateData.durationMinutes = data.durationMinutes !== null ? Number(data.durationMinutes) : null;
  }

  return await prisma.quiz.update({ where: { quizId }, data: updateData });
};

export const removeQuiz = async (quizId) => {
  const quizExists = await prisma.quiz.findUnique({ where: { quizId } });
  if (!quizExists) {
    const error = new Error(`Quiz ${quizId} not found`);
    error.statusCode = 404;
    throw error;
  }

  await prisma.quiz.delete({ where: { quizId } });
  return true;
};

/** Replaces a quiz's full question list, in the given order. */
/**
 * Normalises an admin-supplied question list: integer ids, duplicates dropped
 * (first position wins), and every id must exist — an unknown id used to fail
 * inside createMany as a foreign-key error (500).
 */
async function resolveQuestionIds(questionIds) {
  if (questionIds == null) return [];
  if (!Array.isArray(questionIds)) {
    const error = new Error("questionIds must be an array");
    error.statusCode = 400;
    throw error;
  }
  const ids = [...new Set(questionIds.map((id) => Number(id)))];
  if (ids.some((id) => !Number.isInteger(id) || id < 1)) {
    const error = new Error("questionIds must contain positive integer ids");
    error.statusCode = 400;
    throw error;
  }
  if (ids.length) {
    const found = await prisma.question.findMany({ where: { questionId: { in: ids } }, select: { questionId: true } });
    if (found.length !== ids.length) {
      const known = new Set(found.map((q) => q.questionId));
      const error = new Error(`Unknown question id(s): ${ids.filter((id) => !known.has(id)).join(", ")}`);
      error.statusCode = 400;
      throw error;
    }
  }
  return ids;
}

export const setQuizQuestions = async (quizId, questionIds) => {
  const quizExists = await prisma.quiz.findUnique({ where: { quizId } });
  if (!quizExists) {
    const error = new Error(`Quiz ${quizId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const ids = await resolveQuestionIds(questionIds);

  await prisma.$transaction([
    prisma.quizQuestion.deleteMany({ where: { quizId } }),
    ...(ids.length
      ? [
          prisma.quizQuestion.createMany({
            data: ids.map((questionId, idx) => ({ quizId, questionId, questionOrder: idx + 1 })),
          }),
        ]
      : []),
  ]);

  return getQuizForTaking(quizId);
};

/** Every question (with its answer key) behind a quiz — grading use only. */
export const getQuizQuestionsWithAnswers = async (quizId) => {
  const rows = await prisma.quizQuestion.findMany({
    where: { quizId: Number(quizId) },
    include: { question: { include: { answerOptions: true } } },
  });
  return rows.map((r) => r.question).filter(Boolean);
};

/** Every question (with its answer key) behind a mock exam — grading use only. */
export const getMockExamQuestionsWithAnswers = async (mockExamId) => {
  const rows = await prisma.mockExamQuestion.findMany({
    where: { section: { mockExamId: Number(mockExamId) } },
    include: { question: { include: { answerOptions: true } } },
  });
  return rows.map((r) => r.question).filter(Boolean);
};

// ---------------------------------------------------------------------------
// Admin write side (mock exam builder)
// ---------------------------------------------------------------------------

export const createMockExam = async (data) => {
  const examId = Number(data.examId);
  const examExists = await prisma.exam.findUnique({ where: { examId } });
  if (!examExists) {
    const error = new Error(`Exam with ID ${examId} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.mockExam.create({
    data: {
      examId,
      title: data.title,
      description: data.description || null,
      year: data.year !== undefined && data.year !== null ? Number(data.year) : null,
      durationMinutes: data.durationMinutes !== undefined && data.durationMinutes !== null
        ? Number(data.durationMinutes)
        : null,
      totalMarks: data.totalMarks !== undefined && data.totalMarks !== null ? Number(data.totalMarks) : null,
      passingMarks: data.passingMarks !== undefined && data.passingMarks !== null
        ? Number(data.passingMarks)
        : null,
      instructions: data.instructions !== undefined ? data.instructions : undefined,
    },
  });
};

export const updateMockExam = async (mockExamId, data) => {
  const examExists = await prisma.mockExam.findUnique({ where: { mockExamId } });
  if (!examExists) {
    const error = new Error(`Mock exam ${mockExamId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const updateData = {};
  if (data.examId !== undefined) updateData.examId = Number(data.examId);
  if (data.title !== undefined) updateData.title = data.title;
  if (data.description !== undefined) updateData.description = data.description || null;
  if (data.year !== undefined) updateData.year = data.year !== null ? Number(data.year) : null;
  if (data.durationMinutes !== undefined) {
    updateData.durationMinutes = data.durationMinutes !== null ? Number(data.durationMinutes) : null;
  }
  if (data.totalMarks !== undefined) {
    updateData.totalMarks = data.totalMarks !== null ? Number(data.totalMarks) : null;
  }
  if (data.passingMarks !== undefined) {
    updateData.passingMarks = data.passingMarks !== null ? Number(data.passingMarks) : null;
  }
  if (data.instructions !== undefined) updateData.instructions = data.instructions;

  return await prisma.mockExam.update({ where: { mockExamId }, data: updateData });
};

export const removeMockExam = async (mockExamId) => {
  const examExists = await prisma.mockExam.findUnique({ where: { mockExamId } });
  if (!examExists) {
    const error = new Error(`Mock exam ${mockExamId} not found`);
    error.statusCode = 404;
    throw error;
  }

  await prisma.mockExam.delete({ where: { mockExamId } });
  return true;
};

/** The section, if it exists and belongs to `mockExamId`; otherwise a 404. */
async function findSectionOfMockExam(mockExamId, sectionId) {
  const section = await prisma.mockExamSection.findUnique({ where: { sectionId } });
  if (!section || section.mockExamId !== mockExamId) {
    const error = new Error(`Mock exam section ${sectionId} not found in mock exam ${mockExamId}`);
    error.statusCode = 404;
    throw error;
  }
  return section;
}

export const addMockExamSection = async (mockExamId, data) => {
  const examExists = await prisma.mockExam.findUnique({ where: { mockExamId } });
  if (!examExists) {
    const error = new Error(`Mock exam ${mockExamId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const subjectId = Number(data.subjectId);
  const subjectExists = await prisma.subject.findUnique({ where: { subjectId } });
  if (!subjectExists) {
    const error = new Error(`Subject with ID ${subjectId} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.mockExamSection.create({
    data: {
      mockExamId,
      subjectId,
      numberOfQuestions: data.numberOfQuestions !== undefined ? Number(data.numberOfQuestions) : 0,
    },
  });
};

export const updateMockExamSection = async (mockExamId, sectionId, data) => {
  await findSectionOfMockExam(mockExamId, sectionId);

  const updateData = {};
  if (data.numberOfQuestions !== undefined) updateData.numberOfQuestions = Number(data.numberOfQuestions);

  return await prisma.mockExamSection.update({ where: { sectionId }, data: updateData });
};

export const removeMockExamSection = async (mockExamId, sectionId) => {
  await findSectionOfMockExam(mockExamId, sectionId);

  await prisma.mockExamSection.delete({ where: { sectionId } });
  return true;
};

/** Replaces a section's full question list, in the given order. */
export const setMockExamSectionQuestions = async (mockExamId, sectionId, questionIds) => {
  await findSectionOfMockExam(mockExamId, sectionId);

  const ids = await resolveQuestionIds(questionIds);

  await prisma.$transaction([
    prisma.mockExamQuestion.deleteMany({ where: { sectionId } }),
    ...(ids.length
      ? [
          prisma.mockExamQuestion.createMany({
            data: ids.map((questionId, idx) => ({ sectionId, questionId, questionOrder: idx + 1 })),
          }),
        ]
      : []),
    prisma.mockExamSection.update({ where: { sectionId }, data: { numberOfQuestions: ids.length } }),
  ]);

  return prisma.mockExamSection.findUnique({
    where: { sectionId },
    include: { mockExamQuestions: true },
  });
};
