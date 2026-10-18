import { prisma } from "./src/config/prisma.js";

async function main() {
  console.log("=== Updating Exam Names and Linkages ===\n");

  // 1. Update questions 1 to 150 (formerly secondary) -> 'High school'
  const res1 = await prisma.question.updateMany({
    where: { questionId: { gte: 1, lte: 150 } },
    data: { examName: "High school" }
  });
  console.log(`Updated questions 1..150 to exam_name = 'High school': ${res1.count}`);

  // 2. Update questions 151 to 511 (formerly elementary) -> 'secondary'
  const res2 = await prisma.question.updateMany({
    where: { questionId: { gte: 151, lte: 511 } },
    data: { examName: "secondary" }
  });
  console.log(`Updated questions 151..511 to exam_name = 'secondary': ${res2.count}`);

  // 3. Move Subject 7 (Mathematics for Q 1..150) to Exam 3 (High School)
  const s7 = await prisma.subject.update({
    where: { subjectId: 7 },
    data: {
      examId: 3,
      description: "High School Teacher Mathematics (NIE)"
    }
  });
  console.log(`Updated Subject 7 to Exam 3 (High School): ${s7.subjectName} [examId: ${s7.examId}]`);

  // 4. Move Subject 1 (Mathematics for Q 151..511) to Exam 2 (Secondary)
  const s1 = await prisma.subject.update({
    where: { subjectId: 1 },
    data: {
      examId: 2,
      description: "Secondary Teacher Mathematics (RTTC)"
    }
  });
  console.log(`Updated Subject 1 to Exam 2 (Secondary): ${s1.subjectName} [examId: ${s1.examId}]`);

  // 5. Verification
  const highSchoolCount = await prisma.question.count({ where: { examName: "High school" } });
  const secondaryCount = await prisma.question.count({ where: { examName: "secondary" } });
  const elementaryCount = await prisma.question.count({ where: { examName: "elementary" } });

  console.log("\n=== Final Verification ===");
  console.log(`High school questions (IDs 1-150): ${highSchoolCount}`);
  console.log(`Secondary questions (IDs 151-511): ${secondaryCount}`);
  console.log(`Elementary questions remaining: ${elementaryCount}`);
}

main()
  .catch((err) => {
    console.error("Update error:", err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

