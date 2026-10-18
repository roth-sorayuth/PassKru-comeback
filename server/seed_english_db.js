import { prisma } from "./src/config/prisma.js";
import { englishQuestions } from "./english_questions_data.js";

function cleanText(text) {
  if (!text) return text;
  return text.replace(/\s*\[cite:[^\]]+\]/g, '').trim();
}

async function main() {
  console.log("=== Seeding English Subject Questions into Database ===\n");

  console.log(`Loaded ${englishQuestions.length} English questions.`);
  if (englishQuestions.length !== 100) {
    throw new Error(`Expected 100 questions, got ${englishQuestions.length}`);
  }

  // 1. Ensure Subject exists: 'English'
  let englishSubject = await prisma.subject.findFirst({
    where: { subjectName: "English" }
  });
  if (!englishSubject) {
    englishSubject = await prisma.subject.create({
      data: {
        examId: 2, // Secondary Teacher track (RTTC)
        subjectName: "English",
        description: "English Grammar: 12 Tenses and Parts of Speech"
      }
    });
    console.log(`Created English Subject [ID: ${englishSubject.subjectId}]`);
  } else {
    console.log(`Using existing English Subject [ID: ${englishSubject.subjectId}]`);
  }

  // Sync subject sequence
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('subject', 'subject_id'), (SELECT COALESCE(MAX(subject_id), 1) FROM subject))"
  );
  console.log("Subject sequence synced.");

  // 2. Ensure Topic exists under English Subject
  let englishTopic = await prisma.topic.findFirst({
    where: {
      subjectId: englishSubject.subjectId,
      topicName: "12 Tenses & Parts of Speech"
    }
  });
  if (!englishTopic) {
    englishTopic = await prisma.topic.create({
      data: {
        subjectId: englishSubject.subjectId,
        topicName: "12 Tenses & Parts of Speech",
        description: "Comprehensive 12 Tenses and Parts of Speech for English Exam Preparation"
      }
    });
    console.log(`Created Topic [ID: ${englishTopic.topicId}]: ${englishTopic.topicName}`);
  } else {
    console.log(`Using existing Topic [ID: ${englishTopic.topicId}]: ${englishTopic.topicName}`);
  }

  // Sync topic sequence
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('topic', 'topic_id'), (SELECT COALESCE(MAX(topic_id), 1) FROM topic))"
  );
  console.log("Topic sequence synced.");

  // 3. Prepare questions and options
  const questionsToInsert = [];
  const optionsToInsert = [];

  let qId = 1400;

  for (const q of englishQuestions) {
    const currentQId = qId++;

    questionsToInsert.push({
      questionId: currentQId,
      topicId: englishTopic.topicId,
      examName: "All",
      subjectName: "English",
      questionText: cleanText(q.questionText),
      questionType: "multiple_choice",
      difficultyLevel: (q.difficultyLevel || "medium").toLowerCase(),
      correctAnswer: cleanText(q.correctAnswer),
      explanation: cleanText(q.explanation),
      referenceNote: cleanText(q.referenceNote)
    });

    for (const opt of q.options) {
      optionsToInsert.push({
        questionId: currentQId,
        optionText: cleanText(opt.text),
        isCorrect: Boolean(opt.isCorrect)
      });
    }
  }

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 1400 to 1499) and ${optionsToInsert.length} options.`);

  // 4. Clean up any existing questions with ID >= 1400 if re-running
  const existingQuestions = await prisma.question.findMany({
    where: { questionId: { gte: 1400 } },
    select: { questionId: true }
  });
  if (existingQuestions.length > 0) {
    console.log(`Found ${existingQuestions.length} existing questions with ID >= 1400. Deleting to ensure clean re-insert...`);
    await prisma.answerOption.deleteMany({
      where: { questionId: { gte: 1400 } }
    });
    await prisma.question.deleteMany({
      where: { questionId: { gte: 1400 } }
    });
  }

  // 5. Batch insert questions
  console.log(`Inserting ${questionsToInsert.length} questions into 'question' table...`);
  const qResult = await prisma.question.createMany({
    data: questionsToInsert
  });
  console.log(`Successfully inserted ${qResult.count} questions.`);

  // 6. Batch insert answer options in chunks of 100
  console.log(`Inserting ${optionsToInsert.length} answer options into 'answer_option' table...`);
  const optChunkSize = 100;
  let totalOptionsInserted = 0;
  for (let i = 0; i < optionsToInsert.length; i += optChunkSize) {
    const chunk = optionsToInsert.slice(i, i + optChunkSize);
    const optResult = await prisma.answerOption.createMany({
      data: chunk
    });
    totalOptionsInserted += optResult.count;
  }
  console.log(`Successfully inserted ${totalOptionsInserted} answer options.`);

  // 7. Update Sequences
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('question', 'question_id'), (SELECT COALESCE(MAX(question_id), 1) FROM question))"
  );
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('answer_option', 'option_id'), (SELECT COALESCE(MAX(option_id), 1) FROM answer_option))"
  );
  console.log("Sequences for question and answer_option updated successfully.");

  // 8. Verification
  console.log("\n=== Running Verification ===");
  const totalQuestions = await prisma.question.count();
  const maxQuestionId = await prisma.question.aggregate({ _max: { questionId: true } });
  const totalOptions = await prisma.answerOption.count();

  const englishCount = await prisma.question.count({
    where: { subjectName: "English", examName: "All" }
  });

  const distinctExams = await prisma.question.groupBy({
    by: ['examName'],
    _count: { questionId: true }
  });

  const distinctSubjects = await prisma.question.groupBy({
    by: ['subjectName', 'examName'],
    _count: { questionId: true }
  });

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 1499)`);
  console.log(`Max Question ID in DB: ${maxQuestionId._max.questionId} (Expected: 1499)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 6001)`);
  console.log(`English questions with examName "All": ${englishCount} (Expected: 100)`);

  console.log("\n--- Questions per Exam Name ---");
  for (const group of distinctExams) {
    console.log(`- ${group.examName || "NULL"}: ${group._count.questionId}`);
  }

  console.log("\n--- Questions per Subject & Exam Name ---");
  for (const group of distinctSubjects) {
    console.log(`- Subject: ${group.subjectName || "NULL"} | Exam: ${group.examName || "NULL"} -> ${group._count.questionId}`);
  }

  // Sample check: Question 1400 and Question 1499
  const sampleQ1 = await prisma.question.findUnique({
    where: { questionId: 1400 },
    include: { answerOptions: true, topic: true }
  });
  const sampleQ2 = await prisma.question.findUnique({
    where: { questionId: 1499 },
    include: { answerOptions: true, topic: true }
  });

  console.log("\n--- Sample Q1400 ---");
  console.log({
    id: sampleQ1.questionId,
    subject: sampleQ1.subjectName,
    exam: sampleQ1.examName,
    text: sampleQ1.questionText,
    correct: sampleQ1.correctAnswer,
    options: sampleQ1.answerOptions.map(o => ({ text: o.optionText, isCorrect: o.isCorrect }))
  });

  console.log("\n--- Sample Q1499 ---");
  console.log({
    id: sampleQ2.questionId,
    subject: sampleQ2.subjectName,
    exam: sampleQ2.examName,
    text: sampleQ2.questionText,
    correct: sampleQ2.correctAnswer,
    options: sampleQ2.answerOptions.map(o => ({ text: o.optionText, isCorrect: o.isCorrect }))
  });

  console.log("\nSeeding of English questions completed successfully!");
}

main()
  .catch((e) => {
    console.error("Error seeding English questions:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

