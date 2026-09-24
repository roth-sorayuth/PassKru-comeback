import React, { useEffect, useMemo, useRef, useState } from 'react';
import { ArrowUp, Flag, Lightbulb, Play, RotateCcw, RotateCw, Trash2, Undo2 } from 'lucide-react';
import { GameProps, km } from '../lib/arcade';
import { ResultScreen } from '../components/ResultScreen';
import { chalkButton, goldButton } from '../components/ui';

// Visitors build a program (forward / turn left / turn right) that drives the
// robot to the flag. They get MAX_ATTEMPTS runs per maze.
const MAX_ATTEMPTS = 3;
const MAX_PROGRAM = 24;
const STEP_MS = 420;

type Cmd = 'F' | 'L' | 'R';
type Dir = 0 | 1 | 2 | 3; // up, right, down, left
type LevelId = 'easy' | 'hard' | 'expert';

interface Pos {
  r: number;
  c: number;
  d: Dir;
}

interface Maze {
  size: number;
  walls: boolean[][];
  start: Pos;
  goal: { r: number; c: number };
}

const LEVELS: { id: LevelId; label: string; size: number; walls: number; minPath: number }[] = [
  { id: 'easy', label: 'ងាយ', size: 5, walls: 5, minPath: 4 },
  { id: 'hard', label: 'ពិបាក', size: 6, walls: 9, minPath: 7 },
  { id: 'expert', label: 'ពិបាកខ្លាំង', size: 7, walls: 14, minPath: 10 },
];

const STEP: Record<Dir, [number, number]> = { 0: [-1, 0], 1: [0, 1], 2: [1, 0], 3: [0, -1] };
const CMD_CODE: Record<Cmd, string> = { F: 'robot.forward()', L: 'robot.turn_left()', R: 'robot.turn_right()' };

const turn = (d: Dir, cmd: 'L' | 'R'): Dir => ((cmd === 'L' ? d + 3 : d + 1) % 4) as Dir;

const isOpen = (maze: Maze, r: number, c: number) =>
  r >= 0 && c >= 0 && r < maze.size && c < maze.size && !maze.walls[r][c];

const key = (p: Pos) => `${p.r},${p.c},${p.d}`;

// Fewest commands from `from` to the goal (breadth-first search over position + facing).
const solve = (maze: Maze, from: Pos): Cmd[] | null => {
  const prev = new Map<string, { k: string; cmd: Cmd } | null>([[key(from), null]]);
  const queue: Pos[] = [from];
  while (queue.length) {
    const cur = queue.shift()!;
    if (cur.r === maze.goal.r && cur.c === maze.goal.c) {
      const path: Cmd[] = [];
      let k = key(cur);
      while (prev.get(k)) {
        const step = prev.get(k)!;
        path.unshift(step.cmd);
        k = step.k;
      }
      return path;
    }
    const [dr, dc] = STEP[cur.d];
    const next: [Pos, Cmd][] = [
      [{ r: cur.r + dr, c: cur.c + dc, d: cur.d }, 'F'],
      [{ ...cur, d: turn(cur.d, 'L') }, 'L'],
      [{ ...cur, d: turn(cur.d, 'R') }, 'R'],
    ];
    for (const [p, cmd] of next) {
      if (!isOpen(maze, p.r, p.c) || prev.has(key(p))) continue;
      prev.set(key(p), { k: key(cur), cmd });
      queue.push(p);
    }
  }
  return null;
};

const makeMaze = (levelId: LevelId): Maze => {
  const level = LEVELS.find((l) => l.id === levelId)!;
  const { size } = level;
  for (;;) {
    const walls = Array.from({ length: size }, () => Array(size).fill(false) as boolean[]);
    const start: Pos = { r: size - 1, c: 0, d: 0 };
    let placed = 0;
    while (placed < level.walls) {
      const r = Math.floor(Math.random() * size);
      const c = Math.floor(Math.random() * size);
      if ((r === start.r && c === start.c) || walls[r][c]) continue;
      walls[r][c] = true;
      placed++;
    }
    // Goal somewhere in the top half, on the right.
    const goal = { r: Math.floor(Math.random() * Math.ceil(size / 2)), c: size - 1 - Math.floor(Math.random() * 2) };
    if (walls[goal.r][goal.c]) continue;
    const maze = { size, walls, start, goal };
    const path = solve(maze, start);
    if (path && path.length >= level.minPath && path.length <= MAX_PROGRAM) return maze;
  }
};

