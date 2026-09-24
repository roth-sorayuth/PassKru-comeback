import React, { useEffect, useState } from 'react';
import { BarChart3, Code2, Landmark, Network, Shuffle } from 'lucide-react';
import { BOOTH_DECKS, BoothCard, BoothDeckId } from '../data/flashcardDecks';
import { GameProps, km, shuffle } from '../lib/arcade';
import { ResultScreen } from '../components/ResultScreen';
import { Note, TeacherMark, goldButton } from '../components/ui';

// Visitors answer CARDS_PER_GAME cards and win a gift when they reach the level's pass score.
const CARDS_PER_GAME = 10;

// Levels change the rules, not the questions: fewer answer choices, more time
// and a lower pass score make a round easier.
type LevelId = 'easy' | 'medium' | 'hard';
interface Level {
  id: LevelId;
  label: string;
  choices: number;
  seconds: number;
  passScore: number;
}
const LEVELS: Level[] = [
  { id: 'easy', label: 'ងាយ', choices: 3, seconds: 30, passScore: 6 },
  { id: 'medium', label: 'មធ្យម', choices: 4, seconds: 20, passScore: 8 },
  { id: 'hard', label: 'ពិបាក', choices: 4, seconds: 15, passScore: 9 },
];
const levelById = (id: LevelId) => LEVELS.find((l) => l.id === id)!;

type DeckChoice = BoothDeckId | 'mix';
type Phase = 'start' | 'play' | 'result';

interface GameCard extends BoothCard {
  deckTitle: string;
}

// Picks the cards for one game, keeps `choices` options per card (the answer
// plus random wrong ones) and shuffles them.
const dealCards = (choice: DeckChoice, choices: number): GameCard[] => {
  const decks = choice === 'mix' ? BOOTH_DECKS : BOOTH_DECKS.filter((d) => d.id === choice);
  const pool = decks.flatMap((d) => d.cards.map((c) => ({ ...c, deckTitle: d.titleKm })));
  return shuffle(pool)
    .slice(0, CARDS_PER_GAME)
    .map((card) => {
      const wrong = shuffle(card.options.map((_, i) => i).filter((i) => i !== card.answer)).slice(0, choices - 1);
      const order = shuffle([card.answer, ...wrong]);
      return { ...card, options: order.map((i) => card.options[i]), answer: order.indexOf(card.answer) };
    });
};

// Each deck is a note on the board; "mix" draws from every deck.
const DECK_LOOK: Record<BoothDeckId, { icon: React.ElementType; tilt: number }> = {
  coding: { icon: Code2, tilt: -1.5 },
  culture: { icon: Landmark, tilt: 1.2 },
  datascience: { icon: BarChart3, tilt: 1 },
  ccna: { icon: Network, tilt: -1 },
};

const DECK_BUTTONS: { id: DeckChoice; title: string; subtitle: string; icon: React.ElementType; tilt: number }[] = [
  ...BOOTH_DECKS.map((d) => ({ id: d.id, title: d.titleKm, subtitle: d.subtitleKm, ...DECK_LOOK[d.id] })),
  { id: 'mix', title: 'លាយបញ្ចូលគ្នា', subtitle: 'សំណួរពីគ្រប់ប្រធានបទ', icon: Shuffle, tilt: 1.5 },
];

// Answer choices are lettered like a Khmer exam paper.
const CHOICE_LETTERS = 'កខគឃ';

