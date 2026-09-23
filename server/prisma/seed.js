import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import pg from "pg";
import dotenv from "dotenv";
import { usersData } from "./data/usersData.js";
import { announcementsData } from "./data/announcementsData.js";
import { subjectsData } from "./data/subjectsData.js";
import { papersData } from "./data/papersData.js";
import { topicsData } from "./data/topicsData.js";
import { mentorsData } from "./data/mentorsData.js";

dotenv.config();

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

// Helper to convert camelCase object keys to snake_case to match the Prisma schema fields
function toSnakeCase(str) {
  return str.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
}

function mapToSnakeCase(obj) {
  if (obj === null || typeof obj !== "object") return obj;
  if (Array.isArray(obj)) return obj.map(mapToSnakeCase);
  
  const newObj = {};
  for (const key in obj) {
    newObj[toSnakeCase(key)] = mapToSnakeCase(obj[key]);
  }
  return newObj;
}

async function seedExams() {
  console.log("Seeding exams...");
  for (const id of [1, 2, 3]) {
    const exists = await prisma.exam.findFirst({
      where: { examId: id }
    });
    if (!exists) {
      await prisma.exam.create({
        data: {
          examId: id,
          examName: id === 1 
            ? "ប្រឡងប្រជែងជ្រើសរើសគ្រូបង្រៀនថ្នាក់លើកកម្រិតបឋមសិក្សា" 
            : `ប្រឡងគ្រូបង្រៀន កម្រិត ${id}`,
          category: "បឋមសិក្សា",
        }
      });
      console.log(`Created Exam record with ID: ${id}`);
    } else {
      console.log(`Exam with ID ${id} already exists. Skipping.`);
    }
  }
}

async function seedUsers() {
  console.log("Seeding users...");
  for (const u of usersData) {
    const exists = await prisma.user.findUnique({
      where: { email: u.email }
    });
    if (!exists) {
      const user = await prisma.user.create({
        data: u,
      });
      console.log(`Created user: ${user.firstName} ${user.lastName} (${user.email})`);
    } else {
      console.log(`User ${u.email} already exists. Skipping.`);
    }
  }
}

async function seedAnnouncements() {
  let exam = await prisma.exam.findFirst();
  if (!exam) {
    exam = await prisma.exam.create({
      data: {
        examId: 1,
        examName: "ប្រឡងប្រជែងជ្រើសរើសគ្រូបង្រៀនថ្នាក់លើកកម្រិតបឋមសិក្សា",
        category: "បឋមសិក្សា",
      },
    });
    console.log(`Created default exam with ID: ${exam.examId}`);
  }

  console.log("Seeding announcements...");
  for (const a of announcementsData) {
    const exists = await prisma.announcement.findFirst({
      where: { title: a.title }
    });
    if (!exists) {
      const announcement = await prisma.announcement.create({
        data: {
          ...a,
          examId: exam.examId,
        }
      });
      console.log(`Created announcement: ${announcement.title}`);
    } else {
      console.log(`Announcement "${a.title}" already exists. Skipping.`);
    }
  }
}

async function seedSubjects() {
  console.log("Seeding subjects...");
  for (const s of subjectsData) {
    const exists = await prisma.subject.findFirst({
      where: {
        examId: s.examId,
        subjectName: s.subjectName
      }
    });
    if (!exists) {
      const subject = await prisma.subject.create({
        data: s,
      });
      console.log(`Created subject: ${subject.subjectName} (ID: ${subject.subjectId})`);
    } else {
      console.log(`Subject "${s.subjectName}" already exists for Exam ID ${s.examId}. Skipping.`);
    }
  }
}

async function seedPapers() {
  console.log("Seeding past papers...");
  for (const p of papersData) {
    const exists = await prisma.pastPaper.findFirst({
      where: {
        subjectId: p.subjectId,
        title: p.title
      }
    });
    if (!exists) {
      const paper = await prisma.pastPaper.create({
        data: p,
      });
      console.log(`Created past paper: ${paper.title} (ID: ${paper.paperId})`);
    } else {
      console.log(`Past paper "${p.title}" already exists. Skipping.`);
    }
  }
}

async function seedTopics() {
  console.log("Seeding topics...");
  for (const t of topicsData) {
    const exists = await prisma.topic.findFirst({
      where: {
        subjectId: t.subjectId,
        topicName: t.topicName
      }
    });
    if (!exists) {
      const topic = await prisma.topic.create({
        data: t,
      });
      console.log(`Created topic: ${topic.topicName} (ID: ${topic.topicId})`);
    } else {
      console.log(`Topic "${t.topicName}" already exists. Skipping.`);
    }
  }
}

async function seedMentors() {
  console.log("Seeding mentors...");
  for (const m of mentorsData) {
    const exists = await prisma.mentor.findFirst({
      where: {
        firstName: m.firstName,
        lastName: m.lastName
      }
    });
    if (!exists) {
      const mentor = await prisma.mentor.create({
        data: m
      });
      console.log(`Created mentor: ${mentor.firstName} ${mentor.lastName} (ID: ${mentor.mentorId})`);
    } else {
      console.log(`Mentor "${m.firstName} ${m.lastName}" already exists. Skipping.`);
    }
  }
}

async function main() {
  const target = process.argv[2]?.toLowerCase();
  
  console.log("Seeding started...");

  if (!target) {
    await seedExams();
    await seedUsers();
    await seedAnnouncements();
    await seedSubjects();
    await seedTopics();
    await seedPapers();
    await seedMentors();
  } else if (target === "exams") {
    await seedExams();
  } else if (target === "users") {
    await seedExams();
    await seedUsers();
  } else if (target === "announcements") {
    await seedExams();
    await seedAnnouncements();
  } else if (target === "subjects") {
    await seedExams();
    await seedSubjects();
  } else if (target === "topics") {
    await seedExams();
    await seedSubjects();
    await seedTopics();
  } else if (target === "papers") {
    await seedExams();
    await seedSubjects();
    await seedPapers();
  } else if (target === "mentors") {
    await seedMentors();
  } else {
    console.error(`Unknown seed target: "${target}". Use "exams", "users", "announcements", "subjects", "topics", "papers", or "mentors".`);
    process.exit(1);
  }

  console.log("Seeding finished successfully!");
}

main()
  .catch((e) => {
    console.error("Error seeding database:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });
