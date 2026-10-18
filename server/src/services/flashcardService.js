import { prisma } from "../config/prisma.js";

function toFlashcardDTO(card) {
  return {
    flashcardId: card.flashcardId,
    deckId: card.deckId,
    category: card.category,
    frontText: card.frontText,
    backText: card.backText,
    hint: card.hint,
    difficulty: card.difficulty,
    subjectName: card.subjectName || card.deck?.subjectName || card.deck?.subject?.subjectName || null,
    deckTitle: card.deck?.title ? card.deck.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : (card.deck?.title ?? null),
    subjectId: card.deck?.subjectId ?? null,
  };
}

/** Subject names treated as the same subject when finding decks and cards. */
export function getEquivalentSubjectNames(subjName) {
  if (!subjName) return [];
  const s = subjName.trim().toLowerCase();
  // Subjects in the `subject` table may carry English names (e.g. "Physics"),
  // while decks/cards are stored under the Khmer name, so match both.
  if (s.includes("គណិត") || s.includes("math")) return ["គណិតវិទ្យា"];
  if (s.includes("រូប") || s.includes("physic")) return ["រូបវិទ្យា"];
  if (s.includes("គីមី") || s.includes("chem")) return ["គីមីវិទ្យា"];
  if (s.includes("វប្បធម៌") || s.includes("general knowledge")) return ["វប្បធម៌ទូទៅ"];
  if (s.includes("ខ្មែរ") || s.includes("khmer")) return ["ភាសាខ្មែរ"];
  if (s.includes("ប្រវត្តិ") || s.includes("history")) return ["ប្រវត្តិវិទ្យា", "ប្រវត្តិសាស្ត្រ", "ប្រវត្តិសាស្ត្រខ្មែរ"];
  if (s.includes("ភូមិ") || s.includes("geograph")) return ["ភូមិវិទ្យា", "ភូមិសាស្ត្រ", "ភូមិវិទ្យាកម្ពុជា"];
  if (s.includes("ជីវ") || s.includes("biolog")) return ["ជីវវិទ្យា", "ជីវ:វិទ្យា", "ជីវវិទ្យាកោសិកា"];
  if (s.includes("អង់គ្លេស") || s.includes("english")) return ["ភាសាអង់គ្លេស"];
  return [subjName];
}

export const listFlashcards = async ({ subjectId, subjectName, deckId, difficulty } = {}) => {
  const where = {};
  if (deckId && !isNaN(Number(deckId))) where.deckId = Number(deckId);
  if (difficulty) where.difficulty = difficulty;

  let targetSubjectName = subjectName;
  if (!targetSubjectName && subjectId && !isNaN(Number(subjectId))) {
    const subj = await prisma.subject.findUnique({ where: { subjectId: Number(subjectId) } });
    if (subj?.subjectName) {
      targetSubjectName = subj.subjectName;
    }
  }

  if (targetSubjectName) {
    const equivalents = getEquivalentSubjectNames(targetSubjectName);
    const orConditions = [
      { subjectName: { in: equivalents, mode: "insensitive" } },
      { deck: { subjectName: { in: equivalents, mode: "insensitive" } } },
      { deck: { subject: { subjectName: { in: equivalents, mode: "insensitive" } } } },
    ];
    if (subjectId && !isNaN(Number(subjectId))) {
      orConditions.push({ deck: { subjectId: Number(subjectId) } });
    }
    where.OR = orConditions;
  } else if (subjectId && !isNaN(Number(subjectId))) {
    where.deck = { subjectId: Number(subjectId) };
  }

  const cards = await prisma.flashcard.findMany({
    where,
    orderBy: { flashcardId: "asc" },
    include: { deck: { include: { subject: { select: { subjectId: true, subjectName: true } } } } },
  });

  return cards.map(toFlashcardDTO);
};

