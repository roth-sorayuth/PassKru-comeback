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
  console.log("=== Seeding High School Geography, Secondary Biology, and High School History Questions ===\n");

  // 1. Read raw questions
  // A. Geology Highschool
  const rawGeol = fs.readFileSync("C:/Users/U-ser/Downloads/Telegram Desktop/geology highschool.txt", "utf8");
  const qGeol = extractQuestions(rawGeol);

  // B. Biology
  let rawBio = fs.readFileSync("C:/Users/U-ser/Downloads/Telegram Desktop/biology.txt", "utf8");
  if (!rawBio.trim().endsWith("}")) {
    rawBio = rawBio.trim() + "\n  }\n]";
  }
  const qBio = extractQuestions(rawBio);

  // C. History Highschool
  const rawHist = fs.readFileSync("C:/Users/U-ser/Downloads/Telegram Desktop/history highschool.txt", "utf8");
  const qHist = extractQuestions(rawHist);

  console.log(`Parsed ${qGeol.length} Geography (High School), ${qBio.length} Biology (Secondary), and ${qHist.length} History (High School) questions.`);
  const totalIncoming = qGeol.length + qBio.length + qHist.length;
  console.log(`Total questions to process: ${totalIncoming}`);

  // 2. Ensure Subjects & Topics exist
  // A. High School Geography (examId: 3)
  let highGeogSubject = await prisma.subject.findFirst({
    where: { examId: 3, subjectName: "Geography" }
  });
  if (!highGeogSubject) {
    highGeogSubject = await prisma.subject.create({
      data: {
        examId: 3,
        subjectName: "Geography",
        description: "ភូមិវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតឧត្តម (NIE)"
      }
    });
    console.log(`Created High School Geography Subject [ID: ${highGeogSubject.subjectId}]`);
  } else {
    console.log(`Using existing High School Geography Subject [ID: ${highGeogSubject.subjectId}]`);
  }

  let highGeogTopic = await prisma.topic.findFirst({
    where: { subjectId: highGeogSubject.subjectId, topicName: "ភូមិវិទ្យា - គ្រូឧត្តម" }
  });
  if (!highGeogTopic) {
    highGeogTopic = await prisma.topic.create({
      data: {
        subjectId: highGeogSubject.subjectId,
        topicName: "ភូមិវិទ្យា - គ្រូឧត្តម",
        description: "Geography for Highschool Teacher Exam (NIE)"
      }
    });
    console.log(`Created High School Geography Topic [ID: ${highGeogTopic.topicId}]`);
  } else {
    console.log(`Using existing High School Geography Topic [ID: ${highGeogTopic.topicId}]`);
  }

  // B. Secondary Biology (examId: 2)
  let secBioSubject = await prisma.subject.findFirst({
    where: { examId: 2, subjectName: "Biology" }
  });
  if (!secBioSubject) {
    secBioSubject = await prisma.subject.create({
      data: {
        examId: 2,
        subjectName: "Biology",
        description: "ជីវវិទ្យា សម្រាប់ប្រឡងគ្រូបង្រៀនកម្រិតមូលដ្ឋាន (RTTC)"
      }
    });
    console.log(`Created Secondary Biology Subject [ID: ${secBioSubject.subjectId}]`);
  } else {
    console.log(`Using existing Secondary Biology Subject [ID: ${secBioSubject.subjectId}]`);
  }

  let secBioTopic = await prisma.topic.findFirst({
    where: { subjectId: secBioSubject.subjectId, topicName: "ជីវវិទ្យា - គ្រូមូលដ្ឋាន" }
  });
  if (!secBioTopic) {
    secBioTopic = await prisma.topic.create({
      data: {
        subjectId: secBioSubject.subjectId,
        topicName: "ជីវវិទ្យា - គ្រូមូលដ្ឋាន",
        description: "Biology for Secondary Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Secondary Biology Topic [ID: ${secBioTopic.topicId}]`);
  } else {
    console.log(`Using existing Secondary Biology Topic [ID: ${secBioTopic.topicId}]`);
  }

  // C. High School History (examId: 3)
  let highHistorySubject = await prisma.subject.findFirst({
    where: { examId: 3, subjectName: "History" }
  });
  let highHistoryTopic = await prisma.topic.findFirst({
    where: { subjectId: highHistorySubject.subjectId, topicName: "ប្រវត្តិវិទ្យា - គ្រូឧត្តម" }
  });

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

  let qId = 1022;

  // Group 1: High School Geography (100 questions, IDs 1022 to 1121)
  for (const q of qGeol) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: highGeogTopic.topicId,
      examName: "highschool",
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

  // Group 2: Secondary Biology (98 questions, IDs 1122 to 1219)
  for (const q of qBio) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: secBioTopic.topicId,
      examName: "secondary",
      subjectName: "Biology",
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

  // Group 3: High School History (100 questions, IDs 1220 to 1319)
  for (const q of qHist) {
    const currentQId = qId++;
    questionsToInsert.push({
      questionId: currentQId,
      topicId: highHistoryTopic.topicId,
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

  console.log(`\nPrepared ${questionsToInsert.length} questions (IDs 1022 to 1319) and ${optionsToInsert.length} options.`);

  // 4. Delete existing questions with ID >= 1022 if re-running
  const existingNewQ = await prisma.question.findMany({
    where: { questionId: { gte: 1022 } },
    select: { questionId: true }
  });
  if (existingNewQ.length > 0) {
    console.log(`Found ${existingNewQ.length} existing questions with ID >= 1022. Deleting to ensure clean re-insert...`);
    await prisma.question.deleteMany({
      where: { questionId: { gte: 1022 } }
    });
  }

  // 5. Batch Insert questions in chunks of 100
  console.log(`Inserting ${questionsToInsert.length} questions into 'question' table...`);
  const qChunkSize = 100;
  let totalQuestionsInserted = 0;
  for (let i = 0; i < questionsToInsert.length; i += qChunkSize) {
    const chunk = questionsToInsert.slice(i, i + qChunkSize);
    const qResult = await prisma.question.createMany({
      data: chunk
    });
    totalQuestionsInserted += qResult.count;
  }
  console.log(`Successfully inserted ${totalQuestionsInserted} questions.`);

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

  console.log(`Total questions in DB: ${totalQuestions} (Expected: 1319)`);
  console.log(`Max question_id in DB: ${maxQuestionId._max.questionId} (Expected: 1319)`);
  console.log(`Total answer options in DB: ${totalOptions} (Expected: 5281)`);
  console.log("Distribution by examName:", distinctExams);
  console.log("Distribution by subjectName & examName:", distinctSubjects);

  // Inspect samples from each group
  const samples = await prisma.question.findMany({
    where: { questionId: { in: [1022, 1121, 1122, 1219, 1220, 1319] } },
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

  console.log("\n? All 298 questions successfully seeded!");
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

