import React from 'react';

// Shared classroom pieces: taped paper notes, the gold-star sticker, teacher's marks, buttons.

export const goldButton =
  'inline-flex items-center justify-center gap-2 bg-star text-ink font-bold rounded-xl px-6 py-3.5 shadow-[0_4px_0_var(--color-star-deep)] active:translate-y-[3px] active:shadow-[0_1px_0_var(--color-star-deep)] transition cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed';

export const chalkButton =
  'inline-flex items-center justify-center gap-2 border-2 border-chalk/40 text-chalk font-bold rounded-xl px-5 py-3 hover:border-chalk/80 hover:bg-chalk/5 active:scale-[0.98] transition cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed';

interface NoteProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  tilt?: number;
}

/** A paper note taped to the board. Straightens up when pointed at. */
export const Note: React.FC<NoteProps> = ({ tilt = 0, className = '', style, children, ...rest }) => (
  <button
    type="button"
    {...rest}
    style={{ ...style, ['--tilt' as string]: `${tilt}deg` }}
    className={`tape paper text-left rounded-sm p-5 pt-6 rotate-[var(--tilt)] hover:rotate-0 hover:-translate-y-1 transition duration-200 cursor-pointer ${className}`}
  >
    {children}
  </button>
);

/** The gold-star sticker teachers give for good work. Pass `absolute` in className to place it. */
export const GoldStar: React.FC<{ className?: string; label?: string }> = ({ className = '', label }) => (
  <div className={`${className.includes('absolute') ? '' : 'relative '}inline-flex items-center justify-center ${className}`}>
    <svg viewBox="0 0 100 100" className="absolute inset-0 w-full h-full drop-shadow-[0_6px_10px_rgb(0_0_0/0.4)]" aria-hidden>
      <polygon
        points="50,4 61,36 96,37 68,58 78,92 50,72 22,92 32,58 4,37 39,36"
        fill="var(--color-star)"
        stroke="var(--color-star-deep)"
        strokeWidth="3"
        strokeLinejoin="round"
      />
    </svg>
    {label && <span className="relative font-display text-ink leading-none pt-[0.35em] whitespace-nowrap">{label}</span>}
  </div>
);

/** Hand-drawn red tick or cross, as a teacher marks an answer. */
export const TeacherMark: React.FC<{ correct: boolean; className?: string }> = ({ correct, className = '' }) => (
  <svg viewBox="0 0 100 100" className={className} aria-hidden fill="none" stroke="var(--color-mark)" strokeWidth="9" strokeLinecap="round" strokeLinejoin="round">
    {correct ? (
      <path d="M14 52 C24 60, 32 70, 40 82 C52 58, 70 32, 90 12" />
    ) : (
      <>
        <path d="M20 18 C40 40, 62 62, 84 86" />
        <path d="M82 16 C60 40, 40 62, 18 84" />
      </>
    )}
  </svg>
);

/** Chalk sticks lying in the board's tray. */
export const ChalkTray: React.FC = () => (
  <div className="chalk-tray fixed bottom-0 inset-x-0 h-5 sm:h-6 z-10" aria-hidden>
    <div className="absolute -top-2 left-[12%] w-14 h-3 rounded-full bg-chalk rotate-[-4deg] shadow" />
    <div className="absolute -top-1.5 left-[18%] w-8 h-2.5 rounded-full bg-star/90 rotate-[6deg] shadow" />
    <div className="absolute -top-2 right-[16%] w-10 h-3 rounded-full bg-chalk/90 rotate-[3deg] shadow" />
    <div className="absolute -top-2 right-[9%] w-16 h-4 rounded-sm bg-[#2a2a2a] rotate-[-2deg] shadow border-t-4 border-[#c9c2b5]" />
  </div>
);
