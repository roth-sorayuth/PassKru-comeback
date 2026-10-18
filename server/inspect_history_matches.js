import fs from 'fs';
import { prisma } from './src/config/prisma.js';

function extractQuestions(str) {
  const questions = [];
  let inString = false, escape = false, depth = 0, start = -1;
  for (let i = 0; i < str.length; i++) {
    const char = str[i];
    if (inString) {
      if (escape) escape = false;
      else if (char === '\\') escape = true;
      else if (char === '"') inString = false;
      continue;
    }
    if (char === '"') { inString = true; continue; }
    if (char === '{') {
      if (depth === 0) start = i;
      depth++;
    } else if (char === '}') {
      depth--;
      if (depth === 0 && start !== -1) {
        const objStr = str.slice(start, i + 1);
        try {
          const parsed = JSON.parse(objStr);
          if (parsed.questionID || parsed.questionText) questions.push(parsed);
        } catch (e) {}
        start = -1;
      }
    }
  }
  return questions;
}

async function inspectHistory() {
  const allDbQuestions = await prisma.question.findMany({
    where: { subjectName: 'History' },
    select: { questionId: true, questionText: true, examName: true }
  });

  const content = fs.readFileSync('C:/Users/U-ser/Downloads/Telegram Desktop/history highschool.txt', 'utf8');
  const questions = extractQuestions(content);

  const matched = [];
  const unmatched = [];

  questions.forEach(q => {
    const qClean = q.questionText.trim().replace(/\s*\[cite:[^\]]+\]/g, '').slice(0, 30);
    const found = allDbQuestions.find(dbQ => dbQ.questionText.includes(qClean));
    if (found) {
      matched.push({ fileQ: q.questionID, dbQ: found.questionId, text: q.questionText.slice(0, 40) });
    } else {
      unmatched.push({ fileQ: q.questionID, text: q.questionText.slice(0, 40) });
    }
  });

  console.log('Total in history highschool.txt:', questions.length);
  console.log('Matched count:', matched.length);
  console.log('Unmatched count:', unmatched.length);
  console.log('Sample matched:', matched.slice(0, 5));
  console.log('Sample unmatched:', unmatched.slice(0, 5));
  process.exit(0);
}

inspectHistory();

