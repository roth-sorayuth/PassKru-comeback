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
          console.error(`Error parsing JSON object:`, e.message);
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
  console.log("=== Seeding Elementary Mathematics Questions into Database ===\n");

  // 1. Read raw questions
  const filePath = "C:/Users/U-ser/.gemini/antigravity/brain/44f57687-23ad-428d-b3ec-18402c05c914/.user_uploaded/media_1792332181122_a4bbca25.txt";
  const rawContent = fs.readFileSync(filePath, "utf8");
  const rawQuestions = extractQuestions(rawContent);

  console.log(`Parsed ${rawQuestions.length} questions from source file.`);
  if (rawQuestions.length !== 110) {
    throw new Error(`Expected 110 questions, got ${rawQuestions.length}`);
  }

  // 2. Ensure Subject exists under Exam 1 (Elementary)
  let elemSubject = await prisma.subject.findFirst({
    where: { examId: 1, subjectName: "Mathematics" }
  });
  if (!elemSubject) {
    elemSubject = await prisma.subject.create({
      data: {
        examId: 1,
        subjectName: "Mathematics",
        description: "គណិតវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតបឋមសិក្សា"
      }
    });
    console.log(`Created Elementary Mathematics Subject [ID: ${elemSubject.subjectId}]`);
  } else {
    console.log(`Using existing Elementary Mathematics Subject [ID: ${elemSubject.subjectId}]`);
  }

  // 3. Ensure Topic exists under this Subject
  let elemTopic = await prisma.topic.findFirst({
    where: { subjectId: elemSubject.subjectId, topicName: "គណិតវិទ្យា - គ្រូបឋម" }
  });
  if (!elemTopic) {
    elemTopic = await prisma.topic.create({
      data: {
        subjectId: elemSubject.subjectId,
        topicName: "គណិតវិទ្យា - គ្រូបឋម",
        description: "General Mathematics for Elementary Teacher Exam"
      }
    });
    console.log(`Created Elementary Mathematics Topic [ID: ${elemTopic.topicId}]`);
  } else {
    console.log(`Using existing Elementary Mathematics Topic [ID: ${elemTopic.topicId}]`);
  }

  // Sync subject and topic sequences
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('subject', 'subject_id'), (SELECT COALESCE(MAX(subject_id), 1) FROM subject))"
  );
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('topic', 'topic_id'), (SELECT COALESCE(MAX(topic_id), 1) FROM topic))"
  );
  console.log("Subject and Topic sequences synced.");

  // 4. Prepare questions and options
  const questionsToInsert = [];
  const optionsToInsert = [];

  let qId = 712;

  for (const q of rawQuestions) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: elemTopic.topicId,
      examName: "elementary",
      subjectName: "Mathematics",
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

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 712 to 821) and ${optionsToInsert.length} options.`);

  // 5. Clean up any existing records with ID >= 712 if re-running
  const existingNewQ = await prisma.question.findMany({
    where: { questionId: { gte: 712 } },
    select: { questionId: true }
  });
  if (existingNewQ.length > 0) {
    console.log(`Found ${existingNewQ.length} existing questions with ID >= 712. Deleting to ensure clean re-insert...`);
    await prisma.question.deleteMany({
      where: { questionId: { gte: 712 } }
    });
  }

  // 6. Batch Insert questions
  console.log("Inserting 110 questions into 'question' table...");
  const qResult = await prisma.question.createMany({
    data: questionsToInsert
  });
  console.log(`Successfully inserted ${qResult.count} questions.`);

  // 7. Batch Insert answer options
  console.log("Inserting 440 answer options into 'answer_option' table...");
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

  // 8. Update Sequences
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('question', 'question_id'), (SELECT COALESCE(MAX(question_id), 1) FROM question))"
  );
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('answer_option', 'option_id'), (SELECT COALESCE(MAX(option_id), 1) FROM answer_option))"
  );
  console.log("Sequences for question and answer_option updated successfully.");

  // 9. Verification
  console.log("\n=== Running Verification ===");
  const totalQuestions = await prisma.question.count();
  const maxQuestionId = await prisma.question.aggregate({ _max: { questionId: true } });
  const totalOptions = await prisma.answerOption.count();
  const elemMathCount = await prisma.question.count({
    where: { examName: "elementary", subjectName: "Mathematics" }
  });

  const distinctExams = await prisma.question.groupBy({
    by: ['examName'],
    _count: { questionId: true }
  });

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 821)`);
  console.log(`Max question_id in DB: ${maxQuestionId._max.questionId} (Expected: 821)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 3289)`);
  console.log(`Elementary Mathematics questions count: ${elemMathCount} (Expected: 110)`);
  console.log("Distribution by examName:", distinctExams);

  // Inspect first, middle, last sample questions
  const samples = await prisma.question.findMany({
    where: { questionId: { in: [712, 722, 770, 821] } },
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

  console.log("\n? Elementary Mathematics questions successfully seeded!");
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
