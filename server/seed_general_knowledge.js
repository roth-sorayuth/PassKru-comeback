import { prisma } from "./src/config/prisma.js";
import fs from "fs";

function cleanText(text) {
  if (!text) return text;
  return text.replace(/\s*\[cite:[^\]]+\]/g, '').trim();
}

async function main() {
  console.log("=== Seeding General Knowledge Questions into Database ===\n");

  // 1. Read raw questions from raw_gk_prompt.json
  const content = fs.readFileSync("D:/PassKru67/PassKru-comeback/server/raw_gk_prompt.json", "utf8");
  const jsonStart = content.indexOf("[");
  const jsonEnd = content.lastIndexOf("]");
  const rawQuestions = JSON.parse(content.slice(jsonStart, jsonEnd + 1));

  console.log(`Parsed ${rawQuestions.length} questions from prompt source.`);
  if (rawQuestions.length !== 80) {
    throw new Error(`Expected 80 questions, got ${rawQuestions.length}`);
  }

  // 2. Ensure Topic exists under General Knowledge Subject (ID: 3)
  let gkSubject = await prisma.subject.findFirst({
    where: { subjectId: 3 }
  });
  if (!gkSubject) {
    // If not found, find by name
    gkSubject = await prisma.subject.findFirst({
      where: { subjectName: "General Knowledge" }
    });
  }
  if (!gkSubject) {
    throw new Error("General Knowledge subject not found in database!");
  }
  console.log(`Using General Knowledge Subject [ID: ${gkSubject.subjectId}]`);

  let gkTopic = await prisma.topic.findFirst({
    where: { subjectId: gkSubject.subjectId, topicName: "ចំណេះដឹងទូទៅ និង ព្រឹត្តិការណ៍បច្ចុប្បន្ន" }
  });
  if (!gkTopic) {
    gkTopic = await prisma.topic.create({
      data: {
        subjectId: gkSubject.subjectId,
        topicName: "ចំណេះដឹងទូទៅ និង ព្រឹត្តិការណ៍បច្ចុប្បន្ន",
        description: "General Knowledge and Current Affairs for Civil Service and Teacher Recruitment Exam"
      }
    });
    console.log(`Created Topic [ID: ${gkTopic.topicId}]: ${gkTopic.topicName}`);
  } else {
    console.log(`Using existing Topic [ID: ${gkTopic.topicId}]: ${gkTopic.topicName}`);
  }

  // Sync topic sequence
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('topic', 'topic_id'), (SELECT COALESCE(MAX(topic_id), 1) FROM topic))"
  );
  console.log("Topic sequence synced.");

  // 3. Prepare questions and options
  const questionsToInsert = [];
  const optionsToInsert = [];

  let qId = 1320;

  for (const q of rawQuestions) {
    const currentQId = qId++;

    questionsToInsert.push({
      questionId: currentQId,
      topicId: gkTopic.topicId,
      examName: "All",
      subjectName: "General Knowledge",
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

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 1320 to 1399) and ${optionsToInsert.length} options.`);

  // 4. Delete existing questions with ID >= 1320 if re-running
  const existingNewQ = await prisma.question.findMany({
    where: { questionId: { gte: 1320 } },
    select: { questionId: true }
  });
  if (existingNewQ.length > 0) {
    console.log(`Found ${existingNewQ.length} existing questions with ID >= 1320. Deleting to ensure clean re-insert...`);
    await prisma.question.deleteMany({
      where: { questionId: { gte: 1320 } }
    });
  }

  // 5. Batch Insert questions in chunks of 100
  console.log(`Inserting ${questionsToInsert.length} questions into 'question' table...`);
  const qResult = await prisma.question.createMany({
    data: questionsToInsert
  });
  console.log(`Successfully inserted ${qResult.count} questions.`);

  // 6. Batch Insert answer options in chunks of 100
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

  const distinctExams = await prisma.question.groupBy({
    by: ['examName'],
    _count: { questionId: true }
  });

  const distinctSubjects = await prisma.question.groupBy({
    by: ['subjectName', 'examName'],
    _count: { questionId: true }
  });

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 1399)`);
  console.log(`Max question_id in DB: ${maxQuestionId._max.questionId} (Expected: 1399)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 5601)`);
  console.log("Distribution by examName:", distinctExams);
  console.log("Distribution by subjectName & examName:", distinctSubjects);

  // Inspect samples
  const samples = await prisma.question.findMany({
    where: { questionId: { in: [1320, 1340, 1360, 1399] } },
    include: { answerOptions: true, topic: { include: { subject: true } } },
    orderBy: { questionId: "asc" }
  });

  for (const s of samples) {
    console.log(`\n[ID: ${s.questionId}] Exam: "${s.examName}" | Subject: "${s.subjectName}" | Topic: "${s.topic.topicName}"`);
    console.log(`  Question: ${s.questionText.slice(0, 70)}...`);
    console.log(`  Explanation: ${s.explanation.slice(0, 70)}...`);
    console.log(`  Reference: ${s.referenceNote}`);
    console.log(`  Options count: ${s.answerOptions.length}`);
    const correct = s.answerOptions.filter(o => o.isCorrect);
    console.log(`  Correct option: "${correct[0]?.optionText}"`);
  }

  console.log("\n? General Knowledge questions successfully seeded!");
}

main()
  .catch((err) => {
    console.error("Error during seeding:", err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    process.exit(0);
  });

