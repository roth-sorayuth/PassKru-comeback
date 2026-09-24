/**
 * PassKru Master Database Restore Script
 * 
 * Safely restores all pre-packaged data into the database:
 * 1. Base entities & Admin User (users, exams, subjects, topics, papers, mentors, announcements)
 * 2. Learning Content & Quizzes (curriculum blueprint, questions bank, quizzes, mock exams)
 * 3. Flashcards (History, Math, Physics, Chemistry, Biology, GK, Geography, Khmer)
 *
 * NOTE: This script is strictly additive / idempotent. It uses upserts and checks
 * to ensure no existing data is deleted or corrupted.
 */

import "dotenv/config";
import { spawnSync } from "child_process";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const steps = [
  {
    name: "Base Entities & Admin Account (prisma/seed.js)",
    file: path.join(__dirname, "prisma", "seed.js")
  },
  {
    name: "Curriculum, Quizzes & Mock Exams (prisma/seedContent.js)",
    file: path.join(__dirname, "prisma", "seedContent.js")
  },
  {
    name: "Math Flashcards (seed_math_flashcards.js)",
    file: path.join(__dirname, "seed_math_flashcards.js")
  },
  {
    name: "History Flashcards (seed_history_flashcards.js)",
    file: path.join(__dirname, "seed_history_flashcards.js")
  },
  {
    name: "Physics Flashcards (seed_physics_flashcards.js)",
    file: path.join(__dirname, "seed_physics_flashcards.js")
  },
  {
    name: "Chemistry Flashcards (seed_chemistry_flashcards.js)",
    file: path.join(__dirname, "seed_chemistry_flashcards.js")
  },
  {
    name: "Biology Flashcards (seed_biology_flashcards.js)",
    file: path.join(__dirname, "seed_biology_flashcards.js")
  },
  {
    name: "General Knowledge Flashcards (seed_gk_flashcards.js)",
    file: path.join(__dirname, "seed_gk_flashcards.js")
  },
  {
    name: "Geography Flashcards (seed_geography_flashcards.js)",
    file: path.join(__dirname, "seed_geography_flashcards.js")
  },
  {
    name: "Khmer Flashcards (seed_khmer_flashcards.js)",
    file: path.join(__dirname, "seed_khmer_flashcards.js")
  }
];

console.log("==================================================");
console.log("🚀 STARTING PASSKRU DATA RESTORATION PROCESS");
console.log("==================================================\n");

let successCount = 0;
let failCount = 0;

for (const step of steps) {
  console.log(`\n[STEP ${successCount + failCount + 1}/${steps.length}] Restoring: ${step.name}...`);
  // Read the raw .env file directly if needed, but since dotenv is likely loaded or we can 
  // rely on Prisma picking up DATABASE_URL from process.env, we override it here.
  const envOverrides = { ...process.env };
  if (process.env.DIRECT_URL) {
    envOverrides.DATABASE_URL = process.env.DIRECT_URL;
  }

  const result = spawnSync("node", [step.file], {
    cwd: __dirname,
    stdio: "inherit",
    env: envOverrides
  });

  if (result.status === 0) {
    console.log(`✅ Finished: ${step.name}`);
    successCount++;
  } else {
    console.error(`⚠️ Step failed or encountered warning: ${step.name}`);
    failCount++;
  }
}

console.log("\n==================================================");
console.log(`RESTORATION SUMMARY: ${successCount} succeeded, ${failCount} failed`);
console.log("==================================================");
