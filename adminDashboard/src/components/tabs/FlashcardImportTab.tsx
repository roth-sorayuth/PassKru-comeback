import React, { useRef, useState } from 'react';
import { FileJson, Loader2, CheckCircle2, AlertCircle, Upload } from 'lucide-react';
import { Subject } from '../../types';
import { BulkFlashcardInput, BulkImportResult, flashcardService } from '../../services/flashcardService';

interface FlashcardImportTabProps {
  subjects: Subject[];
}

/** Accepts a JSON array, or an object with a `flashcards` array. */
function parseCards(text: string): BulkFlashcardInput[] {
  const data = JSON.parse(text);
  const list = Array.isArray(data) ? data : data?.flashcards;
  if (!Array.isArray(list)) throw new Error('ឯកសារត្រូវតែជា JSON array នៃ flashcard');
  return list;
}

export const FlashcardImportTab: React.FC<FlashcardImportTabProps> = ({ subjects }) => {
  const fileRef = useRef<HTMLInputElement>(null);
  const [fileName, setFileName] = useState('');
  const [cards, setCards] = useState<BulkFlashcardInput[]>([]);
  const [subjectName, setSubjectName] = useState('');
  const [cardsPerDeck, setCardsPerDeck] = useState(10);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [result, setResult] = useState<BulkImportResult | null>(null);

  const subjectOptions = Array.from(new Set(subjects.map((s) => s.subjectName)));

  const handleFile = async (file?: File) => {
    setError('');
    setResult(null);
    if (!file) return;
    try {
      const parsed = parseCards(await file.text());
      setCards(parsed);
      setFileName(file.name);
    } catch (e) {
      setCards([]);
      setFileName('');
      setError(e instanceof Error ? `មិនអាចអានឯកសារបានទេ៖ ${e.message}` : 'មិនអាចអានឯកសារបានទេ');
    }
  };

  const handleImport = async () => {
    setError('');
    setResult(null);
    setLoading(true);
    try {
      const res = await flashcardService.bulkImport({ subjectName: subjectName.trim(), cardsPerDeck, flashcards: cards });
      setResult(res);
      setCards([]);
      setFileName('');
      if (fileRef.current) fileRef.current.value = '';
    } catch (e) {
      setError(e instanceof Error ? e.message : 'ការនាំចូលបរាជ័យ');
    } finally {
      setLoading(false);
    }
  };

  const canImport = cards.length > 0 && subjectName.trim().length > 0 && !loading;

  return (
    <div className="max-w-2xl space-y-5">
      <div className="bg-white border border-slate-200 rounded-xl p-5 space-y-4">
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1.5">មុខវិជ្ជា</label>
          <input
            list="flashcard-subjects"
            value={subjectName}
            onChange={(e) => setSubjectName(e.target.value)}
            placeholder="ឧ. ភាសាអង់គ្លេស"
            className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <datalist id="flashcard-subjects">
            {subjectOptions.map((n) => (
              <option key={n} value={n} />
            ))}
          </datalist>
          <p className="text-xs text-slate-500 mt-1">បើមុខវិជ្ជាមិនទាន់មាន ប្រព័ន្ធនឹងបង្កើតថ្មីដោយស្វ័យប្រវត្តិ។</p>
        </div>

        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1.5">ចំនួនសន្លឹកក្នុងមួយ Deck</label>
          <input
            type="number"
            min={1}
            max={100}
            value={cardsPerDeck}
            onChange={(e) => setCardsPerDeck(Number(e.target.value) || 10)}
            className="w-28 border border-slate-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1.5">ឯកសារ Flashcard (.json / .txt)</label>
          <input
            ref={fileRef}
            type="file"
            accept=".json,.txt,application/json,text/plain"
            onChange={(e) => handleFile(e.target.files?.[0])}
            className="hidden"
          />
          <button
            type="button"
            onClick={() => fileRef.current?.click()}
            className="w-full flex items-center justify-center gap-2 border-2 border-dashed border-slate-300 rounded-lg py-6 text-sm text-slate-600 hover:border-blue-400 hover:text-blue-600 transition-colors"
          >
            {fileName ? <FileJson className="w-5 h-5" /> : <Upload className="w-5 h-5" />}
            {fileName ? `${fileName} — ${cards.length} សន្លឹក` : 'ចុចដើម្បីជ្រើសរើសឯកសារ'}
          </button>
          <p className="text-xs text-slate-500 mt-1">
            ទម្រង់៖ front_text, back_text, hint, category, difficulty។ Flashcard ដែលមានស្រាប់ក្នុងមុខវិជ្ជានឹងត្រូវរំលង។
          </p>
        </div>

        <button
          type="button"
          onClick={handleImport}
          disabled={!canImport}
          className="w-full flex items-center justify-center gap-2 bg-blue-600 text-white text-sm font-medium rounded-lg py-2.5 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-blue-700 transition-colors"
        >
          {loading && <Loader2 className="w-4 h-4 animate-spin" />}
          {loading ? 'កំពុងនាំចូល...' : `នាំចូល ${cards.length || ''} សន្លឹក`}
        </button>
      </div>

      {error && (
        <div className="flex items-start gap-2 bg-red-50 border border-red-200 text-red-700 rounded-lg p-3 text-sm">
          <AlertCircle className="w-4 h-4 mt-0.5 shrink-0" />
          <span>{error}</span>
        </div>
      )}

      {result && (
        <div className="bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-lg p-4 text-sm space-y-1">
          <div className="flex items-center gap-2 font-medium">
            <CheckCircle2 className="w-4 h-4" /> នាំចូលបានជោគជ័យ — {result.subjectName}
          </div>
          <p>បង្កើត Deck ថ្មី៖ {result.decksCreated} · បង្កើត Flashcard ថ្មី៖ {result.cardsCreated}</p>
          {result.skippedDuplicates > 0 && <p>រំលង (មានស្រាប់)៖ {result.skippedDuplicates}</p>}
          {result.invalid.length > 0 && (
            <p>
              មិនត្រឹមត្រូវ {result.invalid.length} សន្លឹក (ជួរ៖ {result.invalid.map((i) => i.index).join(', ')})
            </p>
          )}
        </div>
      )}
    </div>
  );
};
