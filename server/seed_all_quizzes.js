import { prisma } from "./src/config/prisma.js";

const KHMER_NUMS = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
function toKhmerNum(num) {
  return String(num).replace(/[0-9]/g, (d) => KHMER_NUMS[Number(d)]);
}

/**
 * Divides an array equally across numChunks.
 * With the configured numChunks below, remainder is 0 for every single subject,
 * ensuring every card has an IDENTICAL number of questions.
 */
function divideEqually(arr, numChunks) {
  const result = [];
  const baseSize = Math.floor(arr.length / numChunks);
  const remainder = arr.length % numChunks;
  let start = 0;
  for (let i = 0; i < numChunks; i++) {
    const size = baseSize + (i < remainder ? 1 : 0);
    result.push(arr.slice(start, start + size));
    start += size;
  }
  return result;
}

const QUIZ_CONFIGS = [
  // 1. Elementary Mathematics (110 Qs / 5 cards = exactly 22 Qs per card)
  {
    subjectName: "Mathematics",
    examName: "elementary",
    subjectId: 14,
    numChunks: 5,
    titlePrefix: "គណិតវិទ្យា (ថ្នាក់បឋមសិក្សា) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 2. Secondary Mathematics (361 Qs / 19 cards = exactly 19 Qs per card)
  {
    subjectName: "Mathematics",
    examName: "secondary",
    subjectId: 1,
    numChunks: 19,
    titlePrefix: "គណិតវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 3. High School Mathematics (150 Qs / 6 cards = exactly 25 Qs per card)
  {
    subjectName: "Mathematics",
    examName: "highschool",
    subjectId: 7,
    numChunks: 6,
    titlePrefix: "គណិតវិទ្យា (កម្រិតឧត្តម) - វិញ្ញាសាទី",
    difficulty: "hard"
  },
  // 4. Secondary Chemistry (39 Qs / 3 cards = exactly 13 Qs per card)
  {
    subjectName: "Chemistry",
    examName: "secondary",
    subjectId: 8,
    numChunks: 3,
    titlePrefix: "គីមីវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 5. Secondary Physics (11 Qs / 1 card = exactly 11 Qs)
  {
    subjectName: "Physics",
    examName: "secondary",
    subjectId: 9,
    numChunks: 1,
    titlePrefix: "រូបវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 6. High School Chemistry (18 Qs / 1 card = exactly 18 Qs)
  {
    subjectName: "Chemistry",
    examName: "highschool",
    subjectId: 10,
    numChunks: 1,
    titlePrefix: "គីមីវិទ្យា (កម្រិតឧត្តម) - វិញ្ញាសាទី",
    difficulty: "hard"
  },
  // 7. High School Physics (32 Qs / 2 cards = exactly 16 Qs per card)
  {
    subjectName: "Physics",
    examName: "highschool",
    subjectId: 11,
    numChunks: 2,
    titlePrefix: "រូបវិទ្យា (កម្រិតឧត្តម) - វិញ្ញាសាទី",
    difficulty: "hard"
  },
  // 8. Secondary History (68 Qs / 4 cards = exactly 17 Qs per card)
  {
    subjectName: "History",
    examName: "secondary",
    subjectId: 12,
    numChunks: 4,
    titlePrefix: "ប្រវត្តិវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 9. High School History (182 Qs / 7 cards = exactly 26 Qs per card)
  {
    subjectName: "History",
    examName: "highschool",
    subjectId: 13,
    numChunks: 7,
    titlePrefix: "ប្រវត្តិវិទ្យា (កម្រិតឧត្តម) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 10. Khmer Literature (All Categories: 22 Qs / 1 card = exactly 22 Qs)
  {
    subjectName: "Khmer Literature",
    examName: "All",
    subjectId: 15,
    numChunks: 1,
    titlePrefix: "ភាសា និងអក្សរសាស្ត្រខ្មែរ - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 11. Secondary Civics & Ethics (28 Qs / 2 cards = exactly 14 Qs per card)
  {
    subjectName: "Civics & Ethics",
    examName: "secondary",
    subjectId: 16,
    numChunks: 2,
    titlePrefix: "សីលធម៌ពលរដ្ឋវិជ្ជា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 12. Secondary Geography (100 Qs / 5 cards = exactly 20 Qs per card)
  {
    subjectName: "Geography",
    examName: "secondary",
    subjectId: 17,
    numChunks: 5,
    titlePrefix: "ភូមិវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 13. High School Geography (100 Qs / 5 cards = exactly 20 Qs per card)
  {
    subjectName: "Geography",
    examName: "highschool",
    subjectId: 18,
    numChunks: 5,
    titlePrefix: "ភូមិវិទ្យា (កម្រិតឧត្តម) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 14. Secondary Biology (98 Qs / 7 cards = exactly 14 Qs per card)
  {
    subjectName: "Biology",
    examName: "secondary",
    subjectId: 19,
    numChunks: 7,
    titlePrefix: "ជីវវិទ្យា (កម្រិតមូលដ្ឋាន) - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 15. General Knowledge (80 Qs / 4 cards = exactly 20 Qs per card)
  {
    subjectName: "General Knowledge",
    examName: "All",
    subjectId: 3,
    numChunks: 4,
    titlePrefix: "វប្បធម៌ទូទៅ និង ព្រឹត្តិការណ៍បច្ចុប្បន្ន - វិញ្ញាសាទី",
    difficulty: "medium"
  },
  // 16. English (100 Qs / 5 cards = exactly 20 Qs per card)
  {
    subjectName: "English",
    examName: "All",
    subjectId: 20,
    numChunks: 5,
    titlePrefix: "ភាសាអង់គ្លេស (Grammar & Tenses) - វិញ្ញាសាទី",
    difficulty: "medium"
  }
];

async function main() {
  console.log("=== Seeding Quizzes with Strictly Equal Questions per Card ===\n");

  // 1. Clean existing quizzes and quiz_questions
  console.log("Cleaning up existing quiz questions and quizzes...");
  await prisma.quizQuestion.deleteMany({});
  await prisma.quiz.deleteMany({});
  console.log("Quiz tables cleared.");

  let totalQuizzesCreated = 0;
  let totalQuestionsLinked = 0;

  for (const cfg of QUIZ_CONFIGS) {
    // Fetch questions matching subjectName and examName
    const questions = await prisma.question.findMany({
      where: {
        subjectName: cfg.subjectName,
        examName: cfg.examName
      },
      orderBy: { questionId: "asc" }
    });

    if (questions.length === 0) {
      console.warn(`No questions found for ${cfg.subjectName} (${cfg.examName})!`);
      continue;
    }

    const chunks = divideEqually(questions, cfg.numChunks);
    const expectedSize = chunks[0].length;
    const isStrictlyEqual = chunks.every(c => c.length === expectedSize);

    console.log(`\nCreating ${chunks.length} equal cards for "${cfg.subjectName}" [${cfg.examName}] (Total Qs: ${questions.length}, ${expectedSize} Qs/card, Equal: ${isStrictlyEqual})...`);

    for (let i = 0; i < chunks.length; i++) {
      const chunk = chunks[i];
      const setNumber = i + 1;
      const title = `${cfg.titlePrefix} ${toKhmerNum(setNumber)}`;
      const duration = Math.max(15, Math.ceil(chunk.length * 1.5));

      const quiz = await prisma.quiz.create({
        data: {
          subjectId: cfg.subjectId,
          title,
          difficultyLevel: cfg.difficulty,
          durationMinutes: duration,
          quizQuestions: {
            create: chunk.map((q, idx) => ({
              questionId: q.questionId,
              questionOrder: idx + 1
            }))
          }
        }
      });

      totalQuizzesCreated++;
      totalQuestionsLinked += chunk.length;
      console.log(`  Created Quiz [ID: ${quiz.quizId}]: "${title}" (${chunk.length} questions, ${duration} mins)`);
    }
  }

  // 2. Sync database sequences
  console.log("\nUpdating quiz sequences...");
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('quiz', 'quiz_id'), (SELECT COALESCE(MAX(quiz_id), 1) FROM quiz))"
  );
  await prisma.$executeRawUnsafe(
    "SELECT setval(pg_get_serial_sequence('quiz_question', 'quiz_question_id'), (SELECT COALESCE(MAX(quiz_question_id), 1) FROM quiz_question))"
  );
  console.log("Quiz sequences synced successfully.");

  // 3. Verification
  console.log("\n=== Seeding Verification ===");
  const quizCount = await prisma.quiz.count();
  const qqCount = await prisma.quizQuestion.count();
  console.log(`Total Quizzes Created: ${quizCount}`);
  console.log(`Total Quiz Questions Linked: ${qqCount} (Expected: 1499)`);

  const quizzes = await prisma.quiz.findMany({
    include: {
      subject: true,
      _count: { select: { quizQuestions: true } }
    },
    orderBy: { quizId: 'asc' }
  });

  const subjectCardStats = {};
  for (const q of quizzes) {
    const key = `${q.subject?.subjectName} (${q.subject?.examId})`;
    if (!subjectCardStats[key]) subjectCardStats[key] = [];
    subjectCardStats[key].push(q._count.quizQuestions);
  }

  console.log("\n--- Questions per Card by Subject ---");
  for (const [subj, sizes] of Object.entries(subjectCardStats)) {
    const allSame = sizes.every(s => s === sizes[0]);
    console.log(`- ${subj}: ${sizes.length} cards, ${sizes[0]} Qs each (Strictly equal: ${allSame})`);
  }

  console.log("\nAll quizzes created and divided strictly equally!");
}

main()
  .catch((e) => {
    console.error("Error seeding quizzes:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
