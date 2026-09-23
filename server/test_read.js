import "dotenv/config";
import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import pg from "pg";

const pool = new pg.Pool({ connectionString: process.env.DIRECT_URL || process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  try {
    console.log("Checking database tables...");
    const exams = await prisma.exam.findMany({
      select: { examId: true, examName: true, targetCode: true }
    });
    console.log("Exams in DB:", exams);

    const qCount = await prisma.question.count();
    console.log("Total Questions in DB:", qCount);

    const quizCount = await prisma.quiz.count();
    console.log("Total Quizzes in DB:", quizCount);

    const mockCount = await prisma.mockExam.count();
    console.log("Total Mock Exams in DB:", mockCount);

    const flashcardsCount = await prisma.flashcard.count();
    console.log("Total Flashcards in DB:", flashcardsCount);
  } catch (e) {
    console.error("Error reading DB:", e);
  } finally {
    await prisma.$disconnect();
    await pool.end();
  }
}

main();
