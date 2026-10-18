import fs from "fs";

const questions = JSON.parse(
  fs.readFileSync("D:/PassKru67/PassKru-comeback/server/elementary_math_questions.json", "utf8")
);

const sqlEscape = (str) => {
  if (str === null || str === undefined) return "NULL";
  return "'" + String(str).replace(/'/g, "''") + "'";
};

let sql = "-- ============================================================\n";
sql += "-- PassKru Elementary Mathematics Seed SQL\n";
sql += "-- Total Questions: " + questions.length + " (IDs 151 to 511)\n";
sql += "-- Exam Name: elementary\n";
sql += "-- Subject Name: Mathematics\n";
sql += "-- ============================================================\n\n";

sql += "BEGIN;\n\n";

sql += "-- 1. Ensure Subject 1 is named Mathematics\n";
sql += "UPDATE subject SET subject_name = 'Mathematics' WHERE subject_id = 1;\n\n";

sql += "-- 2. Ensure Topics 11-20 exist\n";
const topics = [
  [11, 1, "សមីការ និង វិសមីការ", "Equations & Inequalities"],
  [12, 1, "ធរណីមាត្រ និង កោណិក", "Geometry, Conics (Parabola, Ellipse, Sphere)"],
  [13, 1, "លីមីត និង អថេរភាព", "Limits & Continuity"],
  [14, 1, "អនុគមន៍ និង បន្ទាត់ប៉ះ", "Functions & Tangent Lines"],
  [15, 1, "អាំងតេក្រាល និង មាឌ", "Integrals, Areas & Solid Volumes"],
  [16, 1, "ត្រីកោណមាត្រ", "Trigonometric functions & equations"],
  [17, 1, "ចំនួនកុំផ្លិច", "Complex Numbers"],
  [18, 1, "ដេរីវេ និង អនុវត្តន៍", "Derivatives and Applications"],
  [19, 1, "ធរណីមាត្រ និង វ៉ិចទ័រក្នុងលំហ", "3D Geometry, Vectors, Planes in Space"],
  [20, 1, "ស្ថិតិ និង ប្រូបាប", "Combinatorics, Statistics & Probability"],
];

for (const [tid, sid, name, desc] of topics) {
  sql += "INSERT INTO topic (topic_id, subject_id, topic_name, description)\n";
  sql += `VALUES (${tid}, ${sid}, ${sqlEscape(name)}, ${sqlEscape(desc)})\n`;
  sql += "ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;\n";
}

sql += "\n-- 3. Insert Questions\n";
for (const q of questions) {
  sql += "INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)\n";
  sql += "VALUES (" + [
    q.questionId,
    q.topicId,
    sqlEscape("elementary"),
    sqlEscape("Mathematics"),
    sqlEscape(q.questionText),
    sqlEscape("multiple_choice"),
    sqlEscape(q.difficultyLevel),
    sqlEscape(q.correctAnswer),
    sqlEscape(q.explanation),
    sqlEscape(q.referenceNote),
  ].join(", ") + ")\n";
  sql += "ON CONFLICT (question_id) DO UPDATE SET\n";
  sql += "  topic_id = EXCLUDED.topic_id,\n";
  sql += "  exam_name = EXCLUDED.exam_name,\n";
  sql += "  subject_name = EXCLUDED.subject_name,\n";
  sql += "  question_text = EXCLUDED.question_text,\n";
  sql += "  question_type = EXCLUDED.question_type,\n";
  sql += "  difficulty_level = EXCLUDED.difficulty_level,\n";
  sql += "  correct_answer = EXCLUDED.correct_answer,\n";
  sql += "  explanation = EXCLUDED.explanation,\n";
  sql += "  reference_note = EXCLUDED.reference_note;\n\n";

  if (q.options && q.options.length > 0) {
    sql += `DELETE FROM answer_option WHERE question_id = ${q.questionId};\n`;
    for (const opt of q.options) {
      sql += "INSERT INTO answer_option (question_id, option_text, is_correct)\n";
      sql += `VALUES (${q.questionId}, ${sqlEscape(opt.text)}, ${opt.isCorrect ? "TRUE" : "FALSE"});\n`;
    }
    sql += "\n";
  }
}

sql += "SELECT setval(pg_get_serial_sequence('question', 'question_id'), (SELECT COALESCE(MAX(question_id), 1) FROM question));\n\n";
sql += "COMMIT;\n";

fs.writeFileSync("D:/PassKru67/PassKru-comeback/server/insert_elementary_math.sql", sql, "utf8");
console.log(`Saved insert_elementary_math.sql with ${questions.length} questions!`);