export const FlashcardGame: React.FC<GameProps> = ({ onHome, onFinish }) => {
  const [phase, setPhase] = useState<Phase>('start');
  const [deckChoice, setDeckChoice] = useState<DeckChoice>('mix');
  const [levelId, setLevelId] = useState<LevelId>('medium');
  const level = levelById(levelId);
  const [cards, setCards] = useState<GameCard[]>([]);
  const [index, setIndex] = useState(0);
  const [picked, setPicked] = useState<number | null>(null);
  const [timedOut, setTimedOut] = useState(false);
  const [secondsLeft, setSecondsLeft] = useState(level.seconds);
  const [score, setScore] = useState(0);

  const card = cards[index];
  const flipped = picked !== null || timedOut;
  const won = score >= level.passScore;

  const startGame = (choice: DeckChoice) => {
    setDeckChoice(choice);
    setCards(dealCards(choice, level.choices));
    setIndex(0);
    setPicked(null);
    setTimedOut(false);
    setSecondsLeft(level.seconds);
    setScore(0);
    setPhase('play');
  };

  // Countdown while the question side is showing.
  useEffect(() => {
    if (phase !== 'play' || flipped) return;
    if (secondsLeft <= 0) {
      setTimedOut(true);
      return;
    }
    const t = window.setTimeout(() => setSecondsLeft((s) => s - 1), 1000);
    return () => window.clearTimeout(t);
  }, [phase, flipped, secondsLeft]);

  const choose = (optionIndex: number) => {
    if (flipped || !card) return;
    setPicked(optionIndex);
    if (optionIndex === card.answer) setScore((s) => s + 1);
  };

  const nextCard = () => {
    if (index + 1 >= cards.length) {
      onFinish(score >= level.passScore);
      setPhase('result');
      return;
    }
    setIndex((i) => i + 1);
    setPicked(null);
    setTimedOut(false);
    setSecondsLeft(level.seconds);
  };


  const answeredCorrectly = picked !== null && !!card && picked === card.answer;

  if (phase === 'result') {
    return (
      <ResultScreen
        won={won}
        detail={
          <>
            អ្នកឆ្លើយត្រូវ <span className="font-bold text-star text-2xl">{km(score)}</span> ក្នុងចំណោម {km(cards.length)} សំណួរ
          </>
        }
        loseHint={`កម្រិត${level.label} ត្រូវឆ្លើយត្រូវ ${km(level.passScore)} សំណួរ ដើម្បីឈ្នះកាដូ។`}
        onPlayAgain={() => startGame(deckChoice)}
        onHome={onHome}
      />
    );
  }

  if (phase === 'start') {
    return (
      <div className="animate-fadeIn">
        <div className="text-center mb-10">
          <h1 className="chalk-text font-display text-3xl sm:text-5xl leading-[1.6]">បណ្ណចងចាំ</h1>

          {/* Level picker: the rules line below updates with it. */}
          <div className="inline-grid grid-cols-3 gap-2 mt-4" role="radiogroup" aria-label="កម្រិត">
            {LEVELS.map((l) => (
              <button
                key={l.id}
                type="button"
                role="radio"
                aria-checked={levelId === l.id}
                onClick={() => setLevelId(l.id)}
                className={`rounded-lg px-5 sm:px-7 py-2 font-bold transition cursor-pointer ${
                  levelId === l.id ? 'bg-star text-ink' : 'border-2 border-chalk/25 text-chalk hover:border-chalk/60'
                }`}
              >
                {l.label}
              </button>
            ))}
          </div>
          <p className="chalk-text text-lg mt-4 leading-8">
            សំណួរនីមួយៗមាន {km(level.choices)} ជម្រើស និង {km(level.seconds)} វិនាទី។ ឆ្លើយត្រូវ {km(level.passScore)} ក្នុងចំណោម {km(CARDS_PER_GAME)} ដើម្បីឈ្នះកាដូ។
          </p>
        </div>

        {/* Three notes per row; a shorter last row stays centred on the board. */}
        <div className="flex flex-wrap justify-center gap-x-5 gap-y-9">
          {DECK_BUTTONS.map(({ id, title, subtitle, icon: Icon, tilt }) => (
            <Note key={id} tilt={tilt} onClick={() => startGame(id)} className="pl-12 w-full sm:w-[calc((100%-2.5rem)/3)]">
              <Icon className="w-8 h-8 text-ink mb-1" strokeWidth={1.75} />
              <div className="font-display text-lg leading-[2]">{title}</div>
              <div className="text-slate-600 leading-8">{subtitle}</div>
              <div className="font-semibold text-mark leading-8">ចាប់ផ្ដើមលេង</div>
            </Note>
          ))}
        </div>
      </div>
    );
  }

  if (!card) return null;

  return (
    <div className="animate-fadeIn">
      {/* Progress, score and a chalk-line timer */}
      <div className="flex items-center justify-between mb-3 gap-4 chalk-text">
        <span className="font-semibold">
          សំណួរទី {km(index + 1)} / {km(cards.length)}
          <span className="ml-3 text-sm border border-chalk/30 rounded-md px-2 py-0.5">{level.label}</span>
        </span>
        <div className="flex items-center gap-4 font-semibold">
          <span>ពិន្ទុ <span className="text-star text-lg">{km(score)}</span></span>
          <span className={`tabular-nums text-lg ${secondsLeft <= 5 && !flipped ? 'text-mark bg-chalk rounded-md px-2' : ''}`}>
            {km(secondsLeft)} វិ
          </span>
        </div>
      </div>
      <div className="h-1 rounded-full bg-chalk/15 mb-8" aria-hidden>
        <div
          className={`h-full rounded-full transition-all duration-1000 ease-linear ${secondsLeft <= 5 ? 'bg-mark' : 'bg-chalk/80'}`}
          style={{ width: `${(secondsLeft / level.seconds) * 100}%` }}
        />
      </div>

      {/* Flip card: both faces share one grid cell so the card takes the taller face's height.
          Keyed by card so the next card mounts face-up instead of flipping back
          (which would show its answer side mid-turn). */}
      <div key={index} className="perspective-1000 animate-fadeIn">
        <div className={`grid transform-style-3d transition-transform duration-[600ms] ${flipped ? 'rotate-y-180' : ''}`}>
          {/* FRONT: the question on ruled exam paper */}
          <div className="[grid-area:1/1] backface-hidden paper tape rounded-sm pl-12 pr-5 sm:pr-8 pt-7 pb-6">
            <div className="text-sm font-semibold text-mark leading-8">{card.deckTitle}</div>
            <h2 className="text-xl sm:text-3xl font-bold leading-[1.9] mb-3">{card.question}</h2>
            {card.code && (
              <pre className="bg-board-deep text-chalk rounded-md p-4 mb-5 text-sm sm:text-base font-mono overflow-x-auto whitespace-pre leading-relaxed" dir="ltr">
                {card.code}
              </pre>
            )}
            <div className={`grid gap-2.5 ${card.options.length === 4 ? 'sm:grid-cols-2' : ''}`}>
              {card.options.map((opt, i) => (
                <button
                  key={i}
                  type="button"
                  disabled={flipped}
                  onClick={() => choose(i)}
                  className="group flex items-center gap-3 text-left rounded-lg border-2 border-rule bg-paper/80 hover:border-ink px-3 py-3 sm:text-lg font-semibold transition active:scale-[0.98] cursor-pointer disabled:cursor-default"
                >
                  <span className="shrink-0 w-9 h-9 rounded-full border-2 border-ink/70 text-ink flex items-center justify-center font-bold group-hover:bg-ink group-hover:text-paper transition">
                    {CHOICE_LETTERS[i]}
                  </span>
                  <span className="break-words min-w-0">{opt}</span>
                </button>
              ))}
            </div>
          </div>

          {/* BACK: marked by the teacher. Only rendered once answered, so it is never in the page early. */}
          {flipped && (
            <div className="[grid-area:1/1] backface-hidden rotate-y-180 paper rounded-sm pl-12 pr-5 sm:pr-8 pt-7 pb-6 flex flex-col items-center justify-center text-center">
              <TeacherMark correct={answeredCorrectly} className="w-20 h-20 mb-1" />
              <div className={`font-display text-2xl sm:text-3xl leading-[1.8] ${answeredCorrectly ? 'text-ok' : 'text-mark'}`}>
                {answeredCorrectly ? 'ត្រឹមត្រូវ!' : timedOut ? 'អស់ម៉ោងហើយ' : 'មិនទាន់ត្រូវ'}
              </div>
              <div className="text-slate-600 leading-8">ចម្លើយត្រឹមត្រូវ</div>
              <div className="font-bold text-lg sm:text-xl leading-8 mb-2 break-words max-w-full underline decoration-mark decoration-2 underline-offset-8">
                {card.options[card.answer]}
              </div>
              <p className="text-slate-600 leading-8 mb-5 max-w-md">{card.explain}</p>
              <button type="button" onClick={nextCard} className={goldButton}>
                {index + 1 >= cards.length ? 'មើលលទ្ធផល' : 'សំណួរបន្ទាប់'}
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
