// Deleting a subject cascades to its content in the database, so the service
// must refuse while anything is attached. In-memory fake Prisma, no database.
import { test, mock } from "node:test";
import assert from "node:assert/strict";

const counts = { topic: 0, quiz: 0, pastPaper: 0, flashcardDeck: 0, mockExamSection: 0 };
const deleted = [];
const counter = (model) => ({ count: async () => counts[model] });
const prisma = {
  subject: {
    findUnique: async ({ where }) => (where.subjectId === 404 ? null : { subjectId: where.subjectId }),
    delete: async ({ where }) => deleted.push(where.subjectId),
  },
  topic: counter("topic"),
  quiz: counter("quiz"),
  pastPaper: counter("pastPaper"),
  flashcardDeck: counter("flashcardDeck"),
  mockExamSection: counter("mockExamSection"),
};
mock.module(new URL("../src/config/prisma.js", import.meta.url).href, { namedExports: { prisma } });
const { remove } = await import("../src/services/subjectService.js");

test("refuses to delete a subject that still holds flashcard decks", async () => {
  counts.flashcardDeck = 10;
  await assert.rejects(remove(21), (err) => err.statusCode === 409 && /10 flashcard decks/.test(err.message));
  assert.deepEqual(deleted, []);
  counts.flashcardDeck = 0;
});

test("lists everything still attached", async () => {
  Object.assign(counts, { topic: 2, quiz: 3, pastPaper: 1 });
  await assert.rejects(remove(1), (err) => /2 topics, 3 quizzes, 1 past papers/.test(err.message));
  Object.assign(counts, { topic: 0, quiz: 0, pastPaper: 0 });
});

test("deletes an empty subject", async () => {
  assert.equal(await remove(4), true);
  assert.deepEqual(deleted, [4]);
});

test("404 for an unknown subject", async () => {
  await assert.rejects(remove(404), (err) => err.statusCode === 404);
});
