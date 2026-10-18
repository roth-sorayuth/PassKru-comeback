import { prisma } from "./src/config/prisma.js";
import fs from "fs";

function extractQuestions(str) {
  const questions = [];
  let inString = false;
  let escape = false;
  let depth = 0;
  let start = -1;

  for (let i = 0; i < str.length; i++) {
    const char = str[i];
    if (inString) {
      if (escape) escape = false;
      else if (char === '\\') escape = true;
      else if (char === '"') inString = false;
      continue;
    }
    if (char === '"') { inString = true; continue; }
    if (char === '{') {
      if (depth === 0) start = i;
      depth++;
    } else if (char === '}') {
      depth--;
      if (depth === 0 && start !== -1) {
        const objStr = str.slice(start, i + 1);
        try {
          const parsed = JSON.parse(objStr);
          if (parsed.questionID || parsed.questionText) questions.push(parsed);
        } catch (e) {
          console.error("Error parsing JSON object:", e.message);
        }
        start = -1;
      }
    }
  }
  return questions;
}

function cleanText(text) {
  if (!text) return text;
  return text.replace(/\s*\[cite:[^\]]+\]/g, '').trim();
}

async function main() {
  console.log("=== Seeding Geography Questions into Database ===\n");

  // 1. Read raw questions
  const filePath = "C:/Users/U-ser/.gemini/antigravity/brain/44f57687-23ad-428d-b3ec-18402c05c914/.user_uploaded/media_1792332362441_e52e9ad0.txt";
  const rawContent = fs.readFileSync(filePath, "utf8");
  const rawQuestions = extractQuestions(rawContent);

  console.log(`Parsed ${rawQuestions.length} questions from source file.`);
  if (rawQuestions.length !== 100) {
    throw new Error(`Expected 100 questions, got ${rawQuestions.length}`);
  }

  // 2. Ensure Subject & Topic exist under Exam 2 (Secondary)
  let geogSubject = await prisma.subject.findFirst({
    where: { examId: 2, subjectName: "Geography" }
  });
  if (!geogSubject) {
    geogSubject = await prisma.subject.create({
      data: {
        examId: 2,
        subjectName: "Geography",
        description: "ភូមិវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតមូលដ្ឋាន (RTTC)"
      }
    });
    console.log(`Created Secondary Geography Subject [ID: ${geogSubject.subjectId}]`);
  } else {
    console.log(`Using existing Secondary Geography Subject [ID: ${geogSubject.subjectId}]`);
  }

  let geogTopic = await prisma.topic.findFirst({
    where: { subjectId: geogSubject.subjectId, topicName: "ភូមិវិទ្យា - គ្រូមូលដ្ឋាន" }
  });
  if (!geogTopic) {
    geogTopic = await prisma.topic.create({
      data: {
        subjectId: geogSubject.subjectId,
        topicName: "ភូមិវិទ្យា - គ្រូមូលដ្ឋាន",
        description: "Geography for Secondary Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Secondary Geography Topic [ID: ${geogTopic.topicId}]`);
  } else {
    console.log(`Using existing Secondary Geography Topic [ID: ${geogTopic.topicId}]`);
  }

  // Sync subject and topic sequences
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('subject', 'subject_id'), (SELECT COALESCE(MAX(subject_id), 1) FROM subject))"
  );
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('topic', 'topic_id'), (SELECT COALESCE(MAX(topic_id), 1) FROM topic))"
  );
  console.log("Subject and Topic sequences synced.");

  // 3. Prepare questions and options
  const questionsToInsert = [];
  const optionsToInsert = [];

  let qId = 922;

  for (const q of rawQuestions) {
    const currentQId = qId++;

    questionsToInsert.push({
      questionId: currentQId,
      topicId: geogTopic.topicId,
      examName: "secondary",
      subjectName: "Geography",
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

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 922 to 1021) and ${optionsToInsert.length} options.`);

  // 4. Delete existing questions with ID >= 922 if re-running
  const existingNewQ = await prisma.question.findMany({
    where: { questionId: { gte: 922 } },
    select: { questionId: true }
  });
  if (existingNewQ.length > 0) {
    console.log(`Found ${existingNewQ.length} existing questions with ID >= 922. Deleting to ensure clean re-insert...`);
    await prisma.question.deleteMany({
      where: { questionId: { gte: 922 } }
    });
  }

  // 5. Batch Insert questions
  console.log("Inserting 100 questions into 'question' table...");
  const qResult = await prisma.question.createMany({
    data: questionsToInsert
  });
  console.log(`Successfully inserted ${qResult.count} questions.`);

  // 6. Batch Insert answer options
  console.log("Inserting 400 answer options into 'answer_option' table...");
  const chunkSize = 100;
  let totalOptionsInserted = 0;
  for (let i = 0; i < optionsToInsert.length; i += chunkSize) {
    const chunk = optionsToInsert.slice(i, i + chunkSize);
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

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 1021)`);
  console.log(`Max question_id in DB: ${maxQuestionId._max.questionId} (Expected: 1021)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 4089)`);
  console.log("Distribution by examName:", distinctExams);
  console.log("Distribution by subjectName & examName:", distinctSubjects);

  // Inspect samples
  const samples = await prisma.question.findMany({
    where: { questionId: { in: [922, 950, 980, 1021] } },
    include: { answerOptions: true, topic: { include: { subject: true } } },
    orderBy: { questionId: "asc" }
  });

  for (const s of samples) {
    console.log(`\n[ID: ${s.questionId}] Exam: "${s.examName}" | Subject: "${s.subjectName}" | Topic: "${s.topic.topicName}"`);
    console.log(`  Question: ${s.questionText.slice(0, 70)}...`);
    console.log(`  Explanation: ${s.explanation.slice(0, 70)}...`);
    console.log(`  Options count: ${s.answerOptions.length}`);
    const correct = s.answerOptions.filter(o => o.isCorrect);
    console.log(`  Correct option: "${correct[0]?.optionText}"`);
  }

  console.log("\n? Geography questions successfully seeded!");
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
