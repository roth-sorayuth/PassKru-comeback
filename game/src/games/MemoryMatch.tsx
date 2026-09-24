import React, { useEffect, useRef, useState } from 'react';
import { Timer } from 'lucide-react';
import { GameProps, km, shuffle } from '../lib/arcade';
import { ResultScreen } from '../components/ResultScreen';

// Flip two cards at a time to pair each term with its meaning before time runs out.
// Every card is shown face-up for PEEK_SECONDS first, so players can memorise them.
const PAIRS_PER_GAME = 5;
const SECONDS = 120;
const PEEK_SECONDS = 4;
const MISMATCH_MS = 1500;

const PAIRS: [string, string][] = [
  // Coding
  ['HTML', 'រចនាសម្ព័ន្ធគេហទំព័រ'],
  ['CSS', 'ពណ៌ និងប្លង់គេហទំព័រ'],
  ['SQL', 'ភាសាសម្រាប់ Database'],
  ['Git', 'គ្រប់គ្រងកំណែកូដ'],
  ['Bug', 'កំហុសក្នុងកម្មវិធី'],
  ['1 Byte', '8 Bits'],
  ['404', 'រកទំព័រមិនឃើញ'],
  ['AI', 'បញ្ញាសិប្បនិម្មិត'],
  ['for / while', 'Loop ធ្វើដដែលៗ'],
  ['# ក្នុង Python', 'សរសេរ Comment'],
  // វប្បធម៌ទូទៅ
  ['ប្រាសាទអង្គរវត្ត', 'ព្រះបាទសូរ្យវរ្ម័នទី២'],
  ['ប្រាសាទបាយ័ន', 'ព្រះបាទជ័យវរ្ម័នទី៧'],
  ['ទិវាឯករាជ្យជាតិ', '៩ វិច្ឆិកា ១៩៥៣'],
  ['ទិវារដ្ឋធម្មនុញ្ញ', '២៤ កញ្ញា ១៩៩៣'],
  ['ផ្កាជាតិ', 'ផ្ការំដួល'],
  ['សត្វជាតិ', 'គោព្រៃ'],
  ['បក្សីជាតិ', 'ត្រយ៉ង'],
  ['ភ្នំខ្ពស់ជាងគេ', 'ភ្នំឱរ៉ាល់'],
  ['ខេត្តធំជាងគេ', 'មណ្ឌលគិរី'],
  ['ភ្លេងជាតិ', 'នគររាជ'],
];

interface Card {
  id: number;
  pair: number;
  text: string;
  kind: 'term' | 'meaning';
}

// Closed cards look like school exercise-book covers, in three colours.
const COVERS = ['#2d6cb5', '#c2413b', '#1f8a5f'];

const deal = (): Card[] => {
  const picked = shuffle(PAIRS.map((_, i) => i)).slice(0, PAIRS_PER_GAME);
  const cards = picked.flatMap((pair) => [
    { pair, text: PAIRS[pair][0], kind: 'term' as const },
    { pair, text: PAIRS[pair][1], kind: 'meaning' as const },
  ]);
  return shuffle(cards).map((c, id) => ({ ...c, id }));
};

