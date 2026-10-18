import fs from "fs";
import { prisma } from "./src/config/prisma.js";

async function main() {
  console.log("=== Seeding Physics & Chemistry Questions ===\n");

  const questions = JSON.parse(
    fs.readFileSync("physics_and_chemistry_questions.json", "utf8")
  );
  console.log(`Loaded ${questions.length} questions from physics_and_chemistry_questions.json`);

  // 1. Ensure Exams exist
  // Exam 2 = Secondary (rttc / មូលដ្ឋាន)
  // Exam 3 = High School (nie / ឧត្តម)
  const examSec = await prisma.exam.findFirst({
    where: {
      OR: [
        { examId: 2 },
        { targetCode: "secondary" },
        { targetCode: "rttc" },
        { examName: { contains: "មូលដ្ឋាន" } }
      ]
    }
  });

  const examHigh = await prisma.exam.findFirst({
    where: {
      OR: [
        { examId: 3 },
        { targetCode: "nie" },
        { targetCode: "highschool" },
        { examName: { contains: "ឧត្តម" } }
      ]
    }
  });

  console.log(`Secondary Exam: [ID: ${examSec?.examId}] ${examSec?.examName}`);
  console.log(`High School Exam: [ID: ${examHigh?.examId}] ${examHigh?.examName}`);

  // 2. Ensure Subjects exist
  // 2a. Chemistry Secondary
  let chemSec = await prisma.subject.findFirst({
    where: { examId: examSec.examId, subjectName: "Chemistry" }
  });
  if (!chemSec) {
    chemSec = await prisma.subject.create({
      data: {
        examId: examSec.examId,
        subjectName: "Chemistry",
        description: "Chemistry for Secondary Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Subject: Chemistry (Secondary) [ID: ${chemSec.subjectId}]`);
  } else {
    console.log(`Using existing Subject: Chemistry (Secondary) [ID: ${chemSec.subjectId}]`);
  }

  // 2b. Physics Secondary
  let physSec = await prisma.subject.findFirst({
    where: { examId: examSec.examId, subjectName: "Physics" }
  });
  if (!physSec) {
    physSec = await prisma.subject.create({
      data: {
        examId: examSec.examId,
        subjectName: "Physics",
        description: "Physics for Secondary Teacher Exam (RTTC)"
      }
    });
    console.log(`Created Subject: Physics (Secondary) [ID: ${physSec.subjectId}]`);
  } else {
    console.log(`Using existing Subject: Physics (Secondary) [ID: ${physSec.subjectId}]`);
  }

  // 2c. Chemistry High School
  let chemHigh = await prisma.subject.findFirst({
    where: { examId: examHigh.examId, subjectName: "Chemistry" }
  });
  if (!chemHigh) {
    chemHigh = await prisma.subject.create({
      data: {
        examId: examHigh.examId,
        subjectName: "Chemistry",
        description: "Chemistry for High School Teacher Exam (NIE)"
      }
    });
    console.log(`Created Subject: Chemistry (High School) [ID: ${chemHigh.subjectId}]`);
  } else {
    console.log(`Using existing Subject: Chemistry (High School) [ID: ${chemHigh.subjectId}]`);
  }

  // 2d. Physics High School
  let physHigh = await prisma.subject.findFirst({
    where: { examId: examHigh.examId, subjectName: "Physics" }
  });
  if (!physHigh) {
    physHigh = await prisma.subject.create({
      data: {
        examId: examHigh.examId,
        subjectName: "Physics",
        description: "Physics for High School Teacher Exam (NIE)"
      }
    });
    console.log(`Created Subject: Physics (High School) [ID: ${physHigh.subjectId}]`);
  } else {
    console.log(`Using existing Subject: Physics (High School) [ID: ${physHigh.subjectId}]`);
  }

  // 3. Ensure Topics exist (Explicit IDs 21..24 to avoid sequence collision)
  // Topic 21: Chemistry Secondary
  let topicChemSec = await prisma.topic.findFirst({
    where: { subjectId: chemSec.subjectId }
  });
  if (!topicChemSec) {
    topicChemSec = await prisma.topic.create({
      data: {
        topicId: 21,
        subjectId: chemSec.subjectId,
        topicName: "គីមីវិទ្យា - គ្រូមូលដ្ឋាន",
        description: "General Chemistry for Secondary Teacher Exam"
      }
    });
    console.log(`Created Topic: គីមីវិទ្យា - គ្រូមូលដ្ឋាន [ID: ${topicChemSec.topicId}]`);
  } else {
    console.log(`Using existing Topic: ${topicChemSec.topicName} [ID: ${topicChemSec.topicId}]`);
  }

  // Topic 22: Physics Secondary
  let topicPhysSec = await prisma.topic.findFirst({
    where: { subjectId: physSec.subjectId }
  });
  if (!topicPhysSec) {
    topicPhysSec = await prisma.topic.create({
      data: {
        topicId: 22,
        subjectId: physSec.subjectId,
        topicName: "រូបវិទ្យា - គ្រូមូលដ្ឋាន",
        description: "General Physics for Secondary Teacher Exam"
      }
    });
    console.log(`Created Topic: រូបវិទ្យា - គ្រូមូលដ្ឋាន [ID: ${topicPhysSec.topicId}]`);
  } else {
    console.log(`Using existing Topic: ${topicPhysSec.topicName} [ID: ${topicPhysSec.topicId}]`);
  }

  // Topic 23: Chemistry High School
  let topicChemHigh = await prisma.topic.findFirst({
    where: { subjectId: chemHigh.subjectId }
  });
  if (!topicChemHigh) {
    topicChemHigh = await prisma.topic.create({
      data: {
        topicId: 23,
        subjectId: chemHigh.subjectId,
        topicName: "គីមីវិទ្យា - គ្រូឧត្តម",
        description: "General Chemistry for High School Teacher Exam (NIE)"
      }
    });
    console.log(`Created Topic: គីមីវិទ្យា - គ្រូឧត្តម [ID: ${topicChemHigh.topicId}]`);
  } else {
    console.log(`Using existing Topic: ${topicChemHigh.topicName} [ID: ${topicChemHigh.topicId}]`);
  }

  // Topic 24: Physics High School
  let topicPhysHigh = await prisma.topic.findFirst({
    where: { subjectId: physHigh.subjectId }
  });
  if (!topicPhysHigh) {
    topicPhysHigh = await prisma.topic.create({
      data: {
        topicId: 24,
        subjectId: physHigh.subjectId,
        topicName: "រូបវិទ្យា - គ្រូឧត្តម",
        description: "General Physics for High School Teacher Exam (NIE)"
      }
    });
    console.log(`Created Topic: រូបវិទ្យា - គ្រូឧត្តម [ID: ${topicPhysHigh.topicId}]`);
  } else {
    console.log(`Using existing Topic: ${topicPhysHigh.topicName} [ID: ${topicPhysHigh.topicId}]`);
  }

  // Reset topic sequence to max ID
  try {
    await prisma.$executeRawUnsafe(
      `SELECT setval(pg_get_serial_sequence('topic', 'topic_id'), (SELECT COALESCE(MAX(topic_id), 1) FROM topic));`
    );
  } catch (e) {
    console.warn("Notice: could not setval topic sequence:", e.message);
  }

  // 4. Also normalize questions 1..150 to exam_name = 'highschool'
  await prisma.question.updateMany({
    where: { questionId: { gte: 1, lte: 150 } },
    data: { examName: "highschool" }
  });

  // 5. Clean up any existing questions in range 512..611
  console.log("\nCleaning up existing questions in range 512..611...");
  await prisma.answerOption.deleteMany({
    where: { questionId: { gte: 512, lte: 611 } }
  });
  await prisma.question.deleteMany({
    where: { questionId: { gte: 512, lte: 611 } }
  });

  // 6. Map each question to the proper target topic
  console.log(`\nInserting ${questions.length} questions into question table...`);
  const questionRows = questions.map((q) => {
    let targetTopicId;
    if (q.examName === "secondary") {
      targetTopicId = q.subjectName === "Chemistry" ? topicChemSec.topicId : topicPhysSec.topicId;
    } else {
      targetTopicId = q.subjectName === "Chemistry" ? topicChemHigh.topicId : topicPhysHigh.topicId;
    }

    return {
      questionId: q.questionId,
      topicId: targetTopicId,
      examName: q.examName,
      subjectName: q.subjectName,
      questionText: q.questionText,
      questionType: "multiple_choice",
      difficultyLevel: q.difficultyLevel,
      correctAnswer: q.correctAnswer,
      explanation: q.explanation,
      referenceNote: q.referenceNote
    };
  });

  await prisma.question.createMany({
    data: questionRows
  });
  console.log(`Successfully inserted all ${questionRows.length} questions!`);

  // 7. Insert all options using createMany
  console.log("\nPreparing and inserting answer options...");
  const optionsRows = [];
  for (const q of questions) {
    for (const opt of q.options) {
      optionsRows.push({
        questionId: q.questionId,
        optionText: opt.text,
        isCorrect: opt.isCorrect
      });
    }
  }

  console.log(`Total options to insert: ${optionsRows.length}`);
  await prisma.answerOption.createMany({
    data: optionsRows
  });
  console.log(`Successfully inserted all ${optionsRows.length} answer options!`);

  // 8. Reset question_id sequence
  try {
    await prisma.$executeRawUnsafe(
      `SELECT setval(pg_get_serial_sequence('question', 'question_id'), (SELECT COALESCE(MAX(question_id), 1) FROM question));`
    );
    console.log("\nReset question_id sequence successfully.");
  } catch (seqErr) {
    console.warn("Notice: could not setval sequence automatically:", seqErr.message);
  }

  // 9. Verification
  const totalQuestions = await prisma.question.count();
  const secChem = await prisma.question.count({ where: { examName: "secondary", subjectName: "Chemistry" } });
  const secPhys = await prisma.question.count({ where: { examName: "secondary", subjectName: "Physics" } });
  const highChem = await prisma.question.count({ where: { examName: "highschool", subjectName: "Chemistry" } });
  const highPhys = await prisma.question.count({ where: { examName: "highschool", subjectName: "Physics" } });

  console.log("\n=== Seeding Finished Successfully ===");
  console.log(`Total Questions in DB: ${totalQuestions}`);
  console.log(`  Secondary Chemistry: ${secChem}`);
  console.log(`  Secondary Physics: ${secPhys}`);
  console.log(`  High School Chemistry: ${highChem}`);
  console.log(`  High School Physics: ${highPhys}`);
}

main()
  .catch((err) => {
    console.error("Seeding error:", err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

