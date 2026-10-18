import { prisma } from "./src/config/prisma.js";
import { ENGLISH_FLASHCARDS_DATA } from "./prisma/data/englishFlashcardsData.js";

const SUBJECT_NAME = "ភាសាអង់គ្លេស";

const DIFFICULTY_MAP = {
  "Easy": "easy",
  "Medium": "medium",
  "Hard": "hard",
  "ងាយ": "easy",
  "មធ្យម": "medium",
  "ពិបាក": "hard",
  "easy": "easy",
  "medium": "medium",
  "hard": "hard",
};

const DECKS_CONFIG = [
  { deckId: 901, title: "Set 1: Cambodian Vocabulary Basics", description: "Greetings, currency, Angkor Wat, krama and everyday Khmer-to-English words" },
  { deckId: 902, title: "Set 2: Grammar & Festivals", description: "Articles, present perfect, Pchum Ben, Tonle Sap and tuk-tuk vocabulary" },
  { deckId: 903, title: "Set 3: Culture & Tenses", description: "Pinpeat, Amok, idioms, Bokator, passive voice and future perfect" },
  { deckId: 904, title: "Set 4: Food, Places & Conditionals", description: "Sbek Thom, first conditional, Central Market, Sampeah and modal verbs" },
  { deckId: 905, title: "Set 5: Landmarks & Reported Speech", description: "Sihanoukville, reported speech, Takhe, Sampot and Cardamom Mountains" },
  { deckId: 906, title: "Set 6: Fruit, Titles & Comparatives", description: "Durian, honorifics, question forms, Prahok and comparative adjectives" },
  { deckId: 907, title: "Set 7: Prepositions & Markets", description: "Prepositions of place and time, Old Market, Kampot pepper and Irrawaddy dolphin" },
  { deckId: 908, title: "Set 8: Temples & Relative Pronouns", description: "Bayon, Ta Prohm, relative clauses, superlatives and Tuol Sleng" },
  { deckId: 909, title: "Set 9: Daily Life & Quantifiers", description: "Quantifiers, Wat Phnom, Apsara dance, less/fewer and second conditional" },
  { deckId: 910, title: "Set 10: Review Mix", description: "Mixed review of Cambodia-themed vocabulary and grammar" },
];

async function seedEnglishFlashcards() {
  console.log("Seeding 10 English Decks and 100 Flashcards into Database...");

  // 1. Find or create English subject
  let englishSubject = await prisma.subject.findFirst({
    where: {
      OR: [
        { subjectName: SUBJECT_NAME },
        { subjectName: "English" },
        { subjectName: "ភាសាអង់គ្លេស" },
      ],
    },
  });

  if (!englishSubject) {
    englishSubject = await prisma.subject.create({
      data: {
        subjectName: SUBJECT_NAME,
        description: "មុខវិជ្ជាភាសាអង់គ្លេស វេយ្យាករណ៍ និងវាក្យសព្ទ",
      },
    });
    console.log(`Created English subject with ID: ${englishSubject.subjectId}`);
  } else {
    console.log(`Using English subject ID: ${englishSubject.subjectId} (${englishSubject.subjectName})`);
  }

  // 2. Create/upsert the 10 FlashcardDecks (901 to 910)
  for (const cfg of DECKS_CONFIG) {
    await prisma.flashcardDeck.upsert({
      where: { deckId: cfg.deckId },
      update: {
        subjectId: englishSubject.subjectId,
        subjectName: SUBJECT_NAME,
        title: cfg.title,
        description: cfg.description,
      },
      create: {
        deckId: cfg.deckId,
        subjectId: englishSubject.subjectId,
        subjectName: SUBJECT_NAME,
        title: cfg.title,
        description: cfg.description,
      },
    });
  }
  console.log("10 English Flashcard Decks (901-910) created/updated successfully.");

  // 3. Upsert/insert all 100 flashcards, 10 cards per deck (deck 901 to 910)
  let insertedCount = 0;
  let updatedCount = 0;

  for (let i = 0; i < ENGLISH_FLASHCARDS_DATA.length; i++) {
    const cardData = ENGLISH_FLASHCARDS_DATA[i];
    const mappedDifficulty = DIFFICULTY_MAP[cardData.difficulty] || "medium";

    // Cards 1-10 -> deck 901, 11-20 -> deck 902, etc.
    const deckId = 901 + Math.floor(i / 10);
    // Use array position (not source flashcard_id) so IDs are unique: English uses 1051-1150
    // (Math: 1-100, Physics: 101-200, Chem: 201-300, GK: 301-500, Khmer: 501-700, History: 701-900, Geo: 901-950, Bio: 951-1050)
    const flashcardId = 1050 + (i + 1);

    const data = {
      deckId,
      subjectName: SUBJECT_NAME,
      category: cardData.category,
      frontText: cardData.front_text,
      backText: cardData.back_text,
      hint: cardData.hint,
      difficulty: mappedDifficulty,
    };

    const existingCard = await prisma.flashcard.findUnique({
      where: { flashcardId },
    });

    if (existingCard) {
      await prisma.flashcard.update({ where: { flashcardId }, data });
      updatedCount++;
    } else {
      await prisma.flashcard.create({ data: { flashcardId, ...data } });
      insertedCount++;
    }
  }

  console.log(`Successfully processed flashcards: ${insertedCount} inserted, ${updatedCount} updated across 10 decks.`);

  // Update Postgres Sequences so future auto-increments work smoothly
  await prisma.$executeRawUnsafe(`
    SELECT setval(pg_get_serial_sequence('flashcard', 'flashcard_id'), COALESCE((SELECT MAX(flashcard_id) FROM flashcard), 1));
    SELECT setval(pg_get_serial_sequence('flashcard_deck', 'deck_id'), COALESCE((SELECT MAX(deck_id) FROM flashcard_deck), 1));
  `);
  console.log("Postgres Sequences updated successfully.");
  console.log("English Flashcards seeding into 10 Decks completed successfully!");
}

seedEnglishFlashcards()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