// Runs a program and returns every position the robot passes through.
const simulate = (maze: Maze, program: Cmd[]) => {
  const trail: Pos[] = [maze.start];
  let pos = maze.start;
  for (const cmd of program) {
    if (cmd === 'F') {
      const [dr, dc] = STEP[pos.d];
      const next = { ...pos, r: pos.r + dr, c: pos.c + dc };
      if (!isOpen(maze, next.r, next.c)) return { trail, crashed: true, reached: false };
      pos = next;
    } else {
      pos = { ...pos, d: turn(pos.d, cmd) };
    }
    trail.push(pos);
    if (pos.r === maze.goal.r && pos.c === maze.goal.c) return { trail, crashed: false, reached: true };
  }
  return { trail, crashed: false, reached: false };
};

type RunState = 'idle' | 'running' | 'crashed' | 'short';

export const CodeMaze: React.FC<GameProps> = ({ onHome, onFinish }) => {
  const [level, setLevel] = useState<LevelId>('easy');
  const [maze, setMaze] = useState<Maze>(() => makeMaze('easy'));
  const [program, setProgram] = useState<Cmd[]>([]);
  const [robot, setRobot] = useState<Pos>(maze.start);
  const [activeStep, setActiveStep] = useState(-1);
  const [runState, setRunState] = useState<RunState>('idle');
  const [attempts, setAttempts] = useState(0);
  const [hint, setHint] = useState<string | null>(null);
  const [result, setResult] = useState<'won' | 'lost' | null>(null);
  const timer = useRef<number | null>(null);

  const running = runState === 'running';
  const attemptsLeft = MAX_ATTEMPTS - attempts;

  useEffect(() => () => {
    if (timer.current) window.clearInterval(timer.current);
  }, []);

  const newMaze = (lvl: LevelId = level) => {
    if (timer.current) window.clearInterval(timer.current);
    const m = makeMaze(lvl);
    setLevel(lvl);
    setMaze(m);
    setProgram([]);
    setRobot(m.start);
    setActiveStep(-1);
    setRunState('idle');
    setAttempts(0);
    setHint(null);
    setResult(null);
  };

  const add = (cmd: Cmd) => {
    if (running || program.length >= MAX_PROGRAM) return;
    setProgram((p) => [...p, cmd]);
    setRobot(maze.start);
    setRunState('idle');
    setHint(null);
  };

  const run = () => {
    if (running || program.length === 0) return;
    const { trail, crashed, reached } = simulate(maze, program);
    const used = attempts + 1;
    setAttempts(used);
    setRunState('running');
    setHint(null);
    let i = 0;
    setRobot(trail[0]);
    timer.current = window.setInterval(() => {
      i++;
      if (i < trail.length) {
        setRobot(trail[i]);
        setActiveStep(i - 1);
        return;
      }
      window.clearInterval(timer.current!);
      timer.current = null;
      setActiveStep(-1);
      if (reached) {
        onFinish(true);
        setResult('won');
      } else {
        setRunState(crashed ? 'crashed' : 'short');
        if (used >= MAX_ATTEMPTS) {
          onFinish(false);
          window.setTimeout(() => setResult('lost'), 900);
        }
      }
    }, STEP_MS);
  };

  // Next command of a shortest solution, from wherever the current program leaves the robot.
  const showHint = () => {
    const { trail, crashed } = simulate(maze, program);
    if (crashed) {
      setHint('កម្មវិធីបច្ចុប្បន្នបុកជញ្ជាំង — សូមលុបពាក្យបញ្ជាចុងក្រោយ');
      return;
    }
    const rest = solve(maze, trail[trail.length - 1]);
    if (!rest || rest.length === 0) return;
    setHint(`ពាក្យបញ្ជាបន្ទាប់៖ ${CMD_CODE[rest[0]]} (នៅសល់ ${km(rest.length)} ជំហាន)`);
  };

  const cells = useMemo(() => {
    const out: { r: number; c: number }[] = [];
    for (let r = 0; r < maze.size; r++) for (let c = 0; c < maze.size; c++) out.push({ r, c });
    return out;
  }, [maze]);

  if (result) {
    return (
      <ResultScreen
        won={result === 'won'}
        title={result === 'won' ? 'រ៉ូបូតដល់ទង់ហើយ!' : 'អស់ឱកាសហើយ!'}
        detail={result === 'won' ? `អ្នកប្រើ ${km(program.length)} ពាក្យបញ្ជា ក្នុងការសាកល្បងលើកទី ${km(attempts)}` : `អ្នកមានឱកាស ${km(MAX_ATTEMPTS)} ដង ក្នុងមួយផែនទី`}
        loseHint="ព្យាយាមគិតទិសដៅរបស់រ៉ូបូតមុនពេលបត់ឆ្វេង ឬស្ដាំ។"
        onPlayAgain={() => newMaze()}
        onHome={onHome}
      />
    );
  }

  return (
    <div className="animate-fadeIn">
      <div className="text-center mb-6">
        <h1 className="chalk-text font-display text-3xl sm:text-5xl leading-[1.6]">Code Maze</h1>
        <p className="chalk-text text-lg mt-1">សរសេរកម្មវិធីឱ្យរ៉ូបូតដើរទៅដល់ទង់។ អ្នកមានឱកាស {km(MAX_ATTEMPTS)} ដង។</p>
      </div>

      <div className="grid gap-5 lg:grid-cols-[1fr_320px] items-start">
        {/* Board */}
        <div className="rounded-lg border-2 border-chalk/30 p-3 sm:p-4">
          <div className="grid gap-1.5 mx-auto max-w-[480px]" style={{ gridTemplateColumns: `repeat(${maze.size}, minmax(0, 1fr))` }}>
            {cells.map(({ r, c }) => {
              const isRobot = robot.r === r && robot.c === c;
              const isGoal = maze.goal.r === r && maze.goal.c === c;
              return (
                <div
                  key={`${r}-${c}`}
                  className={`aspect-square rounded-md flex items-center justify-center ${maze.walls[r][c] ? 'hatch' : 'border border-dashed border-chalk/20'}`}
                >
                  {isGoal && !isRobot && <Flag className="w-1/2 h-1/2 text-star" strokeWidth={2.5} />}
                  {isRobot && (
                    <div className="relative w-4/5 h-4/5 flex items-center justify-center">
                      <span className={`text-[clamp(1.2rem,5vw,2.2rem)] ${runState === 'crashed' ? 'animate-pulse' : ''}`}>🤖</span>
                      <ArrowUp
                        className="absolute w-1/2 h-1/2 text-star transition-transform duration-300"
                        style={{ transform: `rotate(${robot.d * 90}deg) translateY(-85%)` }}
                      />
                    </div>
                  )}
                </div>
              );
            })}
          </div>
          {runState === 'crashed' && <p className="text-center chalk-text font-bold mt-3">រ៉ូបូតបុកជញ្ជាំង។ នៅសល់ឱកាស {km(attemptsLeft)} ដង</p>}
          {runState === 'short' && <p className="text-center chalk-text font-bold mt-3">រ៉ូបូតមិនទាន់ដល់ទង់ទេ។ នៅសល់ឱកាស {km(attemptsLeft)} ដង</p>}
        </div>

        {/* Controls */}
        <div className="space-y-4">
          <div>
            <div className="chalk-text text-sm font-semibold mb-2">កម្រិត</div>
            <div className="grid grid-cols-3 gap-2">
              {LEVELS.map((l) => (
                <button
                  key={l.id}
                  type="button"
                  disabled={running}
                  onClick={() => newMaze(l.id)}
                  className={`rounded-lg py-2 text-sm font-bold transition cursor-pointer ${level === l.id ? 'bg-star text-ink' : 'border-2 border-chalk/25 text-chalk hover:border-chalk/60'}`}
                >
                  {l.label}
                </button>
              ))}
            </div>
          </div>

          <div>
            <div className="chalk-text text-sm font-semibold mb-2">ពាក្យបញ្ជា</div>
            <div className="grid grid-cols-3 gap-2">
              {([
                ['F', 'ទៅមុខ', ArrowUp],
                ['L', 'បត់ឆ្វេង', RotateCcw],
                ['R', 'បត់ស្ដាំ', RotateCw],
              ] as [Cmd, string, React.ElementType][]).map(([cmd, label, Icon]) => (
                <button
                  key={cmd}
                  type="button"
                  disabled={running}
                  onClick={() => add(cmd)}
                  className="flex flex-col items-center gap-1 bg-paper text-ink rounded-lg py-3 font-bold text-sm shadow-[0_3px_0_var(--color-rule)] active:translate-y-[2px] active:shadow-none transition cursor-pointer disabled:opacity-50"
                >
                  <Icon className="w-6 h-6" />
                  {label}
                </button>
              ))}
            </div>
          </div>

          <div className="paper rounded-sm pl-12 pr-4 pt-1 pb-2">
            <div className="flex items-center justify-between leading-8">
              <span className="text-sm font-semibold text-mark">កម្មវិធី Python</span>
              <span className="text-sm text-slate-500">{km(program.length)}/{km(MAX_PROGRAM)}</span>
            </div>
            <div className="font-mono text-sm min-h-32 max-h-56 overflow-y-auto" dir="ltr">
              {program.length === 0 ? (
                <p className="font-sans text-slate-500 leading-8">ចុចពាក្យបញ្ជាខាងលើ ដើម្បីសរសេរកម្មវិធី</p>
              ) : (
                program.map((cmd, i) => (
                  <div key={i} className={`leading-8 px-1 rounded-sm ${activeStep === i ? 'bg-star text-ink' : 'text-ink'}`}>
                    <span className="text-slate-400 mr-3">{i + 1}</span>
                    {CMD_CODE[cmd]}
                  </div>
                ))
              )}
            </div>
          </div>

          {hint && <div className="border-2 border-dashed border-star/60 chalk-text rounded-lg p-3 text-sm leading-7" dir="auto">{hint}</div>}

          <div className="grid grid-cols-4 gap-2">
            <button
              type="button"
              onClick={run}
              disabled={running || program.length === 0}
              className={`col-span-2 ${goldButton}`}
            >
              <Play className="w-5 h-5" /> ដំណើរការ
            </button>
            <button
              type="button"
              title="លុបពាក្យបញ្ជាចុងក្រោយ"
              onClick={() => { setProgram((p) => p.slice(0, -1)); setRobot(maze.start); setRunState('idle'); setHint(null); }}
              disabled={running || program.length === 0}
              className={`${chalkButton} px-0`}
            >
              <Undo2 className="w-5 h-5" />
            </button>
            <button
              type="button"
              title="លុបទាំងអស់"
              onClick={() => { setProgram([]); setRobot(maze.start); setRunState('idle'); setHint(null); }}
              disabled={running || program.length === 0}
              className={`${chalkButton} px-0`}
            >
              <Trash2 className="w-5 h-5" />
            </button>
          </div>
          <button
            type="button"
            onClick={showHint}
            disabled={running}
            className={`w-full ${chalkButton} text-sm`}
          >
            <Lightbulb className="w-4 h-4 text-star" /> ជំនួយ
          </button>
        </div>
      </div>
    </div>
  );
};
