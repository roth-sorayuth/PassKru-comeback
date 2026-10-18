import fs from "fs";
import { prisma } from "./src/config/prisma.js";

async function main() {
  console.log("=== Seeding Secondary Mathematics Questions (IDs 1-150, multiple_choice) ===\n");

  const questions = JSON.parse(
    fs.readFileSync("secondary_math_questions.json", "utf8")
  );
  console.log(`Loaded ${questions.length} questions from secondary_math_questions.json`);

  // 1. Ensure Exam exists
  let exam = await prisma.exam.findFirst({
    where: {
      OR: [
        { examId: 2 },
        { targetCode: "secondary" },
        { targetCode: "rttc" },
        { examName: { contains: "Secondary" } },
        { examName: { contains: "មូលដ្ឋាន" } }
      ]
    }
  });

  if (!exam) {
    exam = await prisma.exam.create({
      data: {
        examId: 2,
        examName: "Secondary National Exam",
        targetCode: "secondary",
        examType: "កម្រិតមូលដ្ឋាន",
        category: "secondary",
        description: "Secondary School Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Exam: [ID: ${exam.examId}] ${exam.examName}`);
  } else {
    console.log(`Using existing Exam: [ID: ${exam.examId}] ${exam.examName}`);
  }

  // 2. Ensure Subject exists
  let subject = await prisma.subject.findFirst({
    where: {
      examId: exam.examId,
      subjectName: "Mathematics"
    }
  });

  if (!subject) {
    subject = await prisma.subject.create({
      data: {
        examId: exam.examId,
        subjectName: "Mathematics",
        description: "Secondary Teacher Mathematics"
      }
    });
    console.log(`Created Subject: [ID: ${subject.subjectId}] ${subject.subjectName}`);
  } else {
    console.log(`Using existing Subject: [ID: ${subject.subjectId}] ${subject.subjectName}`);
  }

  // 3. Ensure Topics 1-7 exist
  const topicDefinitions = [
    { id: 1, name: "ចំនួនកុំផ្លិច និង សមីការ", desc: "Complex numbers, polynomial and exponential equations" },
    { id: 2, name: "អាំងតេក្រាល និង ផ្ទៃក្រឡា", desc: "Indefinite & definite integrals, bounded areas" },
    { id: 3, name: "ព្រីមីទីវ និង ដេរីវេ", desc: "Primitives, derivatives, and applications" },
    { id: 4, name: "អនុគមន៍ និង ភាពជាប់", desc: "Functions, limits, and continuity" },
    { id: 5, name: "ធរណីមាត្រ និង ប្លង់ក្នុងលំហ", desc: "3D geometry, planes, spheres, and vectors" },
    { id: 6, name: "វិភាគបន្សំ និង ប្រូបាប", desc: "Combinatorics, permutations, and probability" },
    { id: 7, name: "សមីការឌីផេរ៉ង់ស្យែល", desc: "Differential equations and curves" }
  ];

  for (const t of topicDefinitions) {
    const existing = await prisma.topic.findUnique({ where: { topicId: t.id } });
    if (!existing) {
      await prisma.topic.create({
        data: {
          topicId: t.id,
          subjectId: subject.subjectId,
          topicName: t.name,
          description: t.desc
        }
      });
      console.log(`Created Topic [ID: ${t.id}]: ${t.name}`);
    } else {
      console.log(`Topic [ID: ${t.id}] exists: ${existing.topicName}`);
    }
  }

  // 4. Clean up previously inserted questions with IDs 861-1010
  console.log("\nCleaning up existing questions with IDs 861..1010...");
  const oldQuestionIds = [];
  for (let id = 861; id <= 1010; id++) oldQuestionIds.push(id);
  
  await prisma.answerOption.deleteMany({
    where: { questionId: { in: oldQuestionIds } }
  });
  const deletedOld = await prisma.question.deleteMany({
    where: { questionId: { in: oldQuestionIds } }
  });
  console.log(`Removed ${deletedOld.count} old question records.`);

  // 5. Insert Questions (IDs 1-150)
  console.log("\nInserting questions with IDs 1..150 and question_type='multiple_choice'...");
  let inserted = 0;
  let updated = 0;

  for (const q of questions) {
    const existing = await prisma.question.findUnique({
      where: { questionId: q.questionId }
    });

    if (!existing) {
      await prisma.question.create({
        data: {
          questionId: q.questionId,
          topicId: q.topicId,
          examName: "secondary",
          subjectName: "Mathematics",
          questionText: q.questionText,
          questionType: "multiple_choice",
          difficultyLevel: q.difficultyLevel,
          correctAnswer: q.correctAnswer,
          explanation: q.explanation,
          referenceNote: q.referenceNote,
          answerOptions: {
            create: (q.options || []).map((opt) => ({
              optionText: opt.text,
              isCorrect: opt.isCorrect
            }))
          }
        }
      });
      inserted++;
    } else {
      await prisma.question.update({
        where: { questionId: q.questionId },
        data: {
          topicId: q.topicId,
          examName: "secondary",
          subjectName: "Mathematics",
          questionText: q.questionText,
          questionType: "multiple_choice",
          difficultyLevel: q.difficultyLevel,
          correctAnswer: q.correctAnswer,
          explanation: q.explanation,
          referenceNote: q.referenceNote
        }
      });

      if (q.options && q.options.length > 0) {
        await prisma.answerOption.deleteMany({
          where: { questionId: q.questionId }
        });
        await prisma.answerOption.createMany({
          data: q.options.map((opt) => ({
            questionId: q.questionId,
            optionText: opt.text,
            isCorrect: opt.isCorrect
          }))
        });
      }
      updated++;
    }
  }

  // 6. Reset question_id auto-increment sequence to 150
  try {
    await prisma.$executeRawUnsafe(
      `SELECT setval(pg_get_serial_sequence('question', 'question_id'), COALESCE(MAX(question_id), 1)) FROM question;`
    );
    console.log("Reset question_id sequence successfully.");
  } catch (seqErr) {
    console.warn("Notice: could not setval sequence automatically:", seqErr.message);
  }

  console.log(`\n=== Seeding Finished ===`);
  console.log(`Total processed: ${questions.length}`);
  console.log(`Inserted: ${inserted}`);
  console.log(`Updated: ${updated}`);
}

main()
  .catch((err) => {
    console.error("Seeding error:", err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
