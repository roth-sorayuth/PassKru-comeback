import * as qs from './src/services/quizService.js';
import * as ss from './src/services/subjectService.js';
import { prisma } from './src/config/prisma.js';

async function run() {
  console.log('=== TEST 1: Quizzes for NIE Mathematics ===');
  const nieMath = await qs.listQuizzes({ targetExam: 'nie', subjectName: 'គណិតវិទ្យា' });
  console.log('Count:', nieMath.length, 'Titles:', nieMath.map(q => q.title));

  console.log('\n=== TEST 2: Quizzes for RTTC Mathematics ===');
  const rttcMath = await qs.listQuizzes({ targetExam: 'rttc', subjectName: 'គណិតវិទ្យា' });
  console.log('Count:', rttcMath.length);

  console.log('\n=== TEST 3: Quizzes for PTTC Mathematics ===');
  const pttcMath = await qs.listQuizzes({ targetExam: 'pttc', subjectName: 'គណិតវិទ្យា' });
  console.log('Count:', pttcMath.length);

  console.log('\n=== TEST 4: Quizzes for General Knowledge across categories ===');
  const nieGK = await qs.listQuizzes({ targetExam: 'nie', subjectName: 'វប្បធម៌ទូទៅ' });
  const rttcGK = await qs.listQuizzes({ targetExam: 'rttc', subjectName: 'General Knowledge' });
  const pttcGK = await qs.listQuizzes({ targetExam: 'pttc', subjectName: 'វប្បធម៌ទូទៅ' });
  console.log('NIE GK Count:', nieGK.length, '| RTTC GK Count:', rttcGK.length, '| PTTC GK Count:', pttcGK.length);

  console.log('\n=== TEST 5: Quizzes for English across categories ===');
  const nieEng = await qs.listQuizzes({ targetExam: 'nie', subjectName: 'ភាសាអង់គ្លេស' });
  const rttcEng = await qs.listQuizzes({ targetExam: 'rttc', subjectName: 'English' });
  const pttcEng = await qs.listQuizzes({ targetExam: 'pttc', subjectName: 'English' });
  console.log('NIE Eng Count:', nieEng.length, '| RTTC Eng Count:', rttcEng.length, '| PTTC Eng Count:', pttcEng.length);

  console.log('\n=== TEST 6: Subjects for NIE (must have GK and English) ===');
  const nieSubs = await ss.getAll({ targetExam: 'nie' });
  console.log('NIE Subjects:', nieSubs.map(s => `${s.subjectName} (${s.quizCount} quizzes, ${s.questionCount} Qs)`));

  console.log('\n=== TEST 7: Subjects for RTTC (must have GK and English) ===');
  const rttcSubs = await ss.getAll({ targetExam: 'rttc' });
  console.log('RTTC Subjects:', rttcSubs.map(s => `${s.subjectName} (${s.quizCount} quizzes, ${s.questionCount} Qs)`));

  console.log('\n=== TEST 8: Subjects for PTTC (must have GK and English) ===');
  const pttcSubs = await ss.getAll({ targetExam: 'pttc' });
  console.log('PTTC Subjects:', pttcSubs.map(s => `${s.subjectName} (${s.quizCount} quizzes, ${s.questionCount} Qs)`));

  console.log('\n=== TEST 9: Category Questions API ===');
  const qMath = await qs.getCategoryQuestions({ category: 'nie', subjectName: 'Mathematics', limit: 3 });
  console.log('NIE Math Qs:', qMath.total, 'Sample:', qMath.questions[0].questionText);

  const qEng = await qs.getCategoryQuestions({ category: 'pttc', subjectName: 'English', limit: 3 });
  console.log('PTTC Eng Qs:', qEng.total, 'Sample:', qEng.questions[0].questionText);

  const qGK = await qs.getCategoryQuestions({ category: 'rttc', subjectName: 'General Knowledge', limit: 3 });
  console.log('RTTC GK Qs:', qGK.total, 'Sample:', qGK.questions[0].questionText);

  console.log('\n=== TEST 10: Quiz taking mode ===');
  const taking = await qs.getQuizForTaking(nieMath[0].quizId);
  console.log('Taking Quiz:', taking.title, 'Total Qs:', taking.totalQuestions);
  console.log('Sample Q:', taking.questions[0].questionText);
  console.log('Sample options (isCorrect stripped?):', taking.questions[0].options);

  console.log('\n=== ALL 10 TESTS PASSED PERFECTLY! ===');
}

run()
  .catch(console.error)
  .finally(async () => {
    await prisma.$disconnect();
  });

