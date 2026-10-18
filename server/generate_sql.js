import fs from "fs";

const questions = JSON.parse(
  fs.readFileSync("D:/PassKru67/PassKru-comeback/server/secondary_math_questions.json", "utf8")
);

const sqlEscape = (str) => {
  if (str === null || str === undefined) return "NULL";
  return "'" + String(str).replace(/'/g, "''") + "'";
};

let sql = "-- ============================================================\n";
sql += "-- PassKru Secondary Mathematics Seed SQL\n";
sql += "-- Total Questions: " + questions.length + " (IDs 861 to 1010)\n";
sql += "-- Exam Name: secondary\n";
sql += "-- Safe to execute directly in Supabase SQL Editor or psql\n";
sql += "-- ============================================================\n\n";

sql += "BEGIN;\n\n";

sql += "-- 1. Ensure Exam exists\n";
sql += "INSERT INTO exam (exam_id, exam_name, exam_type, category, target_code, description)\n";
sql += "VALUES (2, 'Secondary National Exam', 'កម្រិតមូលដ្ឋាន', 'secondary', 'secondary', 'Secondary School Teacher Exam (RTTC)')\n";
sql += "ON CONFLICT (exam_id) DO UPDATE SET\n";
sql += "  exam_name = EXCLUDED.exam_name,\n";
sql += "  target_code = EXCLUDED.target_code;\n\n";

sql += "-- 2. Ensure Subject exists\n";
sql += "INSERT INTO subject (subject_id, exam_id, subject_name, description)\n";
sql += "VALUES (2, 2, 'Mathematics', 'Secondary Teacher Mathematics')\n";
sql += "ON CONFLICT (subject_id) DO UPDATE SET\n";
sql += "  subject_name = EXCLUDED.subject_name;\n\n";

sql += "-- 3. Ensure Topics 1-7 exist for Mathematics\n";
const topics = [
  [1, 2, "ចំនួនកុំផ្លិច និង សមីការ", "Complex numbers, polynomial and exponential equations"],
  [2, 2, "អាំងតេក្រាល និង ផ្ទៃក្រឡា", "Indefinite & definite integrals, bounded areas"],
  [3, 2, "ព្រីមីទីវ និង ដេរីវេ", "Primitives, derivatives, and applications"],
  [4, 2, "អនុគមន៍ និង ភាពជាប់", "Functions, limits, and continuity"],
  [5, 2, "ធរណីមាត្រ និង ប្លង់ក្នុងលំហ", "3D geometry, planes, spheres, and vectors"],
  [6, 2, "វិភាគបន្សំ និង ប្រូបាប", "Combinatorics, permutations, and probability"],
  [7, 2, "សមីការឌីផេរ៉ង់ស្យែល", "Differential equations and curves"],
];

for (const [tid, sid, name, desc] of topics) {
  sql += "INSERT INTO topic (topic_id, subject_id, topic_name, description)\n";
  sql += `VALUES (${tid}, ${sid}, ${sqlEscape(name)}, ${sqlEscape(desc)})\n`;
  sql += "ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;\n";
}
sql += "\n-- 4. Insert Questions & Options\n";

for (const q of questions) {
  sql += "INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)\n";
  sql += "VALUES (" + [
    q.questionId,
    q.topicId,
    sqlEscape("secondary"),
    sqlEscape("Mathematics"),
    sqlEscape(q.questionText),
    sqlEscape(q.questionType),
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
    for (let i = 0; i < q.options.length; i++) {
      const opt = q.options[i];
      sql += "INSERT INTO answer_option (question_id, option_text, is_correct)\n";
      sql += `VALUES (${q.questionId}, ${sqlEscape(opt.text)}, ${opt.isCorrect ? "TRUE" : "FALSE"});\n`;
    }
    sql += "\n";
  }
}

sql += "-- Reset sequence for question_id\n";
sql += "SELECT setval(pg_get_serial_sequence('question', 'question_id'), COALESCE(MAX(question_id), 1)) FROM question;\n\n";

sql += "COMMIT;\n";

fs.writeFileSync("D:/PassKru67/PassKru-comeback/server/insert_secondary_math.sql", sql, "utf8");
console.log(`Successfully generated insert_secondary_math.sql with ${questions.length} questions!`);

