import { api } from '../lib/api';

export interface BulkFlashcardInput {
  front_text?: string;
  back_text?: string;
  frontText?: string;
  backText?: string;
  hint?: string | null;
  category?: string | null;
  difficulty?: string | null;
}

export interface BulkImportPayload {
  subjectName: string;
  cardsPerDeck?: number;
  flashcards: BulkFlashcardInput[];
}

export interface BulkImportResult {
  subjectId: number;
  subjectName: string;
  decksCreated: number;
  cardsCreated: number;
  skippedDuplicates: number;
  invalid: { index: number; reason: string }[];
}

export const flashcardService = {
  async bulkImport(payload: BulkImportPayload): Promise<BulkImportResult> {
    return api.post<BulkImportResult>('/flashcards/bulk', payload);
  },
};
