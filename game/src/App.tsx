import React, { useCallback, useEffect, useState } from 'react';
import { ArrowLeft, Brain, Layers, Puzzle, Route } from 'lucide-react';
import { GAMES, GameId, GameProps, gameForPath, km, readStats, recordPlayer, resetStats } from './lib/arcade';
import { FlashcardGame } from './games/FlashcardGame';
import { CodeMaze } from './games/CodeMaze';
import { NimGame } from './games/NimGame';
import { MemoryMatch } from './games/MemoryMatch';
import { ChalkTray, GoldStar, Note } from './components/ui';


const GAME_VIEWS: Record<GameId, React.FC<GameProps>> = {
  flashcards: FlashcardGame,
  maze: CodeMaze,
  nim: NimGame,
  match: MemoryMatch,
};

// Each note sits at its own slight angle, like notes pinned up by hand.
const GAME_LOOK: Record<GameId, { icon: React.ElementType; tilt: number }> = {
  flashcards: { icon: Layers, tilt: -2 },
  maze: { icon: Route, tilt: 1.5 },
  nim: { icon: Brain, tilt: 1 },
  match: { icon: Puzzle, tilt: -1.5 },
};

export const App: React.FC = () => {
  const [gameId, setGameId] = useState<GameId | null>(() => gameForPath(window.location.pathname));
  const [stats, setStats] = useState(readStats);
  // Bumped on every visit to a game so "next player" always starts it fresh.
  const [round, setRound] = useState(0);

  useEffect(() => {
    const onPop = () => setGameId(gameForPath(window.location.pathname));
    window.addEventListener('popstate', onPop);
    return () => window.removeEventListener('popstate', onPop);
  }, []);

  useEffect(() => {
    const game = GAMES.find((g) => g.id === gameId);
    document.title = game ? `${game.title} · PassKru Arcade` : 'PassKru Arcade';
    window.scrollTo({ top: 0 });
  }, [gameId, round]);

  const open = (id: GameId | null) => {
    const path = id ? GAMES.find((g) => g.id === id)!.path : '/';
    if (window.location.pathname !== path) window.history.pushState({}, '', path);
    setGameId(id);
    setRound((r) => r + 1);
  };

  const goHome = useCallback(() => open(null), []);
  // Every finished round counts one player, win or lose.
  const onFinish = useCallback(() => setStats(recordPlayer()), []);

  const onResetStats = () => {
    if (window.confirm('កំណត់ចំនួនអ្នកលេងថ្ងៃនេះឡើងវិញ?')) setStats(resetStats());
  };

  const GameView = gameId ? GAME_VIEWS[gameId] : null;

  return (
    <div className="chalkboard min-h-dvh text-chalk font-sans select-none overflow-x-hidden pb-10">
      <header className="flex items-center justify-between gap-3 px-4 sm:px-8 pt-5">
        {gameId ? (
          <button
            type="button"
            onClick={goHome}
            className="inline-flex items-center gap-2 text-chalk/80 hover:text-chalk font-semibold text-sm rounded-lg px-2 py-2 transition cursor-pointer"
          >
            <ArrowLeft className="w-5 h-5" /> ហ្គេមទាំងអស់
          </button>
        ) : (
          <div className="flex items-center gap-3">
            <img src="/PassKru-logo.svg" alt="PassKru" className="w-11 h-11 rounded-xl bg-paper p-1 object-contain" />
            <span className="font-semibold text-chalk/80">PassKru</span>
          </div>
        )}
        {/* Chalk tally of today's players. Staff double-click it to reset. */}
        <button
          type="button"
          onDoubleClick={onResetStats}
          title="ចុចពីរដងដើម្បីកំណត់ឡើងវិញ"
          className="chalk-text text-right text-sm leading-relaxed rounded-lg px-3 py-1.5 border border-dashed border-chalk/25"
        >
          អ្នកលេងថ្ងៃនេះ <span className="font-bold text-lg text-star">{km(stats.players)}</span>
        </button>
      </header>

      <main className="max-w-4xl mx-auto px-4 sm:px-8 py-6 sm:py-10">
        {GameView ? (
          <GameView key={`${gameId}-${round}`} onHome={goHome} onFinish={onFinish} />
        ) : (
          <div className="animate-fadeIn">
            <div className="relative text-center mt-8 sm:mt-0 mb-12 sm:mb-14">
              <h1 className="chalk-text font-display text-3xl sm:text-6xl leading-[1.5] pt-2">PassKru Arcade</h1>
              <p className="chalk-text text-lg sm:text-xl mt-2">ជ្រើសហ្គេមមួយ លេងឈ្នះ ហើយយកកាដូទៅផ្ទះ</p>
              <GoldStar
                label="កាដូ"
                className="absolute -top-12 right-0 sm:-top-6 sm:-right-2 w-16 h-16 sm:w-32 sm:h-32 text-xs sm:text-2xl rotate-[12deg]"
              />
            </div>

            <div className="grid gap-x-6 gap-y-9 sm:grid-cols-2">
              {GAMES.map((game) => {
                const { icon: Icon, tilt } = GAME_LOOK[game.id];
                return (
                  <Note key={game.id} tilt={tilt} onClick={() => open(game.id)} className="flex items-start gap-4 pl-12">
                    <Icon className="shrink-0 w-9 h-9 text-ink mt-1" strokeWidth={1.75} />
                    <div className="min-w-0">
                      <div className="font-display text-lg sm:text-xl leading-[1.9] text-ink">{game.title}</div>
                      <div className="text-slate-600 leading-8">{game.subtitle}</div>
                      <div className="text-sm font-semibold text-mark leading-8">{game.badge}</div>
                    </div>
                  </Note>
                );
              })}
            </div>

            <p className="chalk-text text-center text-sm text-chalk/60 mt-14">ត្រៀមប្រឡងគ្រូជាមួយ PassKru៖ សំណួរ បណ្ណចងចាំ និងវិញ្ញាសាគំរូ</p>
          </div>
        )}
      </main>
      <ChalkTray />
    </div>
  );
};
