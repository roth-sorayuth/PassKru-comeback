import React, { useEffect, useMemo } from 'react';
import { GoldStar, TeacherMark, chalkButton, goldButton } from './ui';

// The result screen goes back to the arcade on its own for the next visitor.
const RESULT_IDLE_SECONDS = 45;
// Paper scraps and gold stars falling on a win.
const CONFETTI_COLORS = ['var(--color-star)', 'var(--color-chalk)', 'var(--color-mark)', 'var(--color-rule)'];

interface ResultScreenProps {
  won: boolean;
  title?: string;
  detail: React.ReactNode;
  loseHint?: string;
  onPlayAgain: () => void;
  onHome: () => void;
}

export const ResultScreen: React.FC<ResultScreenProps> = ({ won, title, detail, loseHint, onPlayAgain, onHome }) => {
  const confetti = useMemo(
    () =>
      Array.from({ length: 48 }, (_, i) => ({
        left: Math.random() * 100,
        delay: Math.random() * 2.5,
        duration: 3 + Math.random() * 2.5,
        color: CONFETTI_COLORS[i % CONFETTI_COLORS.length],
        size: 7 + Math.random() * 8,
        star: i % 4 === 0,
      })),
    [],
  );

  useEffect(() => {
    const t = window.setTimeout(onHome, RESULT_IDLE_SECONDS * 1000);
    return () => window.clearTimeout(t);
  }, [onHome]);

  return (
    <div className="text-center py-4 animate-fadeIn">
      <style>{`@keyframes arcade-fall { 0% { transform: translateY(-10vh) rotate(0deg); } 100% { transform: translateY(110vh) rotate(540deg); } }`}</style>

      {won && (
        <div className="pointer-events-none fixed inset-0 overflow-hidden" aria-hidden>
          {confetti.map((c, i) => (
            <span
              key={i}
              className="absolute top-0"
              style={{
                left: `${c.left}%`,
                width: c.size,
                height: c.star ? c.size : c.size * 0.45,
                background: c.color,
                clipPath: c.star ? 'polygon(50% 0,61% 36%,98% 37%,68% 58%,79% 95%,50% 72%,21% 95%,32% 58%,2% 37%,39% 36%)' : undefined,
                animation: `arcade-fall ${c.duration}s linear ${c.delay}s infinite`,
              }}
            />
          ))}
        </div>
      )}

      {won ? (
        <GoldStar label="ល្អណាស់" className="w-36 h-36 sm:w-44 sm:h-44 text-base sm:text-xl animate-stamp mb-4" />
      ) : (
        <div className="inline-flex w-28 h-28 items-center justify-center rounded-full bg-paper mb-4 rotate-[-6deg] shadow-xl">
          <TeacherMark correct={false} className="w-16 h-16" />
        </div>
      )}

      <h1 className="chalk-text font-display text-2xl sm:text-4xl leading-[1.8] mb-2">
        {title ?? (won ? 'អបអរសាទរ! អ្នកឈ្នះកាដូ' : 'ជិតបានហើយ!')}
      </h1>
      <div className="chalk-text text-lg sm:text-xl mb-8">{detail}</div>

      {won ? (
        <p className="chalk-text font-semibold text-star text-lg mb-10">សូមទទួលកាដូពីបុគ្គលិក PassKru</p>
      ) : (
        loseHint && <p className="chalk-text text-chalk/80 mb-10 max-w-md mx-auto leading-8">{loseHint}</p>
      )}

      <div className="flex flex-wrap justify-center gap-3">
        {!won && (
          <button type="button" onClick={onPlayAgain} className={goldButton}>
            លេងម្តងទៀត
          </button>
        )}
        <button type="button" onClick={onHome} className={chalkButton}>
          អ្នកលេងបន្ទាប់
        </button>
      </div>
    </div>
  );
};