export const getFlashcardById = async (id) => {
  const card = await prisma.flashcard.findUnique({
    where: { flashcardId: id },
    include: { deck: { include: { subject: { select: { subjectId: true, subjectName: true } } } } },
  });

  if (!card) {
    const error = new Error(`Flashcard with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  return toFlashcardDTO(card);
};

export const createFlashcard = async (data) => {
  const deckId = Number(data.deckId);
  const deckExists = await prisma.flashcardDeck.findUnique({ where: { deckId } });
  if (!deckExists) {
    const error = new Error(`Flashcard deck with ID ${deckId} not found`);
    error.statusCode = 404;
    throw error;
  }

  const card = await prisma.flashcard.create({
    data: {
      deckId,
      subjectName: data.subjectName || deckExists.subjectName || null,
      category: data.category || null,
      frontText: data.frontText,
      backText: data.backText,
      hint: data.hint || null,
      difficulty: data.difficulty || null,
    },
    include: { deck: { include: { subject: { select: { subjectId: true, subjectName: true } } } } },
  });

  return toFlashcardDTO(card);
};

export const updateFlashcard = async (id, data) => {
  const cardExists = await prisma.flashcard.findUnique({ where: { flashcardId: id } });
  if (!cardExists) {
    const error = new Error(`Flashcard with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  const updateData = {};
  if (data.deckId !== undefined) updateData.deckId = Number(data.deckId);
  if (data.category !== undefined) updateData.category = data.category || null;
  if (data.frontText !== undefined) updateData.frontText = data.frontText;
  if (data.backText !== undefined) updateData.backText = data.backText;
  if (data.hint !== undefined) updateData.hint = data.hint || null;
  if (data.difficulty !== undefined) updateData.difficulty = data.difficulty || null;

  const card = await prisma.flashcard.update({
    where: { flashcardId: id },
    data: updateData,
    include: { deck: { include: { subject: { select: { subjectId: true, subjectName: true } } } } },
  });

  return toFlashcardDTO(card);
};

export const removeFlashcard = async (id) => {
  const cardExists = await prisma.flashcard.findUnique({ where: { flashcardId: id } });
  if (!cardExists) {
    const error = new Error(`Flashcard with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  await prisma.flashcard.delete({ where: { flashcardId: id } });
  return true;
};

export const listDecks = async ({ subjectId, subjectName } = {}) => {
  const where = {};
  let targetSubjectName = subjectName;

  if (!targetSubjectName && subjectId && !isNaN(Number(subjectId))) {
    const subj = await prisma.subject.findUnique({ where: { subjectId: Number(subjectId) } });
    if (subj?.subjectName) {
      targetSubjectName = subj.subjectName;
    }
  }

  if (targetSubjectName) {
    const equivalents = getEquivalentSubjectNames(targetSubjectName);
    const orConditions = [
      { subjectName: { in: equivalents, mode: "insensitive" } },
      { subject: { subjectName: { in: equivalents, mode: "insensitive" } } },
    ];
    if (subjectId && !isNaN(Number(subjectId))) {
      orConditions.push({ subjectId: Number(subjectId) });
    }
    where.OR = orConditions;
  } else if (subjectId && !isNaN(Number(subjectId))) {
    where.subjectId = Number(subjectId);
  }

  const decks = await prisma.flashcardDeck.findMany({
    where,
    orderBy: { deckId: "asc" },
    include: {
      subject: { select: { subjectId: true, subjectName: true } },
      _count: { select: { flashcards: true } },
    },
  });

  return decks.map((d) => ({
    deckId: d.deckId,
    subjectId: d.subjectId,
    subjectName: d.subjectName || d.subject?.subjectName || null,
    title: d.title ? d.title.replace(/ឈុត/g, 'វិញ្ញាសារ') : d.title,
    description: d.description ? d.description.replace(/ឈុត/g, 'វិញ្ញាសារ') : d.description,
    totalFlashcards: d._count.flashcards,
  }));
};

export const createDeck = async (data) => {
  const subjectId = Number(data.subjectId);
  const subjectExists = await prisma.subject.findUnique({ where: { subjectId } });
  if (!subjectExists) {
    const error = new Error(`Subject with ID ${subjectId} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.flashcardDeck.create({
    data: {
      subjectId,
      title: data.title,
      description: data.description || null,
    },
  });
};

const BULK_DIFFICULTY_MAP = {
  easy: "easy", medium: "medium", hard: "hard",
  "ងាយ": "easy", "ងាយស្រួល": "easy", "មធ្យម": "medium", "ពិបាក": "hard",
};
const BULK_MAX_CARDS = 1000;

/**
 * Bulk-import flashcards from admin-uploaded JSON. Accepts snake_case
 * (front_text) or camelCase (frontText). Finds or creates the subject,
 * creates new decks of `cardsPerDeck` cards, and skips cards whose front text
 * already exists in that subject so re-importing the same file is harmless.
 */
export const bulkImportFlashcards = async ({ subjectId, subjectName, cardsPerDeck, deckTitlePrefix, flashcards }) => {
  const fail = (message, statusCode = 400) => {
    const error = new Error(message);
    error.statusCode = statusCode;
    throw error;
  };

  if (!Array.isArray(flashcards) || flashcards.length === 0) fail("flashcards must be a non-empty array");
  if (flashcards.length > BULK_MAX_CARDS) fail(`Too many flashcards (max ${BULK_MAX_CARDS} per import)`);
  if (!subjectId && !subjectName?.trim()) fail("Please provide subjectId or subjectName");

  const perDeck = Math.min(Math.max(parseInt(cardsPerDeck, 10) || 10, 1), 100);

  const invalid = [];
  const seen = new Set();
  const valid = [];
  flashcards.forEach((raw, index) => {
    const frontText = String(raw?.frontText ?? raw?.front_text ?? "").trim();
    const backText = String(raw?.backText ?? raw?.back_text ?? "").trim();
    if (!frontText || !backText) {
      invalid.push({ index: index + 1, reason: "missing front_text or back_text" });
      return;
    }
    if (seen.has(frontText)) return; // duplicate inside the file
    seen.add(frontText);
    const hint = raw.hint ? String(raw.hint).trim() : null;
    const category = raw.category ? String(raw.category).trim().slice(0, 100) : null;
    const diffKey = String(raw.difficulty ?? "").trim();
    const difficulty = BULK_DIFFICULTY_MAP[diffKey] || BULK_DIFFICULTY_MAP[diffKey.toLowerCase()] || "medium";
    valid.push({ frontText, backText, hint, category, difficulty });
  });

  if (valid.length === 0) fail("No valid flashcards found in the file");

  return await prisma.$transaction(async (tx) => {
    // Resolve subject (by id, by equivalent name, or create it).
    let subject = null;
    if (subjectId && !isNaN(Number(subjectId))) {
      subject = await tx.subject.findUnique({ where: { subjectId: Number(subjectId) } });
      if (!subject) fail(`Subject with ID ${subjectId} not found`, 404);
    } else {
      const name = subjectName.trim();
      subject = await tx.subject.findFirst({
        where: { subjectName: { in: getEquivalentSubjectNames(name), mode: "insensitive" } },
      });
      if (!subject) subject = await tx.subject.create({ data: { subjectName: name } });
    }

    // Skip cards already stored under this subject.
    const existing = await tx.flashcard.findMany({
      where: { frontText: { in: valid.map((c) => c.frontText) }, deck: { subjectId: subject.subjectId } },
      select: { frontText: true },
    });
    const existingSet = new Set(existing.map((c) => c.frontText));
    const toCreate = valid.filter((c) => !existingSet.has(c.frontText));

    let decksCreated = 0;
    if (toCreate.length > 0) {
      const existingDecks = await tx.flashcardDeck.findMany({
        where: { subjectId: subject.subjectId },
        select: { title: true },
      });
      const usedTitles = new Set(existingDecks.map((d) => d.title));
      const prefix = (deckTitlePrefix || "វិញ្ញាសារទី").trim();
      let deckNumber = existingDecks.length + 1;

      for (let i = 0; i < toCreate.length; i += perDeck) {
        let title = `${prefix} ${deckNumber}`;
        while (usedTitles.has(title)) title = `${prefix} ${++deckNumber}`;
        usedTitles.add(title);
        deckNumber++;

        await tx.flashcardDeck.create({
          data: {
            subjectId: subject.subjectId,
            subjectName: subject.subjectName,
            title,
            flashcards: {
              create: toCreate.slice(i, i + perDeck).map((c) => ({ ...c, subjectName: subject.subjectName })),
            },
          },
        });
        decksCreated++;
      }
    }

    return {
      subjectId: subject.subjectId,
      subjectName: subject.subjectName,
      decksCreated,
      cardsCreated: toCreate.length,
      skippedDuplicates: valid.length - toCreate.length,
      invalid,
    };
  }, { timeout: 60000 });
};

export const updateDeck = async (id, data) => {
  const deckExists = await prisma.flashcardDeck.findUnique({ where: { deckId: id } });
  if (!deckExists) {
    const error = new Error(`Flashcard deck with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  const updateData = {};
  if (data.subjectId !== undefined) updateData.subjectId = Number(data.subjectId);
  if (data.title !== undefined) updateData.title = data.title;
  if (data.description !== undefined) updateData.description = data.description || null;

  return await prisma.flashcardDeck.update({ where: { deckId: id }, data: updateData });
};

export const removeDeck = async (id) => {
  const deckExists = await prisma.flashcardDeck.findUnique({ where: { deckId: id } });
  if (!deckExists) {
    const error = new Error(`Flashcard deck with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  await prisma.flashcardDeck.delete({ where: { deckId: id } });
  return true;
};
