import React, { useEffect, useState } from 'react';
import { Bot, User } from 'lucide-react';
import { GameProps, km } from '../lib/arcade';
import { ResultScreen } from '../components/ResultScreen';
import { goldButton } from '../components/ui';

// Misère Nim with one pile: take 1–3 chalk sticks per turn; whoever takes the
// last stick loses. The visitor moves first and the pile is never 1 (mod 4),
// so perfect play always beats the AI.
const START_PILES = [13, 14, 15, 17, 18, 19, 21];
const AI_DELAY_MS = 900;

type LevelId = 'easy' | 'hard';
const LEVELS: { id: LevelId; label: string; mistakeRate: number }[] = [
  { id: 'easy', label: 'ងាយ', mistakeRate: 0.45 },
  { id: 'hard', label: 'ពិបាក', mistakeRate: 0 },
];

// Leaving the opponent 1 (mod 4) sticks wins; otherwise any move loses against perfect play.
const aiMove = (pile: number, mistakeRate: number) => {
  const best = (pile - 1) % 4;
  const max = Math.min(3, pile);
  if (best >= 1 && best <= max && Math.random() >= mistakeRate) return best;
  return 1 + Math.floor(Math.random() * max);
};

interface Move {
  who: 'you' | 'ai';
  took: number;
}

export const NimGame: React.FC<GameProps> = ({ onHome, onFinish }) => {
  const [level, setLevel] = useState<LevelId>('easy');
  const [total, setTotal] = useState(() => START_PILES[Math.floor(Math.random() * START_PILES.length)]);
  const [pile, setPile] = useState(total);
  const [turn, setTurn] = useState<'you' | 'ai'>('you');
  const [moves, setMoves] = useState<Move[]>([]);
  const [result, setResult] = useState<'won' | 'lost' | null>(null);

  const newGame = (lvl: LevelId = level) => {
    const start = START_PILES[Math.floor(Math.random() * START_PILES.length)];
    setLevel(lvl);
    setTotal(start);
    setPile(start);
    setTurn('you');
    setMoves([]);
    setResult(null);
  };

  const take = (who: 'you' | 'ai', n: number) => {
    const left = pile - n;
    setPile(left);
    setMoves((m) => [...m, { who, took: n }]);
    if (left === 0) {
      // Whoever took the last stick loses.
      const youWon = who === 'ai';
      onFinish(youWon);
      window.setTimeout(() => setResult(youWon ? 'won' : 'lost'), 700);
      return;
    }
    setTurn(who === 'you' ? 'ai' : 'you');
  };

  useEffect(() => {
    if (turn !== 'ai' || pile === 0 || result) return;
    const mistakeRate = LEVELS.find((l) => l.id === level)!.mistakeRate;
    const t = window.setTimeout(() => take('ai', aiMove(pile, mistakeRate)), AI_DELAY_MS);
    return () => window.clearTimeout(t);
    // take() only reads pile, which is listed.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [turn, pile, result, level]);

  if (result) {
    return (
      <ResultScreen
        won={result === 'won'}
        title={result === 'won' ? 'អ្នកឈ្នះ AI ហើយ!' : 'AI ឈ្នះលើកនេះ!'}
        detail={result === 'won' ? 'AI ត្រូវដកដីសចុងក្រោយ' : 'អ្នកត្រូវដកដីសចុងក្រោយ'}
        loseHint="គន្លឹះ៖ ព្យាយាមទុកដីសឱ្យ AI ចំនួន ១, ៥, ៩, ១៣ ឬ ១៧។"
        onPlayAgain={() => newGame()}
        onHome={onHome}
      />
    );
  }

  const lastMove = moves[moves.length - 1];

  return (
    <div className="animate-fadeIn text-center">
      <h1 className="chalk-text font-display text-3xl sm:text-5xl leading-[1.6]">ហ្គេមដកដីស</h1>
      <p className="chalk-text text-lg mt-1 mb-6 leading-8">
        អ្នក និង AI ដកដីសម្ដងម្នាក់ ម្ដងៗពី ១ ទៅ ៣ ដើម។ អ្នកណាដកដីសដើមចុងក្រោយ អ្នកនោះចាញ់។
      </p>

      <div className="inline-grid grid-cols-2 gap-2 mb-8">
        {LEVELS.map((l) => (
          <button
            key={l.id}
            type="button"
            onClick={() => newGame(l.id)}
            className={`rounded-lg px-6 py-2 text-sm font-bold transition cursor-pointer ${level === l.id ? 'bg-star text-ink' : 'border-2 border-chalk/25 text-chalk hover:border-chalk/60'}`}
          >
            {l.label}
          </button>
        ))}
      </div>

      {/* Sticks */}
      <div className="mb-8">
        <div className="flex flex-wrap justify-center gap-2 sm:gap-3 min-h-[120px] items-end">
          {Array.from({ length: total }, (_, i) => {
            const gone = i >= pile;
            return (
              <div
                key={i}
                className={`w-3.5 sm:w-5 h-20 sm:h-28 rounded-[3px] bg-chalk shadow-[inset_-3px_0_0_rgb(0_0_0/0.12),0_4px_8px_rgb(0_0_0/0.35)] transition-all duration-500 ${gone ? 'opacity-0 -translate-y-6 scale-75' : ''}`}
              />
            );
          })}
        </div>
        <div className="chalk-text mt-6 text-2xl font-bold">
          នៅសល់ <span className="text-star">{km(pile)}</span> ដើម
        </div>
        <div className="chalk-text mt-1 h-7 text-chalk/75">
          {lastMove && (lastMove.who === 'ai' ? `🤖 AI បានដក ${km(lastMove.took)} ដើម` : `អ្នកបានដក ${km(lastMove.took)} ដើម`)}
        </div>
      </div>

      {/* Turn + actions */}
      <div className="flex items-center justify-center gap-3 mb-4 font-bold">
        {turn === 'you' ? (
          <span className="inline-flex items-center gap-2 bg-chalk text-ink rounded-lg px-4 py-2"><User className="w-4 h-4" /> វេនរបស់អ្នក</span>
        ) : (
          <span className="inline-flex items-center gap-2 border-2 border-chalk/30 text-chalk rounded-lg px-4 py-1.5"><Bot className="w-4 h-4 animate-bounce" /> AI កំពុងគិត…</span>
        )}
      </div>
      <div className="grid grid-cols-3 gap-3 max-w-md mx-auto">
        {[1, 2, 3].map((n) => (
          <button
            key={n}
            type="button"
            disabled={turn !== 'you' || n > pile}
            onClick={() => take('you', n)}
            className={`${goldButton} text-lg py-4`}
          >
            ដក {km(n)}
          </button>
        ))}
      </div>
    </div>
  );
};
