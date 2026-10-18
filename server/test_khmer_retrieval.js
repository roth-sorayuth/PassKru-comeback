import * as qs from './src/services/quizService.js';
import * as ss from './src/services/subjectService.js';
import { prisma } from './src/config/prisma.js';

async function run() {
  console.log('=== TEST 1: Check Khmer questions examName in DB ===');
  const khmerQuestions = await prisma.question.findMany({
    where: {
      OR: [
        { subjectName: { contains: 'Khmer', mode: 'insensitive' } },
        { subjectName: { contains: 'ខ្មែរ' } }
      ]
    },
    select: { questionId: true, subjectName: true, examName: true }
  });
  console.log('Khmer questions count:', khmerQuestions.length);
  const nonAll = khmerQuestions.filter(q => q.examName !== 'All');
  console.log('Questions where examName !== "All":', nonAll.length);
  if (nonAll.length > 0) throw new Error('Some Khmer questions do not have examName All');

  console.log('\n=== TEST 2: Check Subject retrieval in all 3 categories ===');
  const nieSubs = await ss.getAll({ targetExam: 'nie' });
  const rttcSubs = await ss.getAll({ targetExam: 'rttc' });
  const pttcSubs = await ss.getAll({ targetExam: 'pttc' });

  const hasKhmerNIE = nieSubs.some(s => s.subjectName.toLowerCase().includes('khmer'));
  const hasKhmerRTTC = rttcSubs.some(s => s.subjectName.toLowerCase().includes('khmer'));
  const hasKhmerPTTC = pttcSubs.some(s => s.subjectName.toLowerCase().includes('khmer'));
  console.log('Khmer in NIE subjects:', hasKhmerNIE);
  console.log('Khmer in RTTC subjects:', hasKhmerRTTC);
  console.log('Khmer in PTTC subjects:', hasKhmerPTTC);
  if (!hasKhmerNIE || !hasKhmerRTTC || !hasKhmerPTTC) throw new Error('Khmer missing from one or more categories');

  console.log('\n=== TEST 3: Quizzes for Khmer across 3 categories ===');
  const nieQuizzes = await qs.listQuizzes({ targetExam: 'nie', subjectName: 'Khmer' });
  const rttcQuizzes = await qs.listQuizzes({ targetExam: 'rttc', subjectName: 'ភាសាខ្មែរ' });
  const pttcQuizzes = await qs.listQuizzes({ targetExam: 'pttc', subjectName: 'Khmer Literature' });
  console.log('NIE Khmer Quizzes:', nieQuizzes.length, nieQuizzes[0]?.title);
  console.log('RTTC Khmer Quizzes:', rttcQuizzes.length, rttcQuizzes[0]?.title);
  console.log('PTTC Khmer Quizzes:', pttcQuizzes.length, pttcQuizzes[0]?.title);
  if (nieQuizzes.length !== 1 || rttcQuizzes.length !== 1 || pttcQuizzes.length !== 1) {
    throw new Error('Quizzes count mismatch across categories');
  }

  console.log('\n=== TEST 4: Category Questions API for Khmer across 3 categories ===');
  const nieQs = await qs.getCategoryQuestions({ category: 'nie', subjectName: 'Khmer' });
  const rttcQs = await qs.getCategoryQuestions({ category: 'rttc', subjectName: 'ភាសាខ្មែរ' });
  const pttcQs = await qs.getCategoryQuestions({ category: 'pttc', subjectName: 'Khmer Literature' });
  console.log('NIE Questions Total:', nieQs.total);
  console.log('RTTC Questions Total:', rttcQs.total);
  console.log('PTTC Questions Total:', pttcQs.total);
  if (nieQs.total !== 22 || rttcQs.total !== 22 || pttcQs.total !== 22) {
    throw new Error('Questions count mismatch across categories');
  }

  console.log('\n=== TEST 5: Verify identical questions returned ===');
  const nieIds = nieQs.questions.map(q => q.questionId).sort();
  const rttcIds = rttcQs.questions.map(q => q.questionId).sort();
  const pttcIds = pttcQs.questions.map(q => q.questionId).sort();
  const sameIds = JSON.stringify(nieIds) === JSON.stringify(rttcIds) && JSON.stringify(rttcIds) === JSON.stringify(pttcIds);
  console.log('Identical 22 questions returned in all 3 categories:', sameIds);
  if (!sameIds) throw new Error('Question IDs differ between categories');

  console.log('\n=== ALL TESTS PASSED! ===');
  await prisma.$disconnect();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});

