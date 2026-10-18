import { prisma } from "./src/config/prisma.js";
import fs from "fs";

function extractJsonBlocks(str) {
  const blocks = [];
  let depth = 0;
  let start = -1;
  for (let i = 0; i < str.length; i++) {
    if (str[i] === '[') {
      if (depth === 0) start = i;
      depth++;
    } else if (str[i] === ']') {
      depth--;
      if (depth === 0 && start !== -1) {
        blocks.push(str.slice(start, i + 1));
        start = -1;
      }
    }
  }
  return blocks;
}

function cleanText(text) {
  if (!text) return text;
  return text.replace(/\s*\[cite:[^\]]+\]/g, '').trim();
}

async function main() {
  console.log("=== Seeding History Questions into Database ===\n");

  // 1. Read raw questions
  const filePath = "C:/Users/U-ser/Downloads/Telegram Desktop/History middle school.txt";
  const rawContent = fs.readFileSync(filePath, "utf8");
  const blocks = extractJsonBlocks(rawContent);
  const rawSec = JSON.parse(blocks[0]);
  const rawHigh = JSON.parse(blocks[1]);

  console.log(`Read ${rawSec.length} Secondary and ${rawHigh.length} Highschool questions from source file.`);

  // 2. Ensure Subjects exist
  // Secondary History (examId: 2)
  let secSubject = await prisma.subject.findFirst({
    where: { examId: 2, subjectName: "History" }
  });
  if (!secSubject) {
    secSubject = await prisma.subject.create({
      data: {
        examId: 2,
        subjectName: "History",
        description: "ប្រវត្តិវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតមូលដ្ឋាន (RTTC)"
      }
    });
    console.log(`Created Secondary History Subject [ID: ${secSubject.subjectId}]`);
  } else {
    console.log(`Using existing Secondary History Subject [ID: ${secSubject.subjectId}]`);
  }

  // High School History (examId: 3)
  let highSubject = await prisma.subject.findFirst({
    where: { examId: 3, subjectName: "History" }
  });
  if (!highSubject) {
    highSubject = await prisma.subject.create({
      data: {
        examId: 3,
        subjectName: "History",
        description: "ប្រវត្តិវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតឧត្តម (NIE)"
      }
    });
    console.log(`Created High School History Subject [ID: ${highSubject.subjectId}]`);
  } else {
    console.log(`Using existing High School History Subject [ID: ${highSubject.subjectId}]`);
  }

  // 3. Ensure Topics exist
  // Secondary History Topic
  let secTopic = await prisma.topic.findFirst({
    where: { subjectId: secSubject.subjectId, topicName: "ប្រវត្តិវិទ្យា - គ្រូមូលដ្ឋាន" }
  });
  if (!secTopic) {
    secTopic = await prisma.topic.create({
      data: {
        subjectId: secSubject.subjectId,
        topicName: "ប្រវត្តិវិទ្យា - គ្រូមូលដ្ឋាន",
        description: "General History for Secondary Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Secondary History Topic [ID: ${secTopic.topicId}]`);
  } else {
    console.log(`Using existing Secondary History Topic [ID: ${secTopic.topicId}]`);
  }

  // High School History Topic
  let highTopic = await prisma.topic.findFirst({
    where: { subjectId: highSubject.subjectId, topicName: "ប្រវត្តិវិទ្យា - គ្រូឧត្តម" }
  });
  if (!highTopic) {
    highTopic = await prisma.topic.create({
      data: {
        subjectId: highSubject.subjectId,
        topicName: "ប្រវត្តិវិទ្យា - គ្រូឧត្តម",
        description: "General History for Highschool Teacher Exam (NIE)"
      }
    });
    console.log(`Created High School History Topic [ID: ${highTopic.topicId}]`);
  } else {
    console.log(`Using existing High School History Topic [ID: ${highTopic.topicId}]`);
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

  let qId = 612;

  // Secondary questions: 612 - 661
  for (const q of rawSec) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: secTopic.topicId,
      examName: "secondary",
      subjectName: "History",
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

  // Highschool questions: 662 - 711
  for (const q of rawHigh) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: highTopic.topicId,
      examName: "highschool",
      subjectName: "History",
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

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 612 to 711) and ${optionsToInsert.length} options.`);

  // 5. Delete existing questions with ID >= 612 if re-running
  const existingNewQ = await prisma.question.findMany({
    where: { questionId: { gte: 612 } },
    select: { questionId: true }
  });
  if (existingNewQ.length > 0) {
    console.log(`Found ${existingNewQ.length} existing questions with ID >= 612. Deleting to ensure clean re-insert...`);
    await prisma.question.deleteMany({
      where: { questionId: { gte: 612 } }
    });
  }

  // 6. Batch Insert questions
  console.log("Inserting 100 questions into 'question' table...");
  const qResult = await prisma.question.createMany({
    data: questionsToInsert
  });
  console.log(`Successfully inserted ${qResult.count} questions.`);

  // 7. Batch Insert answer options
  console.log("Inserting 400 answer options into 'answer_option' table...");
  // Insert in chunks of 100 to avoid payload size limitations
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
  const secQuestionsCount = await prisma.question.count({
    where: { examName: "secondary", subjectName: "History" }
  });
  const highQuestionsCount = await prisma.question.count({
    where: { examName: "highschool", subjectName: "History" }
  });

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 711)`);
  console.log(`Max question_id in DB: ${maxQuestionId._max.questionId} (Expected: 711)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 2849)`);
  console.log(`Secondary History questions count: ${secQuestionsCount} (Expected: 50)`);
  console.log(`Highschool History questions count: ${highQuestionsCount} (Expected: 50)`);

  // Inspect first secondary, last secondary, first highschool, last highschool
  const samples = await prisma.question.findMany({
    where: { questionId: { in: [612, 661, 662, 711] } },
    include: { answerOptions: true, topic: { include: { subject: true } } },
    orderBy: { questionId: "asc" }
  });

  for (const s of samples) {
    console.log(`\n[ID: ${s.questionId}] Exam: "${s.examName}" | Subject: "${s.subjectName}" | Topic: "${s.topic.topicName}"`);
    console.log(`  Question: ${s.questionText.slice(0, 60)}...`);
    console.log(`  Explanation: ${s.explanation.slice(0, 60)}...`);
    console.log(`  Options count: ${s.answerOptions.length}`);
    const correct = s.answerOptions.filter(o => o.isCorrect);
    console.log(`  Correct option: "${correct[0]?.optionText}"`);
  }

  console.log("\n Seeding completed successfully!");
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
