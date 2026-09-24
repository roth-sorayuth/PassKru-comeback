// Shared helpers for the PassKru Arcade: game list, daily booth stats and small utils.

export type GameId = 'flashcards' | 'maze' | 'nim' | 'match';

export interface GameInfo {
  id: GameId;
  title: string;
  subtitle: string;
  badge: string;
  path: string;
}

export const GAMES: GameInfo[] = [
  { id: 'flashcards', title: 'បណ្ណចងចាំ', subtitle: 'កូដ វប្បធម៌ទូទៅ Data Science និង CCNA', badge: '៣ កម្រិត៖ ងាយ មធ្យម ពិបាក', path: '/flashcards' },
  { id: 'maze', title: 'Code Maze', subtitle: 'សរសេរកម្មវិធីបញ្ជារ៉ូបូត', badge: 'គ្មានកំណត់ម៉ោង', path: '/maze' },
  { id: 'nim', title: 'ហ្គេមដកដីស', subtitle: 'ប្រកួតប្រាជ្ញាជាមួយ AI', badge: 'គ្មានកំណត់ម៉ោង', path: '/nim' },
  { id: 'match', title: 'ផ្គូផ្គងចំណេះដឹង', subtitle: 'ផ្គូពាក្យ និងអត្ថន័យ', badge: '២ នាទី', path: '/match' },
];

export const gameForPath = (pathname: string): GameId | null => {
  const path = pathname.replace(/\/+$/, '') || '/';
  return GAMES.find((g) => g.path === path)?.id ?? null;
};

const KHMER_DIGITS = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
export const km = (n: number | string) => String(n).replace(/\d/g, (d) => KHMER_DIGITS[Number(d)]);

export const shuffle = <T,>(list: T[]): T[] => {
  const out = [...list];
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
};

// ── Daily player count, kept on this device only ──
export interface BoothStats {
  date: string;
  players: number;
}

const STATS_KEY = 'passkru_arcade_stats';
// Local date (the booth's own time zone), so the day rolls over at local midnight.
const today = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
};

export const readStats = (): BoothStats => {
  try {
    const saved = JSON.parse(localStorage.getItem(STATS_KEY) || 'null');
    if (saved && saved.date === today()) return { date: saved.date, players: Number(saved.players) || 0 };
  } catch { }
  return { date: today(), players: 0 };
};

const writeStats = (stats: BoothStats) => {
  try {
    localStorage.setItem(STATS_KEY, JSON.stringify(stats));
  } catch { }
};

/** Counts one finished round. */
export const recordPlayer = (): BoothStats => {
  const next = readStats();
  next.players += 1;
  writeStats(next);
  return next;
};

export const resetStats = (): BoothStats => {
  const fresh = { date: today(), players: 0 };
  writeStats(fresh);
  return fresh;
};

/** Every game gets these from the arcade shell. */
export interface GameProps {
  onHome: () => void;
  /** Called once when a round ends, for the booth stats. */
  onFinish: (won: boolean) => void;
}