export const MemoryMatch: React.FC<GameProps> = ({ onHome, onFinish }) => {
  const [cards, setCards] = useState<Card[]>(deal);
  const [open, setOpen] = useState<number[]>([]);
  const [matched, setMatched] = useState<Set<number>>(new Set());
  const [secondsLeft, setSecondsLeft] = useState(SECONDS);
  const [started, setStarted] = useState(false);
  const [result, setResult] = useState<'won' | 'lost' | null>(null);
  const [flips, setFlips] = useState(0);
  const [peekLeft, setPeekLeft] = useState(PEEK_SECONDS);
  const busy = useRef(false);
  const peeking = peekLeft > 0;

  const newGame = () => {
    setCards(deal());
    setOpen([]);
    setMatched(new Set());
    setSecondsLeft(SECONDS);
    setStarted(false);
    setResult(null);
    setFlips(0);
    setPeekLeft(PEEK_SECONDS);
    busy.current = false;
  };

  // Opening preview: count down, then turn every card face-down.
  useEffect(() => {
    if (!peeking) return;
    const t = window.setTimeout(() => setPeekLeft((s) => s - 1), 1000);
    return () => window.clearTimeout(t);
  }, [peeking, peekLeft]);

  // The clock starts on the first flip.
  useEffect(() => {
    if (!started || result) return;
    if (secondsLeft <= 0) {
      onFinish(false);
      setResult('lost');
      return;
    }
    const t = window.setTimeout(() => setSecondsLeft((s) => s - 1), 1000);
    return () => window.clearTimeout(t);
    // onFinish is stable enough for a single call at time-out.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [started, secondsLeft, result]);

  const flip = (card: Card) => {
    if (peeking || busy.current || result || open.includes(card.id) || matched.has(card.pair)) return;
    setStarted(true);
    setFlips((f) => f + 1);
    const nowOpen = [...open, card.id];
    if (nowOpen.length < 2) {
      setOpen(nowOpen);
      return;
    }
    const [a, b] = nowOpen.map((id) => cards[id]);
    setOpen(nowOpen);
    if (a.pair === b.pair) {
      const next = new Set(matched).add(a.pair);
      setMatched(next);
      setOpen([]);
      if (next.size === PAIRS_PER_GAME) {
        onFinish(true);
        window.setTimeout(() => setResult('won'), 600);
      }
    } else {
      busy.current = true;
      window.setTimeout(() => {
        setOpen([]);
        busy.current = false;
      }, MISMATCH_MS);
    }
  };

  if (result) {
    return (
      <ResultScreen
        won={result === 'won'}
        title={result === 'won' ? 'ផ្គូផ្គងបានទាំងអស់!' : 'អស់ម៉ោងហើយ!'}
        detail={
          result === 'won'
            ? `ប្រើពេល ${km(SECONDS - secondsLeft)} វិនាទី និងបើកបណ្ណ ${km(flips)} ដង`
            : `អ្នកផ្គូបាន ${km(matched.size)} / ${km(PAIRS_PER_GAME)} គូ`
        }
        loseHint="ចងចាំទីតាំងបណ្ណដែលបានបើករួច ដើម្បីផ្គូបានលឿនជាងមុន។"
        onPlayAgain={newGame}
        onHome={onHome}
      />
    );
  }

  return (
    <div className="animate-fadeIn">
      <div className="text-center mb-5">
        <h1 className="chalk-text font-display text-3xl sm:text-5xl leading-[1.6]">ផ្គូផ្គងចំណេះដឹង</h1>
        <p className="chalk-text text-lg mt-1 leading-8">
          បើកបណ្ណម្ដង ២ ដើម្បីផ្គូពាក្យជាមួយអត្ថន័យរបស់វា ឱ្យបានទាំង {km(PAIRS_PER_GAME)} គូ ក្នុងរយៈពេល {km(SECONDS / 60)} នាទី។
        </p>
      </div>

      <div className="chalk-text flex items-center justify-between max-w-3xl mx-auto mb-3 font-semibold">
        {peeking ? (
          <span className="text-star text-lg">ចងចាំទីតាំងបណ្ណ… {km(peekLeft)}</span>
        ) : (
          <span>ផ្គូបាន <span className="text-star text-lg">{km(matched.size)}</span> / {km(PAIRS_PER_GAME)}</span>
        )}
        <span className={`flex items-center gap-1 text-lg ${started && secondsLeft <= 10 ? 'text-mark bg-chalk rounded-md px-2' : ''}`}>
          <Timer className="w-4 h-4" /> {km(secondsLeft)} វិ
        </span>
      </div>
      <div className="h-1 bg-chalk/15 rounded-full overflow-hidden mb-6 max-w-3xl mx-auto">
        <div className="h-full bg-chalk/80 transition-all duration-1000 ease-linear" style={{ width: `${(secondsLeft / SECONDS) * 100}%` }} />
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-5 gap-2.5 sm:gap-3 max-w-3xl mx-auto">
        {cards.map((card) => {
          const isMatched = matched.has(card.pair);
          const faceUp = peeking || isMatched || open.includes(card.id);
          return (
            <button
              key={card.id}
              type="button"
              onClick={() => flip(card)}
              className="group perspective-1000 aspect-[4/3] cursor-pointer"
              aria-label={faceUp ? card.text : 'បណ្ណបិទ'}
            >
              <div className={`relative w-full h-full transform-style-3d transition-transform duration-500 ${faceUp ? 'rotate-y-180' : ''}`}>
                <div
                  className="absolute inset-0 backface-hidden rounded-md overflow-hidden flex items-center justify-center shadow-[0_8px_16px_-6px_rgb(0_0_0/0.6)] transition-transform group-hover:-translate-y-0.5"
                  style={{
                    backgroundColor: COVERS[card.id % COVERS.length],
                    backgroundImage:
                      'linear-gradient(90deg, rgb(0 0 0 / 0.28) 0 9%, rgb(255 255 255 / 0.18) 9% 10%, transparent 10%), repeating-linear-gradient(135deg, rgb(255 255 255 / 0.06) 0 6px, transparent 6px 12px)',
                  }}
                >
                  {/* Name label, as on a student's notebook */}
                  <div className="ml-[6%] w-[62%] bg-paper rounded-sm px-2 py-1.5 flex flex-col items-center gap-1 shadow-sm">
                    <img src="/PassKru-logo.svg" alt="" className="h-5 sm:h-7 object-contain" />
                    <span className="block w-full border-b border-dashed border-ink/30" />
                    <span className="block w-3/4 border-b border-dashed border-ink/30" />
                  </div>
                </div>
                {/* The face is only rendered while shown, so it can't be read before flipping. */}
                {faceUp && (
                  <div
                    className={`absolute inset-0 backface-hidden rotate-y-180 rounded-md shadow-lg flex flex-col items-center justify-center p-2 text-center ${
                      isMatched ? 'bg-ok text-paper' : card.kind === 'term' ? 'bg-paper text-ink' : 'bg-[#fff4d1] text-ink'
                    }`}
                  >
                    <span className="text-xs font-semibold opacity-70 mb-0.5">{card.kind === 'term' ? 'ពាក្យ' : 'អត្ថន័យ'}</span>
                    <span className="font-bold text-sm sm:text-base leading-snug break-words">{card.text}</span>
                  </div>
                )}
              </div>
            </button>
          );
        })}
      </div>
    </div>
  );
};
