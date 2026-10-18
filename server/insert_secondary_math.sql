-- ============================================================
-- PassKru Secondary Mathematics Seed SQL
-- Total Questions: 150 (IDs 861 to 1010)
-- Exam Name: secondary
-- Safe to execute directly in Supabase SQL Editor or psql
-- ============================================================

BEGIN;

-- 1. Ensure Exam exists
INSERT INTO exam (exam_id, exam_name, exam_type, category, target_code, description)
VALUES (2, 'Secondary National Exam', 'កម្រិតមូលដ្ឋាន', 'secondary', 'secondary', 'Secondary School Teacher Exam (RTTC)')
ON CONFLICT (exam_id) DO UPDATE SET
  exam_name = EXCLUDED.exam_name,
  target_code = EXCLUDED.target_code;

-- 2. Ensure Subject exists
INSERT INTO subject (subject_id, exam_id, subject_name, description)
VALUES (2, 2, 'Mathematics', 'Secondary Teacher Mathematics')
ON CONFLICT (subject_id) DO UPDATE SET
  subject_name = EXCLUDED.subject_name;

-- 3. Ensure Topics 1-7 exist for Mathematics
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (1, 2, 'ចំនួនកុំផ្លិច និង សមីការ', 'Complex numbers, polynomial and exponential equations')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (2, 2, 'អាំងតេក្រាល និង ផ្ទៃក្រឡា', 'Indefinite & definite integrals, bounded areas')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (3, 2, 'ព្រីមីទីវ និង ដេរីវេ', 'Primitives, derivatives, and applications')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (4, 2, 'អនុគមន៍ និង ភាពជាប់', 'Functions, limits, and continuity')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (5, 2, 'ធរណីមាត្រ និង ប្លង់ក្នុងលំហ', '3D geometry, planes, spheres, and vectors')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (6, 2, 'វិភាគបន្សំ និង ប្រូបាប', 'Combinatorics, permutations, and probability')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (7, 2, 'សមីការឌីផេរ៉ង់ស្យែល', 'Differential equations and curves')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;

-- 4. Insert Questions & Options
INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (1, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច x^2 - 2x + 5 = 0។', 'multiple_choice', 'medium', 'x = -1 ± 2i', 'បំប្លែងសមីការជា (x - 1)^2 = -4 នាំឱ្យ x - 1 = ±2i ដូចនេះ x = -1 ± 2i។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 1;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (1, 'x = 1 ± 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (1, 'x = 1 ± 4i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (1, 'x = -1 ± 2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (1, 'x = -1 ± 4i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (2, 1, 'secondary', 'Mathematics', 'គណនាឫសការេនៃចំនួនកុំផ្លិច 8 - 6i។', 'multiple_choice', 'medium', '3 - i, -3 + i', 'សរសេរ 8 - 6i ជា (3 - i)^2 ដូចនេះឫសការេគឺ ±(3 - i)។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 2;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (2, '3 - i, -3 + i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (2, '3 + i, -3 - i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (2, '1 - 3i, -1 + 3i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (2, '1 + 3i, -1 - 3i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (3, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់ I = ∫ cos^2(x) dx។', 'multiple_choice', 'easy', '1/2 x + 1/4 sin(2x) + c', 'ប្រើប្រាស់រូបមន្តត្រីកោណមាត្រ cos^2(x) = (1 + cos(2x))/2 ដើម្បីគណនា។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 3;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (3, '1/2 x - 1/4 sin(2x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (3, '1/2 x + 1/4 sin(2x) + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (3, '1/2 x + 1/2 sin(2x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (3, 'x + 1/2 sin(2x) + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (4, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់ J = ∫ x sin(x) dx។', 'multiple_choice', 'medium', '-x cos(x) + sin(x) + c', 'ប្រើវិធីសាស្ត្រអាំងតេក្រាលដោយផ្នែក (Integration by Parts) ដោយតាង u = x។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 4;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (4, 'x cos(x) - sin(x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (4, '-x cos(x) - sin(x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (4, 'x sin(x) + cos(x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (4, '-x cos(x) + sin(x) + c', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (5, 3, 'secondary', 'Mathematics', 'រកព្រីមីទីវនៃអនុគមន៍ f(x) = 2x(x^3 + 1) ដោយដឹងថាព្រីមីទីវស្មើ 3 កាលណា x = -1។', 'multiple_choice', 'medium', 'F(x) = 2x^5/5 + x^2 + 12/5', 'រកអាំងតេក្រាល F(x) = ∫ 2x(x^3 + 1) dx រួចជំនួសលក្ខខណ្ឌ F(-1) = 3 ដើម្បីរកតម្លៃថេរ c។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ព្រីមីទីវ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 5;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (5, 'F(x) = 2x^5/5 + x^2 + 18/5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (5, 'F(x) = x^5/5 + x^2 + 12/5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (5, 'F(x) = 2x^5/5 + x^2 + 12/5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (5, 'F(x) = 2x^5/5 + x^2 + 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (6, 4, 'secondary', 'Mathematics', 'សិក្សាភាពជាប់នៃអនុគមន៍ f(x) = (x - 1) / (|x| + 1) ត្រង់ចំណុច x = 0។', 'multiple_choice', 'easy', 'អនុគមន៍ជាប់ត្រង់ x = 0', 'ពិនិត្យលីមីតខាងឆ្វេង និងខាងស្តាំស្មើនឹងតម្លៃ f(0) = -1 ដូចនេះអនុគមន៍ជាប់ត្រង់ x = 0។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ភាពជាប់នៃអនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 6;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (6, 'អនុគមន៍ជាប់ត្រង់ x = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (6, 'អនុគមន៍មិនជាប់ត្រង់ x = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (6, 'អនុគមន៍មានដេរីវេត្រង់ x = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (6, 'គ្មានចម្លើយខាងលើ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (7, 5, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): y'''' + 4y'' + 4y = 0។', 'multiple_choice', 'easy', 'y = (Ax + B)e^(-2x)', 'សមីការសម្គាល់មានឫសឌុប λ = -2 ដូចនេះចម្លើយទូទៅគឺ y = (Ax + B)e^(-2x)។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 7;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (7, 'y = (Ax + B)e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (7, 'y = (Ax + B)e^(-2x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (7, 'y = A e^(-2x) + B e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (7, 'y = A e^(-2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (8, 6, 'secondary', 'Mathematics', 'ក្នុងតម្រុយអរតូណរម៉ាល់ គេមាន A(2,2,2), B(2,0,1) និង C(4,1,-1)។ តើត្រីកោណ ABC ជាត្រីកោណអ្វី?', 'multiple_choice', 'medium', 'ត្រីកោណកែងត្រង់ B', 'គណនាផលគុណស្កាលែរ BA⋅BC = 0 នាំឱ្យ BA ⊥ BC ដូចនេះ ABC ជាត្រីកោណកែងត្រង់ B។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 8;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (8, 'ត្រីកោណកែងត្រង់ B', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (8, 'ត្រីកោណសម័ង្ស', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (8, 'ត្រីកោណសាមញ្ញ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (8, 'ត្រីកោណសមសាសន៍', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (9, 6, 'secondary', 'Mathematics', 'រកសមីការប្លង់កាត់តាមចំណុច A(2,2,2), B(2,0,1) និង C(4,1,-1)។', 'multiple_choice', 'medium', '-5x + 2y - 4z + 14 = 0', 'រកវ៉ិចទ័រណរម៉ាល់ n = BA × BC = (-5, 2, -4) រួចសរសេរសមីការប្លង់កាត់តាម B។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 9;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (9, '-5x + 2y - 4z + 14 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (9, '-5x + 2y - 4z - 14 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (9, '5x + 2y - 4z - 6 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (9, '-5x - 2y - 4z + 14 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (10, 7, 'secondary', 'Mathematics', 'គណនាផ្ទៃក្រឡាផ្នែកប្លង់ខណ្ឌដោយខ្សែកោង f(x) = 1/(x-1)^2 + 1/(x+1)^2, បន្ទាត់ x = 2 និង x = 5។', 'multiple_choice', 'medium', '11/12 ឯកតាផ្ទៃ', 'គណនាអាំងតេក្រាលកំណត់ S = ∫_{2}^{5} f(x) dx ដែលស្មើនឹង 11/12 ឯកតាផ្ទៃ។', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០២ - ផ្ទៃក្រឡា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 10;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (10, '7/12 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (10, '13/12 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (10, '5/6 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (10, '11/12 ឯកតាផ្ទៃ', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (11, 1, 'secondary', 'Mathematics', 'សរសេរសចំនួនកុំផ្លិច 1 + i√3 ជាទម្រង់ត្រីកោណមាត្រ។', 'multiple_choice', 'easy', '2(cos(π/6) + i sin(π/6))', 'គណនាម៉ូឌុល r = 2 និងអាគុយម៉ង់ θ = π/6 រួចជំនួសចូលទម្រង់ត្រីកោណមាត្រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 11;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (11, '2(cos(π/3) + i sin(π/3))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (11, '2(cos(π/4) + i sin(π/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (11, '2(cos(π/6) + i sin(π/6))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (11, '4(cos(π/6) + i sin(π/6))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (12, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច |z| - z = 1 + 2i។', 'multiple_choice', 'medium', 'z = 3/2 - 2i', 'តាង z = a + bi ជំនួសចូលសមីការ ហើយเทียบផ្នែកពិត និងផ្នែកនិម្មិតដើម្បីរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 12;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (12, 'z = 3/2 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (12, 'z = 3/2 - 2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (12, 'z = -3/2 - 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (12, 'z = 5/2 - 2i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (13, 2, 'secondary', 'Mathematics', 'គណនាដេរីវេទី 5 នៃអនុគមន៍ f(x) = x^5 - 2x^4 + 3x^3 - 2។', 'multiple_choice', 'easy', '120', 'ធ្វើដេរីវេបន្តបន្ទាប់គ្នា៥ដង រហូតដល់ដេរីវេទី៥ ស្មើនឹងថេរ ១២០。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ដេរីវេ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 13;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (13, '120', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (13, '24', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (13, '720', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (13, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (14, 2, 'secondary', 'Mathematics', 'កំណត់ដេរីវេទី n នៃអនុគមន៍ h(x) = x^n ដោយដឹងថា n ∈ ℕ*។', 'multiple_choice', 'medium', 'n!', 'ដេរីវេទី n នៃពុធាដឺក្រេទី n គឺហ្វាក់តូរីយ៉ែល n (n!)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ដេរីវេ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 14;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (14, 'n! x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (14, '(n - 1)!', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (14, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (14, 'n!', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (15, 3, 'secondary', 'Mathematics', 'រកព្រីមីទីវ F(x) នៃអនុគមន៍ f(x) = cos x ដែលខ្សែកោងតាង F(x) កាត់តាមចំណុច A(π/2, 0)។', 'multiple_choice', 'easy', 'F(x) = sin x - 1', 'រកអាំងតេក្រាល F(x) = sin x + c រួចជំនួសកូអរដោនេចំណុច A ដើម្បីរកតម្លៃ c = -1。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ព្រីមីទីវ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 15;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (15, 'F(x) = sin x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (15, 'F(x) = -sin x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (15, 'F(x) = sin x - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (15, 'F(x) = -sin x - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (16, 4, 'secondary', 'Mathematics', 'រកចម្លើយនៃសមីការឌីផេរ៉ង់ស្យែល y'''' - 3y'' + 2y = 0 ផ្ទៀងផ្ទាត់លក្ខខណ្ឌ y(1) = 1 និង y''(1) = 3។', 'multiple_choice', 'medium', 'y = -e^(x-1) + 2e^(2x-2)', 'រកចម្លើយទូទៅ y = Ae^x + Be^(2x) រួចប្រើលក្ខខណ្ឌអមដើម្បីកំណត់តម្លៃថេរ A និង B。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 16;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (16, 'y = -e^(x-1) + 2e^(2x-2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (16, 'y = e^(x-1) + 2e^(2x-2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (16, 'y = -e^(x-1) - 2e^(2x-2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (16, 'y = 2e^(x-1) - e^(2x-2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (17, 5, 'secondary', 'Mathematics', 'ស្រាយបញ្ជាក់ថាប្លង់ (α): 3x - 2y + 2z - 5 = 0 អរតូកូណាល់នឹងប្លង់ (β): 4x + 5y - z + 1 = 0។', 'multiple_choice', 'easy', 'ប្លង់ទាំងពីរអរតូកូណាល់នឹងគ្នា', 'ផលគុណស្កាលែរវាងវ៉ិចទ័រណរម៉ាល់ n1⋅n2 = 0 ដូចនេះប្លង់ទាំងពីរអរតូកូណាល់នឹងគ្នា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 17;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (17, 'ប្លង់ទាំងពីរអរតូកូណាល់នឹងគ្នា', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (17, 'ប្លង់ទាំងពីរស្របគ្នា', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (17, 'ប្លង់ទាំងពីរប្រសព្វគ្នាត្រង់បន្ទាត់កែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (17, 'គ្មានចម្លើយ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (18, 5, 'secondary', 'Mathematics', 'សរសេរសមីការប៉ារ៉ាម៉ែត្រនៃបន្ទាត់ជាប្រសព្វរវាងប្លង់ (α) និង (β)។', 'multiple_choice', 'hard', 'x = 1 - 8/23 t, y = -1 - 11/23 t, z = t', 'ដោះស្រាយប្រព័ន្ធសមីការប្លង់ទាំងពីរដោយតាង z = t ដើម្បីទាញរកសមីការប៉ារ៉ាម៉ែត្រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - បន្ទាត់និងប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 18;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (18, 'x = 1 + 8/23 t, y = -1 - 11/23 t, z = t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (18, 'x = 1 - 8/23 t, y = -1 - 11/23 t, z = t', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (18, 'x = 1 - 8/23 t, y = -1 + 11/23 t, z = t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (18, 'x = -1 - 8/23 t, y = 1 - 11/23 t, z = t', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (19, 6, 'secondary', 'Mathematics', 'រកតម្លៃ a និង b នៃអនុគមន៍ f(x) = (ax^2 + bx) / (x^2 - 4x + 3) ដឹងថាមានតម្លៃអប្បបរមាស្មើ 4 ត្រង់ x = 2។', 'multiple_choice', 'medium', 'a = 1, b = -4', 'ប្រើប្រាស់លក្ខខណ្ឌ f(2) = 4 និង f''(2) = 0 ដើម្បីបង្កើតប្រព័ន្ធសមីការរក a = 1 និង b = -4。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 19;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (19, 'a = -1, b = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (19, 'a = 1, b = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (19, 'a = 2, b = -8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (19, 'a = 1, b = -4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (20, 7, 'secondary', 'Mathematics', 'សិក្សាទិសដៅអថេរភាព និងសង់ក្រាបនៃអនុគមន៍ f(x) = (x^2 - 4x) / (x^2 - 4x + 3)។', 'multiple_choice', 'medium', 'មានអប្បបរមាត្រង់ x = 2 ស្មើ -4', 'រកដែនកំណត់ លីមីត អាស៊ីមតូត និងដេរីវេដើម្បីសិក្សាអថេរភាព និងសង់ក្រាប。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៣ - សិក្សាអថេរភាព')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 20;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (20, 'មានអតិបរមាត្រង់ x = 2 ស្មើ -4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (20, 'មានអប្បបរមាត្រង់ x = 2 ស្មើ 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (20, 'មានអប្បបរមាត្រង់ x = 2 ស្មើ -4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (20, 'មានអតិបរមាត្រង់ x = 2 ស្មើ 4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (21, 1, 'secondary', 'Mathematics', 'រកចំនួនពិត x និង y ដើម្បីឱ្យបំពេញលក្ខខណ្ឌ (x + y) + (2x - y)i = 2 - 5i。', 'multiple_choice', 'easy', 'x = -1, y = 3', 'ផ្ទឹមផ្នែកពិត និងផ្នែកនិម្មិតនៃចំនួនកុំផ្លិចទាំងពីរដើម្បីបង្កើតប្រព័ន្ធសមីការរក x = -1 និង y = 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 21;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (21, 'x = -1, y = 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (21, 'x = 1, y = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (21, 'x = -1, y = -3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (21, 'x = 3, y = -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (22, 1, 'secondary', 'Mathematics', 'ចូរសរសេរ (1 + i√3)^10 ជារាង a + bi。', 'multiple_choice', 'medium', '-512 - 512√3 i', 'បម្លែងចំនួនកុំផ្លិចជាទម្រង់ត្រីកោណមាត្រ រួចប្រើរូបមន្តម៉្វាវ៉ា (De Moivre''s formula) ដើម្បីគណនាកម្លាំងទី១០。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 22;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (22, '-512 + 512√3 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (22, '-512 - 512√3 i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (22, '512 - 512√3 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (22, '512 + 512√3 i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (23, 2, 'secondary', 'Mathematics', 'រកក្រឡាផ្ទៃ S ដែលកំណត់ដោយខ្សែកោង y = sin x ចំពោះ 0 ≤ x ≤ 3π ជាមួយអ័ក្សអាប់ស៊ីស。', 'multiple_choice', 'medium', '6 ឯកតាផ្ទៃ', 'បែងចែកផ្ទៃក្រឡាជាបំណែក S = S1 - S2 + S3 ហើយគណនាអាំងតេក្រាលកំណត់លើនីមួយៗទទួលបានលទ្ធផលស្មើនឹង 6。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - អាំងតេក្រាលនិងផ្ទៃក្រឡា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 23;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (23, '0 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (23, '2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (23, '4 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (23, '6 ឯកតាផ្ទៃ', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (24, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់ I = ∫ x cos(x) dx。', 'multiple_choice', 'medium', 'x sin(x) + cos(x) + c', 'ប្រើវិធីអាំងតេក្រាលដោយផ្នែក (Integration by Parts) ដោយតាង u = x និង dv = cos(x) dx。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 24;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (24, 'x sin(x) - cos(x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (24, '-x sin(x) + cos(x) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (24, 'x sin(x) + cos(x) + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (24, 'x cos(x) + sin(x) + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (25, 3, 'secondary', 'Mathematics', 'ក្នុងតម្រុយអរតូណរម៉ាល់គេមានបីចំណុច A(1,4,2), B(2,1,3), C(-2,2,-1)។ គណនាក្រឡាផ្ទៃនៃ ΔABC。', 'multiple_choice', 'medium', '11√2 / 2 ឯកតាផ្ទៃ', 'គណនាផលគុណវ៉ិចទ័រ AB × AC រួចយកម៉ូឌុលចែកនឹង ២ ដើម្បីរកក្រឡាផ្ទៃត្រីកោណ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 25;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (25, '11√2 / 2 ឯកតាផ្ទៃ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (25, '11√2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (25, '9√2 / 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (25, '11 / 2 ឯកតាផ្ទៃ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (26, 4, 'secondary', 'Mathematics', 'សរសេរលេខ 1 ដល់ 9 លើកាក់។ ចាប់យក 3 កាក់ម្តងមួយៗមកតម្រៀប។ រកប្រូបាបដើម្បីឱ្យកាក់បង្កើតបានជាចំនួន 123。', 'multiple_choice', 'easy', '1 / 504', 'ចំនួនករណីស្របគឺ 1 និងចំនួនករណីអាចសរុបគឺ P(9,3) = 504 ដូចនេះប្រូបាបគឺ 1/504。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 26;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (26, '1 / 84', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (26, '1 / 504', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (26, '1 / 729', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (26, '3 / 504', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (27, 5, 'secondary', 'Mathematics', 'គណនាតម្លៃអតិបរមា អប្បបរមា និងរកកូអរដោនេចំណុចរបត់របស់ខ្សែកោង y = 3x e^(-x^2)。', 'multiple_choice', 'hard', 'អតិបរមា 3√2/2 e^(-1/2), អប្បបរមា -3√2/2 e^(-1/2)', 'រកដេរីវេទីមួយ y'' និងដេរីវេទីពីរ y'''' ស្មើបាយអរដោនេចំណុចប្រែប្រួល និងចំណុចរបត់。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 27;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (27, 'អតិបរមា 3 e^(-1), អប្បបរមា -3 e^(-1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (27, 'អតិបរមា 3√2 e^(-1/2), អប្បបរមា -3√2 e^(-1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (27, 'អតិបរមា 3√2/2 e^(-1), អប្បបរមា -3√2/2 e^(-1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (27, 'អតិបរមា 3√2/2 e^(-1/2), អប្បបរមា -3√2/2 e^(-1/2)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (28, 6, 'secondary', 'Mathematics', 'កំណត់អនុគមន៍ពហុធាដឺក្រេទី២ g(x) = ax^2 + bx + c ជាចម្លើយនៃសមីការឌីផេរ៉ង់ស្យែល y'' + 2y = x^2。', 'multiple_choice', 'medium', 'g(x) = 1/2 x^2 - 1/2 x + 1/4', 'គណនាដេរីវេ g''(x) ជំនួសចូលសមីការឌីផេរ៉ង់ស្យែលហើយផ្ទឹមមេគុណរក a, b, c。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 28;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (28, 'g(x) = 1/2 x^2 + 1/2 x + 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (28, 'g(x) = 1/2 x^2 - 1/2 x - 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (28, 'g(x) = 1/2 x^2 - 1/2 x + 1/4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (28, 'g(x) = x^2 - x + 1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (29, 6, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែលស្વાયយូសែន (E''): y'' + 2y = 0。', 'multiple_choice', 'easy', 'y = A e^(-2x)', 'សមីការឌីផេរ៉ង់ស្យែលលំដាប់ទី១ មានចម្លើយទូទៅ y = A e^(-ax)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 29;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (29, 'y = A e^(-2x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (29, 'y = A e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (29, 'y = A e^(-x/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (29, 'y = e^(-2x) + A', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (30, 7, 'secondary', 'Mathematics', 'ទាញរកចម្លើយទូទៅនៃសមីការឌីផេរ៉ង់ស្យែល (E): y'' + 2y = x^2 ដោយផ្អែកលើចម្លើយពិសេស g និងចម្លើយសមីការអូម៉ូសែន。', 'multiple_choice', 'medium', 'f = A e^(-2x) + 1/2 x^2 - 1/2 x + 1/4', 'ចម្លើយទូទៅ f គឺផលបូករវាងចម្លើយទូទៅអូម៉ូសែន និងចម្លើយពិសេស g。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៤ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 30;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (30, 'f = A e^(2x) + 1/2 x^2 - 1/2 x + 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (30, 'f = A e^(-2x) + 1/2 x^2 - 1/2 x + 1/4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (30, 'f = A e^(-2x) + 1/2 x^2 + 1/2 x + 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (30, 'f = A e^(-2x) - 1/2 x^2 + 1/2 x - 1/4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (31, 1, 'secondary', 'Mathematics', 'សរសេរចំនួនកុំផ្លិច -2 - 2i ជាទម្រង់ត្រីកោណមាត្រ。', 'multiple_choice', 'easy', '2√2 (cos(5π/4) + i sin(5π/4))', 'គណនាម៉ូឌុល r = 2√2 និងអាគុយម៉ង់ θ = 5π/4 រួចសរសេរចូលទម្រង់ត្រីកោណមាត្រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 31;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (31, '2√2 (cos(3π/4) + i sin(3π/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (31, '2√2 (cos(π/4) + i sin(π/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (31, '2 (cos(5π/4) + i sin(5π/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (31, '2√2 (cos(5π/4) + i sin(5π/4))', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (32, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច (2 + i)x^2 - (5 - i)x + 2 - 2i = 0。', 'multiple_choice', 'hard', 'x = 4/5 - 2/5 i, x = 7/5 - 2/5 i', 'គណនាកើស្ត្រ Δ = -2i = (1 - i)^2 រួចរកឫសសមីការឌីសគ្រីមីណង់。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 32;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (32, 'x = 4/5 + 2/5 i, x = 7/5 + 2/5 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (32, 'x = -4/5 - 2/5 i, x = -7/5 - 2/5 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (32, 'x = 4/5 - 2/5 i, x = 7/5 - 2/5 i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (32, 'x = 2/5 - 4/5 i, x = 2/5 - 7/5 i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (33, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់ I = ∫ (2 sin x + 3 cos x) dx。', 'multiple_choice', 'easy', '-2 cos x + 3 sin x + c', 'ធ្វើអាំងតេក្រាលដាច់ដោយឡែកពីគ្នាចំពោះ sin x និង cos x。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 33;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (33, '-2 cos x + 3 sin x + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (33, '2 cos x + 3 sin x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (33, '-2 cos x - 3 sin x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (33, '2 cos x - 3 sin x + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (34, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់ J = ∫ dx / (x^2 - 5x + 6)。', 'multiple_choice', 'medium', 'ln|(x-3)/(x-2)| + c', 'បំបែកកភាគជាប្រភាគងាយ 1/(x-3) - 1/(x-2) រួចគណនាអាំងតេក្រាល。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 34;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (34, 'ln|(x-2)/(x-3)| + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (34, 'ln|(x-3)/(x-2)| + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (34, 'ln|(x-3)(x-2)| + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (34, '1/5 ln|(x-3)/(x-2)| + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (35, 3, 'secondary', 'Mathematics', 'រកព្រីមីទីវ F(x) នៃអនុគមន៍ f(x) = x^2 - e^x ដោយដឹងថា F(0) = 1。', 'multiple_choice', 'medium', 'F(x) = x^3/3 - e^x + 2', 'រកអាំងតេក្រាលទូទៅ F(x) = x^3/3 - e^x + c រួចជំនួស F(0) = 1 ដើម្បីរក c = 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - ព្រីមីទីវ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 35;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (35, 'F(x) = x^3/3 - e^x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (35, 'F(x) = x^3/3 - e^x - 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (35, 'F(x) = x^3/3 + e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (35, 'F(x) = x^3/3 - e^x + 2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (36, 4, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): y'''' - 3y'' + 2y = 0。', 'multiple_choice', 'easy', 'y = A e^x + B e^(2x)', 'សមីការសម្គាល់ λ^2 - 3λ + 2 = 0 មានឫស λ = 1 និង λ = 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 36;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (36, 'y = A e^(-x) + B e^(-2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (36, 'y = (Ax + B)e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (36, 'y = A e^x + B e^(2x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (36, 'y = A e^(3x) + B e^(2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (37, 5, 'secondary', 'Mathematics', 'សរសេរសមីការប្លង់ (P) កាត់តាម M(1, 2, -3) និងស្របនឹងប្លង់ (Q): 2x - 4y - z + 4 = 0。', 'multiple_choice', 'medium', '2x - 4y - z + 3 = 0', 'ប្លង់ (P) មានវ៉ិចទ័រណរម៉ាល់ដូច (Q) រួចជំនួយកូអរដោនេចំណុច M ទៅក្នុងសមីការ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - ប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 37;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (37, '2x - 4y - z + 3 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (37, '2x - 4y - z - 3 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (37, '2x - 4y - z + 9 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (37, '2x + 4y - z + 3 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (38, 5, 'secondary', 'Mathematics', 'គណនាចម្ងាយរវាងប្លង់ (P): 2x - 4y - z + 3 = 0 និងប្លង់ (Q): 2x - 4y - z + 4 = 0。', 'multiple_choice', 'medium', '√21 / 21 ឯកតាប្រវែង', 'ប្រើរូបមន្តចម្ងាយរវាងប្លង់ស្របគ្នា d = |d1 - d2| / √(a^2 + b^2 + c^2)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - ចម្ងាយក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 38;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (38, '7√21 / 21 ឯកតាប្រវែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (38, '√21 / 21 ឯកតាប្រវែង', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (38, '1 / 21 ឯកតាប្រវែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (38, '√21 ឯកតាប្រវែង', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (39, 6, 'secondary', 'Mathematics', 'តើគេអាចបង្កើតចំនួនប៉ុន្មានពីតួលេខ 0, 1, 2, 3, 4 ដែលធំជាង 2000 (ដោយគ្មានតួលេខជាន់គ្នា)?', 'multiple_choice', 'hard', '168 ចំនួន', 'បែងចែកជាករណីចំនួន ៤ខ្ទង់ និង ៥ខ្ទង់ ដែលធំជាង 2000 រួចបូកបញ្ចូលគ្នា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - វិភាគបន្សំ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 39;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (39, '72 ចំនួន', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (39, '96 ចំនួន', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (39, '192 ចំនួន', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (39, '168 ចំនួន', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (40, 7, 'secondary', 'Mathematics', 'កំណត់តម្លៃ a និង b ដើម្បីឱ្យខ្សែកោង f(x) = a e^x + b កាត់គល់អ័ក្ស និងមានបន្ទាត់ប៉ះត្រង់នោះជា y = x。', 'multiple_choice', 'medium', 'a = 1, b = -1', 'ប្រើលក្ខខណ្ឌ f(0) = 0 និង f''(0) = 1 ដើម្បីបង្កើតប្រព័ន្ធសមីការរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៥ - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 40;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (40, 'a = 1, b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (40, 'a = 1, b = -1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (40, 'a = -1, b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (40, 'a = 1, b = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (41, 1, 'secondary', 'Mathematics', 'ដោះស្រាយវិសមីការ 2^x + 2^(3-x) ≤ 9。', 'multiple_choice', 'medium', '0 ≤ x ≤ 3', 'តាង t = 2^x (t > 0) បម្លែងវិសមីការទៅជាពុធាដឺក្រេទី២ រួចទាញរកចន្លោះតម្លៃរបស់ x。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - សមីការនិងវិសមីការអិចស្ប៉ូណង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 41;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (41, '0 ≤ x ≤ 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (41, '1 ≤ x ≤ 8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (41, '0 < x < 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (41, 'x ≤ 0 ឬ x ≥ 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (42, 1, 'secondary', 'Mathematics', 'ស្រាយបញ្ជាក់ថាចំពោះគ្រប់តម្លៃ x, y គេបាន x^2(1 + sin^2 y) + 2x(sin y + cos y) + 1 + cos^2 y > 0。', 'multiple_choice', 'hard', 'វិសមីការផ្ទៀងផ្ទាត់គ្រប់ x, y', 'គណនាដេលតា Δ'' = -(1 - sin y cos y)^2 < 0 និងមេគុណ a > 0 ដូចនេះកន្សោមវិជ្ជមានជានិច្ច。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - ត្រីធាដឺក្រេទីពីរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 42;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (42, 'វិសមីការផ្ទៀងផ្ទាត់លុះត្រាតែ x > 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (42, 'វិសមីការគ្មានចម្លើយចំពោះគ្រប់ x, y', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (42, 'វិសមីការផ្ទៀងផ្ទាត់គ្រប់ x, y', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (42, 'វិសមីការផ្ទៀងផ្ទាត់លុះត្រាតែ y ≠ kπ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (43, 2, 'secondary', 'Mathematics', 'កំណត់តម្លៃ m ដើម្បីឱ្យសមីការ (m + 1)x^2 - 2mx + 4(m + 1) = 0 មានឫសដែលធំជាងគេនៅចន្លោះ (-1, 1)。', 'multiple_choice', 'hard', 'm ∈ (-5/3, -5/7)', 'ប្រើលក្ខខណ្ឌ f(-1) × f(1) < 0 ដើម្បីកំណត់ចន្លោះតម្លៃ m。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - សមីការដឺក្រេទីពីរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 43;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (43, 'm ∈ [-5/3, -5/7]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (43, 'm ∈ (-7/5, -3/5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (43, 'm ∈ (5/7, 5/3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (43, 'm ∈ (-5/3, -5/7)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (44, 3, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): 2y'''' - 3y'' + y = 0。', 'multiple_choice', 'easy', 'g(x) = A e^x + B e^(1/2 x)', 'សមីការសម្គាល់ 2λ^2 - 3λ + 1 = 0 មានឫស λ = 1 និង λ = 1/2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 44;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (44, 'g(x) = A e^(-x) + B e^(-1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (44, 'g(x) = A e^x + B e^(1/2 x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (44, 'g(x) = A e^(2x) + B e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (44, 'g(x) = (Ax + B) e^x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (45, 3, 'secondary', 'Mathematics', 'កំណត់ចម្លើយ g(x) មួយរបស់សមីការឌីផេរ៉ង់ស្យែលដើម្បីឱ្យក្រាបប៉ះបន្ទាត់ y = -1/2 x ត្រង់ O(0,0)。', 'multiple_choice', 'medium', 'g(x) = -e^x + e^(1/2 x)', 'ប្រើលក្ខខណ្ឌ g(0) = 0 និង g''(0) = -1/2 ដើម្បីរកតម្លៃថេរ A និង B。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 45;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (45, 'g(x) = e^x - e^(1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (45, 'g(x) = -2e^x + 2e^(1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (45, 'g(x) = -e^x + e^(1/2 x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (45, 'g(x) = e^x + e^(1/2 x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (46, 4, 'secondary', 'Mathematics', 'កោណមួយមានកម្ពស់ 15cm និងកាំបាត 6cm។ រកកម្ពស់ និងកាំបាតនៃស៊ីឡាំងចារឹកក្នុងកោណដើម្បីឱ្យមាឌអតិបរមា。', 'multiple_choice', 'hard', 'r = 4 cm, h = 5 cm', 'បង្កើតអនុគមន៍មាឌស៊ីឡាំងតាមរស្មី r រួចរកដេរីវេទីមួយដើម្បីស្វែងរកតម្លៃអតិបរមា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - ធរណីមាត្រក្នុងលំហនិងអតិបរមា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 46;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (46, 'r = 4 cm, h = 5 cm', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (46, 'r = 5 cm, h = 4 cm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (46, 'r = 3 cm, h = 7.5 cm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (46, 'r = 2 cm, h = 10 cm', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (47, 5, 'secondary', 'Mathematics', 'រកសមីការស្ែរកាត់តាមបួនចំណុច A(1,1,0), B(0,2,2), C(1,-2,3) និង D(1,-2,0)。', 'multiple_choice', 'hard', '(x + 1/2)^2 + (y + 1/2)^2 + (z - 3/2)^2 = 27/4', 'តាងសមីការស្ែររាងស្តង់ដា ជំនួសកូអរដោនេចំណុចទាំងបួនដើម្បីបង្កើតប្រព័ន្ធសមីការរក a, b, c និង r^2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - សមីការស្ែរក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 47;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (47, '(x - 1/2)^2 + (y - 1/2)^2 + (z + 3/2)^2 = 27/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (47, '(x + 1/2)^2 + (y - 1/2)^2 + (z - 3/2)^2 = 25/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (47, '(x - 1/2)^2 + (y + 1/2)^2 + (z - 3/2)^2 = 27/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (47, '(x + 1/2)^2 + (y + 1/2)^2 + (z - 3/2)^2 = 27/4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (48, 6, 'secondary', 'Mathematics', 'រកតម្លៃ a ដើម្បីឱ្យអនុគមន៍ f(x) = (ax+1)^2 (បើ x<2) និង f(x) = -ax (បើ x≥2) ជាប់នៅត្រង់ x = 2。', 'multiple_choice', 'medium', 'a = (-3 ± √5) / 4', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌលីមីតខាងឆ្វេង ខាងស្តាំ និងតម្លៃអនុគមន៍ស្មើគ្នាត្រង់ x = 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - ភាពជាប់នៃអនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 48;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (48, 'a = (3 ± √5) / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (48, 'a = (-3 ± √5) / 4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (48, 'a = (-3 ± √5) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (48, 'a = (-3 ± √13) / 4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (49, 7, 'secondary', 'Mathematics', 'កំណត់តម្លៃ a និង b នៃអនុគមន៍ f(x) = (x^2 - 4x + 4) / ((2x - 3)(x - 1)^2) ឱ្យស្មើនឹង a/(x-1)^2 + b/(2x-3)。', 'multiple_choice', 'medium', 'a = -1, b = 1', 'បង្រួមផ្នែកខាងស្តាំដោយភាគរួម រួចផ្ទឹមមេគុណនៃពុធាភាគលាភដើម្បីរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - ប្រភាគបំបែក')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 49;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (49, 'a = 1, b = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (49, 'a = 1, b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (49, 'a = -1, b = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (49, 'a = -1, b = -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (50, 7, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាលកំណត់ I = ∫_{2}^{3} f(x) dx ដោយប្រើប្រាស់សំណួរមុន。', 'multiple_choice', 'medium', 'ln(3)/2 - 1/2', 'ជំនួសតម្លៃ a = -1 និង b = 1 ចូលទៅក្នុងកន្សោមប្រភាគបំបែក រួចគណនាអាំងតេក្រាលកំណត់ពី 2 ដល់ 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៦ - អាំងតេក្រាលកំណត់')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 50;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (50, 'ln(3)/2 - 1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (50, 'ln(3) - 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (50, 'ln(3)/2 + 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (50, '-ln(3)/2 + 1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (51, 1, 'secondary', 'Mathematics', 'កំណត់ចំនួនពិត x និង y ដើម្បីឱ្យ 2xi - y = ((3 - 2i)(1 + i)) / (i(1 + 2i))。', 'multiple_choice', 'medium', 'x = -7/10, y = 9/5', 'បង្រួមផ្នែកខាងស្តាំនៃសមីការដោយបំបាត់កភាគនិម្មិត រួចផ្ទឹមផ្នែកពិត និងផ្នែកនិម្មិត。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 51;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (51, 'x = 7/10, y = -9/5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (51, 'x = -7/5, y = 9/5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (51, 'x = -7/10, y = -9/5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (51, 'x = -7/10, y = 9/5', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (52, 1, 'secondary', 'Mathematics', 'គេឱ្យ z = cos(2π/9) + i sin(2π/9)។ សរសេរ (1 + z)^4 ជាទម្រង់ត្រីកោណមាត្រ。', 'multiple_choice', 'hard', '16 cos^4(π/9) (cos(4π/9) + i sin(4π/9))', 'ប្រើប្រាស់រូបមន្តមុំកន្លះសម្រាប់ 1 + z រួចលើកកម្លាំងបួនតាមរូបមន្តម៉្វាវ៉ា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 52;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (52, '4 cos^4(π/9) (cos(4π/9) + i sin(4π/9))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (52, '16 cos^4(π/9) (cos(4π/9) + i sin(4π/9))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (52, '16 cos^4(π/9) (cos(8π/9) + i sin(8π/9))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (52, '16 cos(π/9) (cos(4π/9) + i sin(4π/9))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (53, 2, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): g''''(x) - 5g''(x) + 6g(x) = 0。', 'multiple_choice', 'easy', 'y = A e^(2x) + B e^(3x)', 'សមីការសម្គាល់ λ^2 - 5λ + 6 = 0 មានឫស λ = 2 និង λ = 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 53;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (53, 'y = A e^(-2x) + B e^(-3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (53, 'y = A e^(-2x) + B e^(3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (53, 'y = A e^(2x) + B e^(3x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (53, 'y = (Ax + B) e^(2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (54, 2, 'secondary', 'Mathematics', 'កំណត់ចម្លើយ g(x) មួយនៃសមីការ (E) ដែល g(0) = 0 និង g''(0) = 1。', 'multiple_choice', 'medium', 'g(x) = -e^(2x) + e^(3x)', 'ប្រើលក្ខខណ្ឌអម g(0) = 0 និង g''(0) = 1 ទៅលើចម្លើយទូទៅដើម្បីរក A = -1 និង B = 1。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 54;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (54, 'g(x) = -e^(2x) + e^(3x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (54, 'g(x) = e^(2x) - e^(3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (54, 'g(x) = e^(2x) + e^(3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (54, 'g(x) = -2e^(2x) + 3e^(3x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (55, 3, 'secondary', 'Mathematics', 'គណនាលីមីតនៃ f(x) = (1 - cos 2x) / x^2 កាលណា x ខិតជិត 0。', 'multiple_choice', 'easy', '2', 'បម្លែង 1 - cos 2x = 2 sin^2(x) រួចប្រើលីមីតជំនួយ lim (sin x / x) = 1。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - លីមីត')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 55;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (55, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (55, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (55, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (55, '2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (56, 3, 'secondary', 'Mathematics', 'កំណត់តម្លៃ m ដើម្បីឱ្យ f ជាអនុគមន៍ជាប់នៅត្រង់ x = 0 (ដែល f(0) = ln(m - 1))。', 'multiple_choice', 'medium', 'm = e^2 + 1', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌលីមីតខិតជិត 0 ស្មើនឹងតម្លៃ f(0) នោះ ln(m - 1) = 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ភាពជាប់នៃអនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 56;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (56, 'm = e^2 - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (56, 'm = e^2 + 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (56, 'm = e^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (56, 'm = 2e + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (57, 4, 'secondary', 'Mathematics', 'ក្នុងថង់មានឃ្លីស 3 និងខ្មៅ 5។ ចាប់យក 3 ដើមព្រមគ្នា រកប្រូបាបបានឃ្លីស 2 និងខ្មៅ 1。', 'multiple_choice', 'medium', '15 / 56', 'ប្រើប្រាស់បន្សំ C(3,2) × C(5,1) ចែកនឹង C(8,3) ដើម្បីរកប្រូបាប。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 57;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (57, '15 / 64', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (57, '3 / 56', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (57, '15 / 56', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (57, '5 / 56', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (58, 5, 'secondary', 'Mathematics', 'រកកូអរដោនេផ្ចិត និងប្រវែងកាំនៃស្ែរ (S): x^2 + y^2 + z^2 - 2x - 4y + 4z = 0。', 'multiple_choice', 'easy', 'ផ្ចិត I(1, 2, -2), កាំ r = 3', 'จัดរៀបសមីការស្ែរជាទម្រង់ស្តង់ដា (x - 1)^2 + (y - 2)^2 + (z + 2)^2 = 3^2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - សមីការស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 58;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (58, 'ផ្ចិត I(1, 2, -2), កាំ r = 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (58, 'ផ្ចិត I(-1, -2, 2), កាំ r = 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (58, 'ផ្ចិត I(1, 2, -2), កាំ r = 9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (58, 'ផ្ចិត I(-1, -2, 2), កាំ r = 9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (59, 6, 'secondary', 'Mathematics', 'បង្ហាញថាប្លង់ (P): x + 2y + 2z + 5 = 0 កាត់ស្ែរ (S)。', 'multiple_choice', 'medium', 'ប្លង់កាត់ស្ែរ', 'គណនាចម្ងាយពីផ្ចិតស្ែរទៅប្លង់ d(I, P) = 2 < r = 3 ដូចនេះប្លង់កាត់ស្ែរ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ទំនាក់ទំនងប្លង់និងស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 59;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (59, 'ប្លង់កាត់ស្ែរ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (59, 'ប្លង់ប៉ះស្ែរ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (59, 'ប្លង់មិនកាត់ស្ែរ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (59, 'គ្មានចម្លើយ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (60, 7, 'secondary', 'Mathematics', 'រកសមីការបណ្តាប្លង់ស្របនឹងប្លង់ (P) ហើយប៉ះនឹងស្ែរ (S)。', 'multiple_choice', 'hard', 'x + 2y + 2z - 10 = 0 និង x + 2y + 2z + 8 = 0', 'តាងប្លង់ស្រប x + 2y + 2z + d = 0 រួចប្រើលក្ខខណ្ឌចម្ងាយពីផ្ចិតស្ែរស្មើនឹងកាំ r = 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៧ - ប្លង់ប៉ះស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 60;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (60, 'x + 2y + 2z + 10 = 0 និង x + 2y + 2z - 8 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (60, 'x + 2y + 2z - 10 = 0 និង x + 2y + 2z + 8 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (60, 'x + 2y + 2z - 4 = 0 និង x + 2y + 2z + 2 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (60, 'x + 2y + 2z - 9 = 0 និង x + 2y + 2z + 9 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (61, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការ (x - 1)/1991 + (x - 5)/1987 + (x + 7)/1999 + (x - 11)/1981 = 4。', 'multiple_choice', 'medium', 'x = 1992', 'ដក ១ ពីតួខណ្ឌនីមួយៗក្នុងសមីការ រួចទាញកត្តារួម (x - 1992) ដើម្បីរកតម្លៃ x。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - សមីការ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 61;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (61, 'x = 1991', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (61, 'x = -1992', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (61, 'x = 1993', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (61, 'x = 1992', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (62, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការ ln√(x^2) = √(2 ln(-x))。', 'multiple_choice', 'hard', 'x = -1, x = -e^2', 'កំណត់ដែនកំណត់ x ≤ -1 រួចបម្លែងសមីការដោយតាង t = ln(-x) เพื่อដោះស្រាយរកឫស。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - សមីការលោការីត')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 62;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (62, 'x = 1, x = e^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (62, 'x = -1, x = -e^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (62, 'x = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (62, 'x = -1, x = -e', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (63, 1, 'secondary', 'Mathematics', 'ដោះស្រាយវិសមីការ 0 < (x^2 - 2x - 3)/(x - 2) < 4。', 'multiple_choice', 'medium', 'x ∈ (-1, 1) ∪ (3, 5)', 'បែងចែកជាប្រព័ន្ធវិសមីការពីរ រួចរកចន្លោះរួមនៃចម្លើយទាំងពីរ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - វិសមីការ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 63;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (63, 'x ∈ [-1, 1] ∪ [3, 5]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (63, 'x ∈ (-1, 2) ∪ (3, 5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (63, 'x ∈ (-1, 1) ∪ (3, 5)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (63, 'x ∈ (-5, -3) ∪ (-1, 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (64, 2, 'secondary', 'Mathematics', 'កំណត់តម្លៃ A, B, C ដើម្បីឱ្យ f(x) = (5x^2 + 20x + 6) / (x^3 + 2x^2 + x) = A/x + B/(x+1) + C/(x+1)^2。', 'multiple_choice', 'medium', 'A = 6, B = -1, C = 9', 'បង្រួមផ្នែកខាងស្តាំដោយភាគរួម រួចផ្ទឹមមេគុណនៃពុធាភាគលាភដើម្បីរក A, B និង C。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - ប្រភាគបំបែក')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 64;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (64, 'A = 6, B = -1, C = 9', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (64, 'A = 6, B = 1, C = -9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (64, 'A = 6, B = 1, C = 9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (64, 'A = -6, B = 1, C = -9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (65, 2, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល F(x) = ∫ (5x^2 + 20x + 6) / (x^3 + 2x^2 + x) dx。', 'multiple_choice', 'medium', '6 ln|x| - ln|x+1| - 9/(x+1) + c', 'ជំនួសតម្លៃ A, B និង C ដែលរកបានចូលក្នុងប្រភាគបំបែក រួចគណនាអាំងតេក្រាល。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 65;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (65, '6 ln|x| - ln|x+1| + 9/(x+1) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (65, '6 ln|x| + ln|x+1| - 9/(x+1) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (65, '6 ln|x| - ln|x+1| - 9 ln|x+1| + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (65, '6 ln|x| - ln|x+1| - 9/(x+1) + c', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (66, 3, 'secondary', 'Mathematics', 'ថង់ A មានស 1 ខ្មៅ 3។ ថង់ B មានស 5 ខ្មៅ 3។ ទាញប៊ូលមួយពីថង់ A និងមួយពីថង់ B រួចប្តូរគ្នា។ រកប្រូបាបដើម្បីឱ្យថង់ A មានតែប៊ូលពណ៌ខ្មៅ。', 'multiple_choice', 'medium', '3 / 32', 'ប្រូបាបបានប៊ូលសពីថង់ A គុណនឹងប្រូបាបបានប៊ូលខ្មៅពីថង់ B คือ (1/4) × (3/8) = 3/32。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 66;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (66, '5 / 32', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (66, '3 / 32', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (66, '5 / 8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (66, '3 / 16', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (67, 4, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): y'''' + 4y'' + 4y = 0。', 'multiple_choice', 'easy', 'y = (Ax + B)e^(-2x)', 'សមីការសម្គាល់មានឫសឌុប λ = -2 ដូចនេះចម្លើយទូទៅគឺ y = (Ax + B)e^(-2x)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 67;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (67, 'y = (Ax + B)e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (67, 'y = A e^(-2x) + B e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (67, 'y = (Ax + B)e^(-2x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (67, 'y = A e^(-2x) + B', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (68, 5, 'secondary', 'Mathematics', 'ក្នុងលំហ គេមាន A(-2,0,1), B(0,10,3), C(2,0,-1) និង D(5,3,-1)។ សរសេរសមីការប្លង់ (P) កាត់តាម A, B និង C。', 'multiple_choice', 'medium', '5x - 3y + 10z = 0', 'រកវ៉ិចទ័រណរម៉ាល់ n = AB × AC = (-20, 12, -40) ឬ (5, -3, 10) រួចសរសេរសមីការប្លង់。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - ប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 68;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (68, '5x - 3y + 10z = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (68, '5x + 3y + 10z = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (68, '5x - 3y - 10z = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (68, '5x - 3y + 10z - 10 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (69, 5, 'secondary', 'Mathematics', 'សរសេរសមីការស្ែរផ្ចិត D(5,3,-1) ហើយប៉ះនឹងប្លង់ (P): 5x - 3y + 10z = 0。', 'multiple_choice', 'medium', '(x - 5)^2 + (y - 3)^2 + (z + 1)^2 = 18/67', 'កាំ R ស្មើនឹងចម្ងាយពីផ្ចិត D ទៅប្លង់ (P) រួចជំនួសចូលសមីការស្ែរ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - សមីការស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 69;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (69, '(x + 5)^2 + (y + 3)^2 + (z - 1)^2 = 18/67', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (69, '(x - 5)^2 + (y - 3)^2 + (z + 1)^2 = 6/√134', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (69, '(x - 5)^2 + (y - 3)^2 + (z + 1)^2 = 36/67', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (69, '(x - 5)^2 + (y - 3)^2 + (z + 1)^2 = 18/67', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (70, 6, 'secondary', 'Mathematics', 'រកចំនួនពិត a និង b ដើម្បីឱ្យ F(x) = a cos x + b cos^3 x ជាព្រីមីទីវនៃ f(x) = 3 sin x - 2 sin^3 x。', 'multiple_choice', 'medium', 'a = -1, b = -2/3', 'ធ្វើដេរីវេ F''(x) រួចផ្ទឹមមេគុណជាមួយ f(x) ដើម្បីរកតម្លៃ a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៨ - ព្រីមីទីវ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 70;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (70, 'a = 1, b = 2/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (70, 'a = -1, b = -2/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (70, 'a = -1, b = 2/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (70, 'a = 1, b = -2/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (71, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច z^2 - (5 - i)z + 8 - i = 0。', 'multiple_choice', 'medium', 'z = 2 + i, z = 3 - 2i', 'គណនាកើស្ត្រ Δ = -8 - 6i = (3i - 1)^2 រួចរកឫសសមីការកុំផ្លិច。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 71;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (71, 'z = 2 - i, z = 3 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (71, 'z = -2 + i, z = -3 - 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (71, 'z = 2 + i, z = 3 - 2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (71, 'z = 3 + i, z = 2 - 2i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (72, 1, 'secondary', 'Mathematics', 'គេឱ្យ f(x) = 29x^2 + 6x + 2010 (a>0, b>0)។ ស្រាយបញ្ជាក់ថា f((a+b)/(1+a+b)) < f(a/(1+a) + b/(1+b))。', 'multiple_choice', 'hard', 'វិសមីការផ្ទៀងផ្ទាត់', 'បង្ហាញថា f ជាអនុគមន៍កើនលើចន្លោះ (0, +∞) និងប្រៀបធៀបតម្លៃអាប់ស៊ីស。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 72;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (72, 'វិសមីការផ្ទៀងផ្ទាត់', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (72, 'វិសមីការមិនផ្ទៀងផ្ទាត់', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (72, 'ផ្ទៀងផ្ទាត់តែពេល a = b', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (72, 'មិនអាចសន្និដ្ឋានបាន', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (73, 2, 'secondary', 'Mathematics', 'ត្រីកោណកែងមានអីប៉ូតេនុស 5dm។ កំណត់ប្រវែងជ្រុងជាប់មុំកែង ដើម្បីឱ្យផ្ទៃក្រឡាមានតម្លៃអតិបរមា。', 'multiple_choice', 'medium', 'x = y = 5√2 / 2 dm', 'តាង x និង y ជាជ្រុងជាប់មុំកែង រួចបង្កើតអនុគមន៍ផ្ទៃក្រឡា S(x) ដើម្បីរកតម្លៃអតិបរមា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - អតិបរមានិងអប្បបរមា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 73;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (73, 'x = y = 5√2 / 2 dm', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (73, 'x = y = 5/2 dm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (73, 'x = 3 dm, y = 4 dm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (73, 'x = y = 5√2 dm', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (74, 3, 'secondary', 'Mathematics', 'កំណត់ចំនួនថេរ a និង b ដើម្បីឱ្យ 1/(x(x+1)(x+2)) = a/(x(x+1)) + b/((x+1)(x+2))。', 'multiple_choice', 'easy', 'a = 1/2, b = -1/2', 'បង្រួមផ្នែកខាងស្តាំដោយភាគរួម រួចផ្ទឹមមេគុណនៃពុធាភាគលាភដើម្បីរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ប្រភាគបំបែក')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 74;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (74, 'a = -1/2, b = 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (74, 'a = 1/2, b = 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (74, 'a = 1, b = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (74, 'a = 1/2, b = -1/2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (75, 3, 'secondary', 'Mathematics', 'គណនាផលបូក S = 1/(1⋅2⋅3) + 1/(2⋅3⋅4) + ... + 1/(n(n+1)(n+2))。', 'multiple_choice', 'medium', '1/2 (1/2 - 1/((n+1)(n+2)))', 'ប្រើប្រាស់លទ្ធផលប្រភាគបំបែកពីសំណួរមុនដើម្បីដកតួសម្រួលចោល (Telescoping sum)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ផលបូកស្វ៊ីត')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 75;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (75, '1/2 - 1/((n+1)(n+2))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (75, '1/2 (1/2 - 1/((n+1)(n+2)))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (75, '1/2 (1/2 + 1/((n+1)(n+2)))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (75, '1/2 (1 - 1/(n(n+1)))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (76, 4, 'secondary', 'Mathematics', 'ក្នុងថង់មានប៊ូលក្រហម 3 ខ្មៅ 3 និងស 3។ ចាប់យក 3 ដើមម្តងមួយៗដោយមិនដាក់វិញ។ រកប្រូបាបបានពណ៌ដូចគ្នា。', 'multiple_choice', 'medium', '1 / 28', 'គណនាប្រូបាបករណីបានក្រហមទាំងអស់ ឬខ្មៅទាំងអស់ ឬសទាំងអស់ រួចបូកបញ្ចូលគ្នា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 76;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (76, '1 / 84', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (76, '3 / 28', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (76, '1 / 28', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (76, '1 / 9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (77, 5, 'secondary', 'Mathematics', 'បង្ហាញថាបីចំណុច A(1,4,3), B(2,11,4) និង C(-3,-5,4) មិននៅលើបន្ទាត់តែមួយ。', 'multiple_choice', 'easy', 'ចំណុចទាំងបីមិននៅលើបន្ទាត់តែមួយ', 'គណនាផលគុណវ៉ិចទ័រ AB × AC ≠ 0 ដូចនេះចំណុចទាំងបីមិន collinear គ្នា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 77;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (77, 'ចំណុចទាំងបីមិននៅលើបន្ទាត់តែមួយ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (77, 'ចំណុចទាំងបីនៅលើបន្ទាត់តែមួយ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (77, 'ចំណុច A និង B ត្រួតស៊ីគ្នា', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (77, 'ចំណុចទាំងបីជាកំពូលនៃបន្ទាត់ស្រប', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (78, 5, 'secondary', 'Mathematics', 'សរសេរសមីការប្លង់ (P) កាត់តាមចំណុច A, B និង C。', 'multiple_choice', 'medium', '16x - 5y + 19z - 53 = 0', 'រកវ៉ិចទ័រណរម៉ាល់ n = AB × AC = (16, -5, 19) រួចសរសេរសមីការប្លង់កាត់តាម A。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 78;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (78, '16x - 5y + 19z - 53 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (78, '16x + 5y + 19z - 53 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (78, '16x - 5y - 19z - 53 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (78, '16x - 5y + 19z + 53 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (79, 6, 'secondary', 'Mathematics', 'កំណត់តម្លៃ a និង b ដើម្បីឱ្យ f(x) = ln(ax + b) កាត់អ័ក្សអាប់ស៊ីសត្រង់ x = -1 និងកាត់អ័ក្សអរដោនេត្រង់ y = ln 2。', 'multiple_choice', 'medium', 'a = 1, b = 2', 'ប្រើប្រាស់លក្ខខណ្ឌ f(-1) = 0 និង f(0) = ln 2 ដើម្បីបង្កើតប្រព័ន្ធសមីការរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - លោការីត')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 79;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (79, 'a = 2, b = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (79, 'a = -1, b = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (79, 'a = 1, b = 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (79, 'a = 2, b = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (80, 7, 'secondary', 'Mathematics', 'គណនាផ្ទៃក្រឡាផ្នែកប្លង់ខណ្ឌដោយខ្សែកោង f(x) = ln(x + 2) អ័ក្សអាប់ស៊ីស និងបន្ទាត់ x = -3/2 និង x = 0。', 'multiple_choice', 'hard', '(3 ln 2 - 1) / 2 ឯកតាផ្ទៃ', 'ប្រើប្រាស់អាំងតេក្រាលដោយផ្នែកเพื่อរកព្រីមីទីវនៃ ln(x + 2) រួចគណនាផ្ទៃក្រឡាកំណត់。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០០៩ - ផ្ទៃក្រឡា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 80;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (80, '(3 ln 2 - 1) / 2 ឯកតាផ្ទៃ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (80, '(5 ln 2 - 3) / 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (80, '(3 ln 2 + 1) / 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (80, '(2 ln 2 - 1) ឯកតាផ្ទៃ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (81, 1, 'secondary', 'Mathematics', 'បង្ហាញថា sin^2 α - 2(1 + cos α) = -4 cos^4 (α/2)。', 'multiple_choice', 'medium', '-4 cos^4 (α/2)', 'ប្រើប្រាស់រូបមន្តត្រីកោណមាត្រនៃមុំកន្លះ និងបំប្លែងកន្សោមដើម្បីសម្រួល。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - ត្រីកោណមាត្រ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 81;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (81, '4 cos^4 (α/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (81, '-4 sin^4 (α/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (81, '-2 cos^4 (α/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (81, '-4 cos^4 (α/2)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (82, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច Z^2 - 2Z sin α + 2(1 + cos α) = 0。', 'multiple_choice', 'hard', 'Z = sin α ± 2i cos^2(α/2)', 'គណនាកើស្ត្រ Δ'' = sin^2 α - 2(1 + cos α) = -4 cos^4(α/2) រួចរកឫសសមីការ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 82;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (82, 'Z = sin α ± 2i cos(α/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (82, 'Z = sin α ± 2i cos^2(α/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (82, 'Z = sin α ± 2 cos^2(α/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (82, 'Z = -sin α ± 2i cos^2(α/2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (83, 2, 'secondary', 'Mathematics', 'ចតុកោណកែងមានផ្ទៃក្រឡា 2500 m^2។ រកប្រវែងជ្រុងដើម្បីឱ្យវាមានបរិមាត្រតូចបំផុត。', 'multiple_choice', 'medium', 'ប្រវែងបណ្តោយ = ប្រវែងទទឹង = 50 m', 'តាង x និង y ជាបណ្តោយនិងទទឹង រួចសិក្សាអនុគមន៍បរិមាត្រ P(x) ដើម្បីរកតម្លៃតូចបំផុត。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - អតិបរមានិងអប្បបរមា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 83;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (83, 'ប្រវែងបណ្តោយ = 100 m, ប្រវែងទទឹង = 25 m', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (83, 'ប្រវែងបណ្តោយ = ប្រវែងទទឹង = 25 m', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (83, 'ប្រវែងបណ្តោយ = ប្រវែងទទឹង = 50 m', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (83, 'ប្រវែងបណ្តោយ = 125 m, ប្រវែងទទឹង = 20 m', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (84, 3, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): y'''' - y = 0。', 'multiple_choice', 'easy', 'y = A e^(-x) + B e^x', 'សមីការសម្គាល់ λ^2 - 1 = 0 មានឫស λ = ±1。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 84;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (84, 'y = A e^(-x) + B e^x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (84, 'y = A cos x + B sin x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (84, 'y = (Ax + B) e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (84, 'y = A e^(-2x) + B e^(2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (85, 3, 'secondary', 'Mathematics', 'កំណត់ចម្លើយនៃសមីការ (E) ដឹងថាក្រាបកាត់អ័ក្សអរដោនេត្រង់ y = 4 ហើយបន្ទាត់ប៉ះត្រង់នោះស្របនឹង y = 2x - 4。', 'multiple_choice', 'medium', 'y = e^(-x) + 3e^x', 'ប្រើលក្ខខណ្ឌ y(0) = 4 និង y''(0) = 2 ដើម្បីរកតម្លៃ A = 1 និង B = 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 85;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (85, 'y = 3e^(-x) + e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (85, 'y = 3e^(-x) - e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (85, 'y = 4e^(-x) + 2e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (85, 'y = e^(-x) + 3e^x', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (86, 4, 'secondary', 'Mathematics', 'ទាញយកអក្សរបួនពីពាក្យ STATISTIQUE តាមលំដាប់ SITE ដោយមិនដាក់វិញ。', 'multiple_choice', 'medium', '1 / 660', 'គណនាប្រូបាបនៃការចាប់បានអក្សរ S, I, T, E ម្ដងមួយៗដោយមិនដាក់វិញ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 86;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (86, '1 / 330', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (86, '1 / 660', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (86, '1 / 7920', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (86, '1 / 1320', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (87, 5, 'secondary', 'Mathematics', 'ក្នុងលំហមាន A(6,4,-2), B(6,2,0), C(4,2,-2)។ បង្ហាញថា ABC ជាត្រីកោណសម័ង្ស。', 'multiple_choice', 'easy', 'ត្រីកោណសម័ង្ស', 'គណនាម៉ូឌុលវ៉ិចទ័រ AB, AC, BC ឃើញថាមានប្រវែងស្មើគ្នា 2√2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 87;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (87, 'ត្រីកោណសម័ង្ស', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (87, 'ត្រីកោណកែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (87, 'ត្រីកោណសមបាត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (87, 'ត្រីកោណកែងសមបាត', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (88, 5, 'secondary', 'Mathematics', 'គេឱ្យ S(3,y,z)។ គណនាតម្លៃ y និង z ដើម្បីឱ្យ SABC ជាពីរ៉ាមីតនិយ័តមានកំពូល S。', 'multiple_choice', 'hard', 'y = 5, z = 1', 'ប្រើលក្ខខណ្ឌប្រវែងគែម SA = SB = SC ដើម្បីបង្កើតប្រព័ន្ធសមីការរក y និង z。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - ពីរ៉ាមីតក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 88;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (88, 'y = -5, z = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (88, 'y = 1, z = 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (88, 'y = 5, z = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (88, 'y = 5, z = -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (89, 6, 'secondary', 'Mathematics', 'បង្ហាញថាអនុគមន៍ f(x) = 5^x / (5^(2x) - 1) ជាអនុគមន៍សេស。', 'multiple_choice', 'easy', 'អនុគមន៍សេស', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌ f(-x) = -f(x)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 89;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (89, 'អនុគមន៍សេស', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (89, 'អនុគមន៍គូ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (89, 'អនុគមន៍មិនគូមិនសេស', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (89, 'អនុគមន៍ខួប', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (90, 7, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការ f(x) = 2/3 (ដែល f(x) = 5^x / (5^(2x) - 1))。', 'multiple_choice', 'medium', 'x = log_5(2)', 'បំប្លែងសមីការទៅជាសមីការដឺក្រេទីពីរធៀបនឹង t = 5^x រួចទាញរក x。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១០ - សមីការអិចស្ប៉ូណង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 90;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (90, 'x = log_5(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (90, 'x = log_5(2) ឬ x = log_5(-1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (90, 'x = log_2(5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (90, 'x = -log_5(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (91, 1, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច (2 + i)x^2 - (5 - i)x + 2 - 2i = 0。', 'multiple_choice', 'hard', 'x = 1 - i, x = 4/5 - 2/5 i', 'គណនាកើស្ត្រ Δ = -2i = (1 - i)^2 រួចរកឫសសមីការកុំផ្លិច。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 91;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (91, 'x = 1 + i, x = 4/5 + 2/5 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (91, 'x = 1 - i, x = 4/5 + 2/5 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (91, 'x = -1 + i, x = -4/5 + 2/5 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (91, 'x = 1 - i, x = 4/5 - 2/5 i', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (92, 1, 'secondary', 'Mathematics', 'កំណត់ចំនួនកុំផ្លិច z ដែល z, 1/z និង 1 - z មានម៉ូឌុលស្មើគ្នា。', 'multiple_choice', 'hard', 'z = 1/2 ± √3 / 2 i', 'តាង z = a + bi ប្រើលក្ខខណ្ឌម៉ូឌុលស្មើគ្នា |z| = 1/|z| = |1 - z| ដើម្បីរក a និង b。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 92;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (92, 'z = -1/2 ± √3 / 2 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (92, 'z = 1/2 ± √3 / 2 i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (92, 'z = √3 / 2 ± 1/2 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (92, 'z = 1 ± √3 i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (93, 2, 'secondary', 'Mathematics', 'រកដែនកំណត់ និងបង្ហាញថា f(x) = ln(x + √(1 + x^2)) ជាអនុគមន៍សេស និងកើន。', 'multiple_choice', 'medium', 'D = ℝ, ជាអនុគមន៍សេសនិងកើនជានិច្ច', 'ផ្ទៀងផ្ទាត់ f(-x) = -f(x) និងដេរីវេ f''(x) = 1/√(1 + x^2) > 0。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 93;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (93, 'D = (0, +∞), ជាអនុគមន៍គូនិងកើន', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (93, 'D = ℝ, ជាអនុគមន៍គូនិងចុះ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (93, 'D = ℝ, ជាអនុគមន៍សេសនិងកើនជានិច្ច', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (93, 'D = ℝ, ជាអនុគមន៍សេសនិងចុះជានិច្ច', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (94, 3, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល I = ∫_{-2}^{2} (4 - x^2)(2 + x)^n dx。', 'multiple_choice', 'hard', '4^(n+3) / ((n+2)(n+3))', 'បំប្លែងកន្សោមក្រោមសញ្ញាអាំងតេក្រាលជា (2 - x)(2 + x)^(n+1) រួចគណនា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 94;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (94, '4^(n+3) / ((n+2)(n+3))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (94, '4^(n+2) / ((n+2)(n+3))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (94, '4^(n+3) / ((n+1)(n+2))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (94, '4^(n+3) / (n(n+1))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (95, 3, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល J = ∫_{6}^{8} x / (x^2 - 6x + 8) dx。', 'multiple_choice', 'medium', '3 ln 2 - ln 3', 'បំបែកប្រភាគដោយបន្ថែមនិងដកពុធា រួចប្រើលោការីតដើម្បីគណនា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 95;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (95, '3 ln 2 + ln 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (95, '3 ln 2 - ln 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (95, '5 ln 2 - ln 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (95, '2 ln 2 - ln 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (96, 4, 'secondary', 'Mathematics', 'ថង់ A(ស30), B(ខ្មៅ40), C(ស10,ក្រហម25), D(ស5,ខៀវ3,ក្រហម2)។ យកចៃដន្យមួយថង់រួចយកប៊ូលស។ រកប្រូបាប。', 'multiple_choice', 'medium', '25 / 56', 'ប្រើប្រាស់ប្រូបាបសរុប P = P(Aស) + P(Cស) + P(Dស)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 96;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (96, '9 / 23', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (96, '25 / 42', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (96, '23 / 56', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (96, '25 / 56', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (97, 5, 'secondary', 'Mathematics', 'បន្ទាត់ (Δ): x = t, y = -3+3t, z = -2+2t។ រកកូអរដោនេប្រសព្វរវាងប្លង់ (P) (កាត់តាម (Δ) និង A(1,2,1)) នឹងអ័ក្ស z''oz。', 'multiple_choice', 'hard', '(0, 0, -1/2)', 'រកវ៉ិចទ័រណរម៉ាល់ប្លង់ n = u × AB សរសេរសមីការប្លង់ រួចរកចំណុចប្រសព្វនឹងអ័ក្ស z''oz。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 97;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (97, '(0, 0, 1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (97, '(0, 0, -1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (97, '(0, 0, -1/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (97, '(0, 0, -2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (98, 6, 'secondary', 'Mathematics', 'សិក្សាអថេរភាព និងសង់ខ្សែកោង y = (x^2 - 3x + 1) / (x - 2)。', 'multiple_choice', 'medium', 'មានអាស៊ីមតូតឈរ x = 2 និងទ្រេត y = x - 1', 'រកដែនកំណត់ លីមីត អាស៊ីមតូត និងដេរីវេเพื่อសិក្សាអថេរភាព。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - អនុគមន៍សនិទាន')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 98;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (98, 'មានអាស៊ីមតូតឈរ x = 2 និងទ្រេត y = x - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (98, 'មានអាស៊ីមតូតឈរ x = 2 និងទ្រេត y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (98, 'មានអាស៊ីមតូតឈរ x = -2 និងទ្រេត y = x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (98, 'មានអាស៊ីមតូតឈរ x = 2 និងដេក y = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (99, 6, 'secondary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ប៉ះខ្សែកោង y = (x^2 - 3x + 1) / (x - 2) ដែលមានមេគុណប្រាប់ទិសស្មើ 2。', 'multiple_choice', 'medium', 'y = 2x - 1 និង y = 2x - 5', 'ដោះស្រាយសមីការ f''(x) = 2 ដើម្បីរកអាប់ស៊ីសចំណុចប៉ះ x = 1 និង x = 3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - បន្ទាត់ប៉ះ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 99;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (99, 'y = 2x + 1 និង y = 2x + 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (99, 'y = 2x - 1 និង y = 2x - 5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (99, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (99, 'y = 2x - 3 និង y = 2x - 7', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (100, 7, 'secondary', 'Mathematics', 'គណនាផ្ទៃក្រឡា S ខណ្ឌដោយខ្សែកោង y = (x^2 - 3x + 1)/(x - 2), អ័ក្សអាប់ស៊ីស និងបន្ទាត់ x = 3, x = 4。', 'multiple_choice', 'medium', '5/2 - ln 2 ឯកតាផ្ទៃ', 'គណនាអាំងតេក្រាលកំណត់ពី 3 ដល់ 4 នៃអនុគមន៍ f(x) = x - 1 - 1/(x - 2)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១១ - ផ្ទៃក្រឡា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 100;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (100, '5/2 + ln 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (100, '9/2 - ln 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (100, '3/2 - ln 2 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (100, '5/2 - ln 2 ឯកតាផ្ទៃ', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (101, 1, 'secondary', 'Mathematics', 'គណនាកន្សោម A = 1 + z1 + z1^2 ដោយដឹងថា z1 = -1/2 + i(√3/2)。', 'multiple_choice', 'easy', '0', 'ជំនួសតម្លៃ z1 និងគណនា z1^2 = -1/2 - i(√3/2) រួចបូកបញ្ចូលគ្នាទទួលបាន 0。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 101;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (101, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (101, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (101, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (101, 'i√3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (102, 1, 'secondary', 'Mathematics', 'សរសេរ z1 និង z2 ជាទម្រង់ត្រីកោណមាត្រ រួចគណនា z1^2010 + z2^2010。', 'multiple_choice', 'medium', '2', 'បំប្លែង z1 និង z2 ជាទម្រង់ត្រីកោណមាត្រ រួចប្រើរូបមន្តម៉្វាវ៉ាដើម្បីគណនាកម្លាំងទី ២០១០。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 102;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (102, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (102, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (102, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (102, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (103, 2, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល (E): 2y'''' - 3y'' + y = 0。', 'multiple_choice', 'easy', 'y = A e^x + B e^(1/2 x)', 'សមីការសម្គាល់ 2λ^2 - 3λ + 1 = 0 មានឫស λ = 1 និង λ = 1/2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 103;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (103, 'y = A e^(-x) + B e^(-1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (103, 'y = A e^x + B e^(1/2 x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (103, 'y = A e^x + B e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (103, 'y = (Ax + B) e^(1/2 x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (104, 2, 'secondary', 'Mathematics', 'រកចម្លើយមួយនៃសមីការ (E) ដឹងថាក្រាបប៉ះបន្ទាត់ y = 2x + 1 ត្រង់ចំណុច A(0, 1)。', 'multiple_choice', 'medium', 'y = 3e^x - 2e^(1/2 x)', 'ប្រើលក្ខខណ្ឌ y(0) = 1 និង y''(0) = 2 ដើម្បីរកតម្លៃ A = 3 និង B = -2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 104;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (104, 'y = -2e^x + 3e^(1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (104, 'y = 3e^x + 2e^(1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (104, 'y = 2e^x - e^(1/2 x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (104, 'y = 3e^x - 2e^(1/2 x)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (105, 3, 'secondary', 'Mathematics', 'រក A, B និង C ដើម្បីឱ្យ f(x) = (5x^2 - 14x + 13) / ((x + 1)(x - 3)^2) = A/(x+1) + B/(x-3) + C/(x-3)^2。', 'multiple_choice', 'medium', 'A = 2, B = 3, C = 4', 'បង្រួមផ្នែកស្តាំដោយភាគរួម រួចផ្ទឹមមេគុណនៃពុធាភាគលាភដើម្បីរក A, B និង C。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - ប្រភាគបំបែក')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 105;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (105, 'A = 3, B = 2, C = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (105, 'A = 2, B = -3, C = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (105, 'A = 2, B = 3, C = 4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (105, 'A = 2, B = 3, C = -4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (106, 3, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល I = ∫ f(x) dx ដោយប្រើប្រាស់តម្លៃ A, B និង C ដែលបានរកឃើញ。', 'multiple_choice', 'medium', '2 ln|x + 1| + 3 ln|x - 3| - 4/(x - 3) + c', 'ជំនួសតម្លៃ A, B និង C ចូលទៅក្នុងប្រភាគបំបែក រួចគណនាអាំងតេក្រាល。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 106;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (106, '2 ln|x + 1| + 3 ln|x - 3| - 4/(x - 3) + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (106, '2 ln|x + 1| + 3 ln|x - 3| + 4/(x - 3) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (106, '2 ln|x + 1| - 3 ln|x - 3| - 4/(x - 3) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (106, '2 ln|x + 1| + 3 ln|x - 3| - 2/(x - 3)^2 + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (107, 4, 'secondary', 'Mathematics', 'បោះគ្រាប់ឡុកឡាក់ពីរ (ខៀវ និងក្រហម) ព្រមគ្នា។ រកប្រូបាបដែលលេខខៀវស្មើពីរដងនៃលេខក្រហម。', 'multiple_choice', 'easy', '1 / 12', 'ករណីស្របគឺ (2,1), (4,2), (6,3) ចែកនឹងករណីសរុប 36。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 107;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (107, '1 / 6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (107, '1 / 12', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (107, '1 / 9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (107, '1 / 4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (108, 5, 'secondary', 'Mathematics', 'ស្ែរ (S): (x - 1)^2 + (y - 2)^2 + (z + 2)^2 = 16។ រកកូអរដោនេប្រសព្វរវាងស្ែរនឹងអ័ក្ស Ox, Oy, Oz。', 'multiple_choice', 'medium', 'Ox: (1±2√2, 0, 0), Oy: (0, 2±√11, 0), Oz: (0, 0, -2±√11)', 'ជំនួសតំលៃអរដោនេអ័ក្សផ្សេងទៀតស្មើនឹងសូន្យ ដើម្បីរកចំណុចប្រសព្វ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - សមីការស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 108;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (108, 'Ox: (1±2√2, 0, 0), Oy: (0, 2±√11, 0), Oz: (0, 0, 2±√11)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (108, 'Ox: (-1±2√2, 0, 0), Oy: (0, -2±√11, 0), Oz: (0, 0, 2±√11)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (108, 'Ox: (1±√8, 0, 0), Oy: (0, 2±√12, 0), Oz: (0, 0, -2±√12)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (108, 'Ox: (1±2√2, 0, 0), Oy: (0, 2±√11, 0), Oz: (0, 0, -2±√11)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (109, 5, 'secondary', 'Mathematics', 'រកសមីការប្លង់ប៉ះស្ែរ (S) ត្រង់ចំណុចប្រសព្វ A1 និង A2 ជាមួយអ័ក្ស Ox。', 'multiple_choice', 'hard', '2√2 x - 2y + 2z - 2√2 - 8 = 0 និង -2√2 x - 2y + 2z + 2√2 + 8 = 0', 'ប្រើប្រាស់វ៉ិចទ័រពីផ្ចិតស្ែរទៅកាន់ចំណុចប៉ះជាវ៉ិចទ័រណរម៉ាល់របស់ប្លង់ប៉ះ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - ប្លង់ប៉ះស្ែរ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 109;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (109, '2√2 x + 2y - 2z - 2√2 - 8 = 0 និង -2√2 x + 2y - 2z + 2√2 + 8 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (109, '2√2 x - 2y + 2z - 2√2 = 0 និង -2√2 x - 2y + 2z + 2√2 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (109, '2√2 x - 2y + 2z - 2√2 - 8 = 0 និង -2√2 x - 2y + 2z + 2√2 + 8 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (109, '2√2 x - 2y + 2z + 2√2 - 8 = 0 និង -2√2 x - 2y + 2z - 2√2 + 8 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (110, 6, 'secondary', 'Mathematics', 'សិក្សាអថេរភាព និងសង់ក្រាបនៃអនុគមន៍ f(x) = (e^(2x) - 5e^x + 4) / e^x。', 'multiple_choice', 'medium', 'មានអប្បបរមាត្រង់ x = ln 2 ស្មើ -1', 'រកលីមីត ដេរីវេ តារាងអថេរភាព និងចំណុចប្រសព្វដើម្បីសង់ក្រាប。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១២ - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 110;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (110, 'មានអប្បបរមាត្រង់ x = ln 2 ស្មើ -1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (110, 'មានអតិបរមាត្រង់ x = ln 2 ស្មើ -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (110, 'មានអប្បបរមាត្រង់ x = ln 2 ស្មើ 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (110, 'មានអប្បបរមាត្រង់ x = ln 4 ស្មើ -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (111, 1, 'secondary', 'Mathematics', 'សរសេរអនុគមន៍ប្រាក់ចំណេញ P(x) ដោយដឹងថាប្រាក់ចំណាយ f(x) = 6x^2 + 22x + 100 និងប្រាក់ចំណូល I(x) = 5x^2 + 112x + 200。', 'multiple_choice', 'easy', 'P(x) = -x^2 + 90x + 100', 'អនុគមន៍ប្រាក់ចំណេញ P(x) ស្មើនឹងប្រាក់ចំណូល I(x) ដកនឹងប្រាក់ចំណាយ f(x)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - អនុគមន៍ប្រាក់ចំណេញ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 111;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (111, 'P(x) = x^2 - 90x - 100', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (111, 'P(x) = -x^2 + 90x + 100', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (111, 'P(x) = 11x^2 + 134x + 300', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (111, 'P(x) = -x^2 + 134x + 100', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (112, 1, 'secondary', 'Mathematics', 'ប៉ាន់ស្មានតម្លៃប្រហែលនៃកំណើនប្រាក់ចំណេញបើបរិមាណលក់កើនពី 30 គ្រឿងទៅ 50 គ្រឿង。', 'multiple_choice', 'medium', '41333.33 ម៉ឺនរៀល', 'គណនាអាំងតេក្រាលកំណត់ពី 30 ដល់ 50 នៃអនុគមន៍ប្រាក់ចំណេញ P(x)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - អាំងតេក្រាលកំណត់')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 112;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (112, '200 ម៉ឺនរៀល', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (112, '38500.00 ម៉ឺនរៀល', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (112, '45250.67 ម៉ឺនរៀល', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (112, '41333.33 ម៉ឺនរៀល', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (113, 2, 'secondary', 'Mathematics', 'គណនាតម្លៃប្រហែលនៃផ្ទៃក្រឡាខ័ណ្ឌដោយក្រាប f(x): x = 2 - y - y^2 និងអ័ក្សអរដោនេ y''y。', 'multiple_choice', 'medium', '9/2 ឯកតាផ្ទៃ', 'រកចំណុចប្រសព្វជាមួយអ័ក្ស y''y ត្រង់ y = 1 និង y = -2 រួចគណនាអាំងតេក្រាលកំណត់。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - ផ្ទៃក្រឡា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 113;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (113, '13/6 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (113, '9/4 ឯកតាផ្ទៃ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (113, '9/2 ឯកតាផ្ទៃ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (113, '7/2 ឯកតាផ្ទៃ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (114, 3, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល y'' = -y sin x ដឹងថា y(2π) = 3e。', 'multiple_choice', 'medium', 'y = 3e^(cos x)', 'បំបែកអាំងតេក្រាល y''/y = -sin x រួចប្រើលក្ខខណ្ឌអមเพื่อរកតម្លៃថេរ c。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 114;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (114, 'y = 3e^(cos x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (114, 'y = 3e^(-cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (114, 'y = 3e * e^(cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (114, 'y = 3e^(sin x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (115, 4, 'secondary', 'Mathematics', 'សិក្សាអថេរភាព និងសង់ក្រាបនៃអនុគមន៍ f(x) = x^3 - 3x + 2。', 'multiple_choice', 'medium', 'អតិបរមាធៀបស្មើ 4 ត្រង់ x = -1 និងអប្បបរមាធៀបស្មើ 0 ត្រង់ x = 1', 'រកដែនកំណត់ ដេរីវេ ព្រមទាំងចំណុចរបត់ I(0,2) ជាផ្ចិតឆ្លុះដើម្បីសង់ក្រាប。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - អនុគមន៍ពុធា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 115;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (115, 'អប្បបរមាធៀបស្មើ 4 ត្រង់ x = -1 និងអតិបរមាធៀបស្មើ 0 ត្រង់ x = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (115, 'អតិបរមាធៀបស្មើ 4 ត្រង់ x = -1 និងអប្បបរមាធៀបស្មើ 0 ត្រង់ x = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (115, 'អតិបរមាធៀបស្មើ 4 ត្រង់ x = 1 និងអប្បបរមាធៀបស្មើ 0 ត្រង់ x = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (115, 'អតិបរមាធៀបស្មើ 2 ត្រង់ x = -1 និងអប្បបរមាធៀបស្មើ -2 ត្រង់ x = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (116, 4, 'secondary', 'Mathematics', 'ដោះស្រាយ និងពិភាក្សាតាមតម្លៃ m នូវអត្ថិភាពនៃឫសសមីការ x^3 - 3x + 2 - m = 0。', 'multiple_choice', 'hard', 'm < 0 ឫសមួយ, m = 0 ឫសបី (ពីរស្មើ), 0 < m < 4 ឫសបីផ្សេងគ្នា, m = 4 ឫសបី (ពីរស្មើ), m > 4 ឫសមួយ', 'ផ្អែកលើក្រាបនៃអនុគមន៍ f(x) = x^3 - 3x + 2 ប្រៀបធៀបជាមួយបន្ទាត់ដេក y = m。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - ពិភាក្សាសមីការ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 116;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (116, 'm < 0 ឫសបីផ្សេងគ្នា, 0 ≤ m ≤ 4 ឫសមួយ, m > 4 ឫសបីផ្សេងគ្នា', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (116, 'm < 0 ឫសមួយ, 0 < m < 4 ឫសបីផ្សេងគ្នា, m > 4 ឫសមួយ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (116, 'm < -2 ឫសមួយ, m = -2 ឫសបី (ពីរស្មើ), -2 < m < 2 ឫសបីផ្សេងគ្នា, m = 2 ឫសបី (ពីរស្មើ), m > 2 ឫសមួយ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (116, 'm < 0 ឫសមួយ, m = 0 ឫសបី (ពីរស្មើ), 0 < m < 4 ឫសបីផ្សេងគ្នា, m = 4 ឫសបី (ពីរស្មើ), m > 4 ឫសមួយ', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (117, 5, 'secondary', 'Mathematics', 'ពីរ៉ាមីត SABCD បាតចតុកោណកែង (AB=a, AD=b), SA ⊥ (ABCD) និង SA = 2a။ M ∈ (SA) ដោយ AM = x។ ប្លង់ (MBC) កាត់ SD ត្រង់ N។ កំណត់រាងចតុកោណ BCNM。', 'multiple_choice', 'medium', 'ចតុកោណព្នាយកែង', 'បង្ហាញថា [MB] ⊥ [BC] និង [MN] ⊥ [MB] ដូចនេះ BCNM ជាចតុកោណព្នាយកែង。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 117;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (117, 'ចតុកោណព្នាយកែង', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (117, 'ចតុកោណកែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (117, 'ប្រលេឡូក្រាម', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (117, 'ចតុកោណព្នាយសមបាត', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (118, 5, 'secondary', 'Mathematics', 'កំណត់តម្លៃ x ដើម្បីឱ្យចតុកោណ BCNM មានផ្ទៃក្រឡាតូចបំផុត。', 'multiple_choice', 'hard', 'x = ((2 - √2)a) / 2', 'បង្កើតអនុគមន៍ផ្ទៃក្រឡា S(x) របស់ចតុកោណព្នាយកែង រួចរកដេរីវេទីមួយដើម្បីស្វែងរកតម្លៃអប្បបរមា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - អតិបរមានិងអប្បបរមា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 118;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (118, 'x = ((2 + √2)a) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (118, 'x = (2 - √2)a', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (118, 'x = ((2 - √2)a) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (118, 'x = (a√2) / 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (119, 5, 'secondary', 'Mathematics', 'កំណត់តម្លៃ x ដើម្បីឱ្យចតុកោណ BCNM មានផ្ទៃក្រឡាធំបំផុត。', 'multiple_choice', 'hard', 'x = ((2 + √2)a) / 2', 'ប្រើប្រាស់អនុគមន៍ផ្ទៃក្រឡា S(x) ផ្ទៀងផ្ទាត់តារាងសញ្ញាដេរីវេដើម្បីរកតម្លៃអតិបរមា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - អតិបរមានិងអប្បបរមា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 119;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (119, 'x = ((2 + √2)a) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (119, 'x = ((2 - √2)a) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (119, 'x = (2 + √2)a', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (119, 'x = (3a) / 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (120, 6, 'secondary', 'Mathematics', 'ពីរ៉ាមីត SABCD មាន SA = 2a និង AM = x (0 ≤ x ≤ 2a)។ តើប្រវែង MN មានតម្លៃប៉ុន្មានតាងដោយ a, b និង x?', 'multiple_choice', 'medium', 'MN = (2ab - xb) / (2a)', 'ប្រើប្រាស់ទ្រឹស្តីបទដាលែសតាមត្រីកោណ SMN និង SAD ដោះស្រាយរកប្រវែង MN。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៣ - ធរណីមាត្រធៀប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 120;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (120, 'MN = (2ab + xb) / (2a)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (120, 'MN = (xb) / (2a)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (120, 'MN = (2ab - xb) / a', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (120, 'MN = (2ab - xb) / (2a)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (121, 1, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល A = ∫_{1}^{2} ((√x - 1)^2) / x dx。', 'multiple_choice', 'medium', '5 - 4√2 + ln 2', 'បំបែកភាគលាភជា (x - 2√x + 1) / x រួចគណនាអាំងតេក្រាលនីមួយៗ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 121;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (121, '3 - 4√2 + ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (121, '5 - 4√2 + ln 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (121, '5 + 4√2 + ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (121, '5 - 4√2 - ln 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (122, 1, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល B = ∫_{π/6}^{π/2} (1 + sin 2x + cos 2x) / (sin x + cos x) dx。', 'multiple_choice', 'medium', '1', 'បំបែកភាគលាភជា 2 cos x (cos x + sin x) រួចបង្រួមជាមួយភាគបែង。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 122;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (122, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (122, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (122, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (122, '√3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (123, 2, 'secondary', 'Mathematics', 'គណនាដេរីវេ f''(x) នៃអនុគមន៍ f(x) = x - x^2/2 - ln(1 + x) រួចបង្ហាញថា x - x^2/2 < ln(1 + x) < x គ្រប់ x > 0。', 'multiple_choice', 'hard', 'f''(x) = -x^2 / (1 + x)', 'គណនាដេរីវេ f''(x) < 0 និង g''(x) > 0 เพื่อសិក្សាសញ្ញានៃអនុគមន៍。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - អនុគមន៍')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 123;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (123, 'f''(x) = -x^2 / (1 + x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (123, 'f''(x) = x^2 / (1 + x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (123, 'f''(x) = -x / (1 + x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (123, 'f''(x) = (2 - x^2) / (1 + x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (124, 3, 'secondary', 'Mathematics', 'សរសេរចំនួនកុំផ្លិច z = 2√2 + 2√2 i ជាទម្រង់ត្រីកោណមាត្រ。', 'multiple_choice', 'easy', '4 (cos(π/4) + i sin(π/4))', 'គណនាម៉ូឌុល r = 4 និងអាគុយម៉ង់ θ = π/4。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 124;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (124, '2√2 (cos(π/4) + i sin(π/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (124, '4 (cos(π/4) + i sin(π/4))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (124, '4 (cos(π/3) + i sin(π/3))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (124, '8 (cos(π/4) + i sin(π/4))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (125, 3, 'secondary', 'Mathematics', 'សរសេរ z^4 ជាទម្រង់ a + bi (ដឹងថា z = 2√2 + 2√2 i)。', 'multiple_choice', 'medium', '-256 + 0i', 'ប្រើប្រាស់រូបមន្តម៉្វាវ៉ា លើកកម្លាំងបួនលើទម្រង់ត្រីកោណមាត្រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 125;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (125, '256 + 0i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (125, '0 - 256i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (125, '-64 + 0i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (125, '-256 + 0i', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (126, 4, 'secondary', 'Mathematics', 'រកតម្លៃ a ដើម្បីឱ្យប៉ារ៉ាបូល y2 = -x^2 + a ប៉ះខ្សែកោង y1 = -1/4 x^4 + 2x^2 + 9/4。', 'multiple_choice', 'hard', 'a = 45 / 4', 'បង្កើតសមីការអាប់ស៊ីសរវាងខ្សែកោងទាំងពីរ និងផ្ទៀងផ្ទាត់លក្ខខណ្ឌដេលតាស្មើនឹងសូន្យ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - ប៉ារ៉ាបូល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 126;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (126, 'a = 45 / 4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (126, 'a = 9 / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (126, 'a = 21 / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (126, 'a = 33 / 4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (127, 5, 'secondary', 'Mathematics', 'ក្នុងលំហមាន A(2,1,3), B(3,6,1), C(2,0,2), D(1,-5,4)។ ប្រាប់ប្រភេទចតុកោណ ABCD និងគណនាផ្ទៃក្រឡា。', 'multiple_choice', 'medium', 'ជាប្រលេឡូក្រាម និងផ្ទៃក្រឡា S = √51', 'បង្ហាញថាវ៉ិចទ័រ AB = DC ដូចនេះជាប្រលេឡូក្រាម រួចគណនាផលគុណវ៉ិចទ័រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 127;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (127, 'ជាចតុកោណកែង និងផ្ទៃក្រឡា S = √51', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (127, 'ជាប្រលេឡូក្រាម និងផ្ទៃក្រឡា S = 51', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (127, 'ជាប្រលេឡូក្រាម និងផ្ទៃក្រឡា S = √51', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (127, 'ជាចតុកោណស្មើ និងផ្ទៃក្រឡា S = √51 / 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (128, 5, 'secondary', 'Mathematics', 'សរសេរសមីការប៉ារ៉ាម៉ែត្រនៃបន្ទាត់ (D) កាត់តាម A និងស្របនឹង BC。', 'multiple_choice', 'easy', 'x = 2 - t, y = 1 - 6t, z = 3 + t', 'ប្រើប្រាស់កូអរដោនេចំណុច A និងវ៉ិចទ័រប្រាប់ទិស BC = (-1, -6, 1)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - បន្ទាត់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 128;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (128, 'x = 3 - t, y = 6 - 6t, z = 1 + t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (128, 'x = 2 - t, y = 1 - 6t, z = 3 + t', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (128, 'x = 2 + t, y = 1 + 6t, z = 3 + t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (128, 'x = -1 + 2t, y = -6 + t, z = 1 + 3t', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (129, 5, 'secondary', 'Mathematics', 'សរសេរសមីការប្លង់ (P) កាត់តាមចំណុច A, B និង D。', 'multiple_choice', 'medium', '-7x + y - z + 17 = 0', 'រកវ៉ិចទ័រណរម៉ាល់ n = AB × AD = (-7, 1, -1) រួចសរសេរសមីការប្លង់កាត់តាម A。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - ប្លង់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 129;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (129, '7x + y - z + 17 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (129, '-7x - y - z + 17 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (129, '-7x + y - z - 17 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (129, '-7x + y - z + 17 = 0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (130, 6, 'secondary', 'Mathematics', 'គណនាលីមីត lim_{n→∞} u_n ដែល u_n = ln(1 + 1/n^2)ln(1 + 2/n^2)...ln(1 + n/n^2)。', 'multiple_choice', 'hard', '0', 'បំបែកផលគុណជាផលបូកលោការីត រួចគណនាលីមីតនីមួយៗពេល n ខិតជិតអនន្ត。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៤ - លីមីតស្វ៊ីត')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 130;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (130, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (130, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (130, 'e', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (130, '+∞', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (131, 1, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល ∫(1 + cos x)^2 dx + ∫(1 - sin x)^2 dx。', 'multiple_choice', 'medium', '3x + 2 sin x + 2 cos x + c', 'បំបែកកន្សោមការេ រួចប្រើប្រាស់រូបមន្ត cos^2 x + sin^2 x = 1 ដើម្បីគណនាអាំងតេក្រាល。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 131;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (131, '3x + 2 sin x - 2 cos x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (131, '2x + 2 sin x + 2 cos x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (131, '3x + 2 sin x + 2 cos x + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (131, '3x - 2 sin x + 2 cos x + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (132, 1, 'secondary', 'Mathematics', 'គណនាអាំងតេក្រាល ∫_0^π e^x(1 + e^(-x)/cos^2 x) dx。', 'multiple_choice', 'medium', 'e^π - 1', 'គុណផ្សាយ e^x ចូលក្នុងវង់ក្រចក រួចគណនាអាំងតេក្រាលនៃ e^x និង 1/cos^2 x。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - អាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 132;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (132, 'e^π', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (132, 'e^π + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (132, 'e^π - π', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (132, 'e^π - 1', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (133, 2, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល y'''' - 3y'' + 2y = 0 ដឹងថា y(0) = 1 និង y''(0) = 3。', 'multiple_choice', 'medium', 'y = -e^x + 2e^(2x)', 'រកចម្លើយទូទៅ y = Ae^x + Be^(2x) រួចប្រើលក្ខខណ្ឌអមដើម្បីរក A = -1 និង B = 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 133;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (133, 'y = 2e^x - e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (133, 'y = -e^x + 2e^(2x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (133, 'y = e^x + 2e^(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (133, 'y = -e^(-x) + 2e^(-2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (134, 3, 'secondary', 'Mathematics', 'សរសេរ z1 = √3/2 - i/2 និង z2 = √3/2 + i/2 ជាទម្រង់ត្រីកោណមាត្រ。', 'multiple_choice', 'easy', 'z1 = cos(-π/6) + i sin(-π/6), z2 = cos(π/6) + i sin(π/6)', 'គណនាម៉ូឌុល r = 1 និងអាគុយម៉ង់សម្រាប់ចំនួនកុំផ្លិចនីមួយៗ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - ចំនួនកុំផ្លិច')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 134;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (134, 'z1 = cos(-π/6) + i sin(-π/6), z2 = cos(π/6) + i sin(π/6)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (134, 'z1 = cos(-π/3) + i sin(-π/3), z2 = cos(π/3) + i sin(π/3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (134, 'z1 = cos(π/6) + i sin(π/6), z2 = cos(-π/6) + i sin(-π/6)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (134, 'z1 = cos(5π/6) + i sin(5π/6), z2 = cos(π/6) + i sin(π/6)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (135, 4, 'secondary', 'Mathematics', 'ក្រុមហ៊ុនជ្រើសរើសបុគ្គលិក 5 នាក់ ពីនិស្សិត 10 នាក់ (ស្រី 4, ប្រុស 6)។ រកប្រូបាបបានយ៉ាងតិចស្រី 3 នាក់。', 'multiple_choice', 'medium', '11 / 42', 'គណនាប្រូបាបករណីបានស្រី 3 ប្រុស 2 បូកនឹងករណីបានស្រី 4 ប្រុស 1。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 135;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (135, '1 / 42', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (135, '5 / 21', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (135, '11 / 42', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (135, '13 / 42', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (136, 5, 'secondary', 'Mathematics', 'សិក្សាអថេរភាព និងសង់ខ្សែកោង y = (x^2 + 5x + 15) / (x + 3)。', 'multiple_choice', 'medium', 'មានអតិបរមាធៀបត្រង់ x = -6 និងអប្បបរមាធៀបត្រង់ x = 0', 'រកដែនកំណត់ លីមីត អាស៊ីមតូតឈរ x = -3 និងអាស៊ីមតូតទ្រេត y = x + 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - អនុគមន៍សនិទាន')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 136;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (136, 'មានអប្បបរមាធៀបត្រង់ x = -6 និងអតិបរមាធៀបត្រង់ x = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (136, 'មានអតិបរមាធៀបត្រង់ x = -6 និងអប្បបរមាធៀបត្រង់ x = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (136, 'មានអតិបរមាធៀបត្រង់ x = 6 និងអប្បបរមាធៀបត្រង់ x = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (136, 'មានអប្បបរមាធៀបត្រង់ x = -3 និងអតិបរមាធៀបត្រង់ x = 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (137, 5, 'secondary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ (d) ប៉ះខ្សែកោង y = (x^2 + 5x + 15) / (x + 3) ត្រង់ចំណុច A(-2, 9)。', 'multiple_choice', 'easy', 'y = -8x - 7', 'គណនាមេគុណប្រាប់ទិស f''(-2) = -8 រួចសរសេរសមីការបន្ទាត់ប៉ះ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - បន្ទាត់ប៉ះ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 137;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (137, 'y = -8x + 25', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (137, 'y = 8x + 25', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (137, 'y = -8x + 7', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (137, 'y = -8x - 7', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (138, 6, 'secondary', 'Mathematics', 'រកចំណោលកែង H នៃចំណុច A(2, 1, 3) មកលើប្លង់ (P): 2x + y + 3z - 28 = 0。', 'multiple_choice', 'hard', 'H(4, 2, 6)', 'សរសេរសមីការបន្ទាត់កែងនឹងប្លង់កាត់តាម A រួចរកចំណុចប្រសព្វជាមួយប្លង់ (P)。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 138;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (138, 'H(0, 0, 0)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (138, 'H(6, 3, 9)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (138, 'H(4, 2, 6)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (138, 'H(4, 1, 6)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (139, 6, 'secondary', 'Mathematics', 'គណនាចម្ងាយពីចំណុច A(2, 1, 3) មកលើប្លង់ (P): 2x + y + 3z - 28 = 0。', 'multiple_choice', 'medium', '√14 ឯកតាប្រវែង', 'ប្រើប្រាស់រូបមន្តចម្ងាយពីចំណុចទៅប្លង់ ឬប្រវែងវ៉ិចទ័រ AH。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - ចម្ងាយក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 139;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (139, '√14 ឯកតាប្រវែង', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (139, '14 ឯកតាប្រវែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (139, '√14 / 2 ឯកតាប្រវែង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (139, '2√14 ឯកតាប្រវែង', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (140, 7, 'secondary', 'Mathematics', 'សរសេរសមីការប៉ារ៉ាម៉ែត្រនៃបន្ទាត់ (Δ) កាត់តាម M(3, 2, 5) ហើយកែងនឹងប្លង់ (P): 2x + y + 3z - 28 = 0。', 'multiple_choice', 'easy', 'x = 3 + 2t, y = 2 + t, z = 5 + 3t', 'ប្រើប្រាស់កូអរដោនេចំណុច M និងវ៉ិចទ័រណរម៉ាល់របស់ប្លង់ (P) ជាវ៉ិចទ័រប្រាប់ទិស。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៦ - បន្ទាត់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 140;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (140, 'x = 3 - 2t, y = 2 - t, z = 5 - 3t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (140, 'x = 2 + 3t, y = 1 + 2t, z = 3 + 5t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (140, 'x = 3 + 2t, y = 2 + 2t, z = 5 + 3t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (140, 'x = 3 + 2t, y = 2 + t, z = 5 + 3t', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (141, 1, 'secondary', 'Mathematics', 'រកដេរីវេនៃអនុគមន៍ f(x) = ln(x + √(x^2 + 2)) រួចគណនាកន្សោម I = ∫_0^1 (1 / √(x^2 + 2)) dx。', 'multiple_choice', 'medium', 'f''(x) = 1 / √(x^2 + 2) និង I = ln((√2 + √6) / 2)', 'គណនាដេរីវេ f''(x) រួចប្រើប្រាស់លទ្ធផលនោះមកគណនាអាំងតេក្រាលកំណត់ I。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - ដេរីវេនិងអាំងតេក្រាល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 141;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (141, 'f''(x) = x / √(x^2 + 2) និង I = ln((√2 + √6) / 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (141, 'f''(x) = 1 / √(x^2 + 2) និង I = ln((√2 + √6) / 2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (141, 'f''(x) = 1 / √(x^2 + 2) និង I = ln(1 + √3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (141, 'f''(x) = 1 / (x + √(x^2 + 2)) និង I = ln(√2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (142, 2, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល y'' - y sin x = 0 ដឹងថា y(0) = e。', 'multiple_choice', 'medium', 'y = e^(2 - cos x)', 'បំបែក y''/y = sin x រួចបំពាក់អាំងតេក្រាលនិងប្រើលក្ខខណ្ឌអមដើម្បីរកតម្លៃថេរ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 142;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (142, 'y = e^(2 - cos x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (142, 'y = e^(cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (142, 'y = e^(1 - cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (142, 'y = e^(2 + cos x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (143, 2, 'secondary', 'Mathematics', 'ដោះស្រាយសមីការឌីផេរ៉ង់ស្យែល y'''' + 2y'' - 15y = 0 ដឹងថា y(0) = 5 និង y''(0) = -1。', 'multiple_choice', 'medium', 'y = 2e^(-5x) + 3e^(3x)', 'សមីការសម្គាល់ λ^2 + 2λ - 15 = 0 មានឫស λ = -5 និង λ = 3 រួចរកតម្លៃ A និង B。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - សមីការឌីផេរ៉ង់ស្យែល')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 143;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (143, 'y = 3e^(-5x) + 2e^(3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (143, 'y = 2e^(5x) + 3e^(-3x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (143, 'y = 2e^(-5x) + 3e^(3x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (143, 'y = -2e^(-5x) + 7e^(3x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (144, 3, 'secondary', 'Mathematics', 'ប្រអប់មានប៊ិចខៀវ 8 ក្រហម 7។ ចាប់យក 5 ដើមព្រមគ្នា។ រកប្រូបាបបានប៊ិចខៀវ 2 និងក្រហម 3。', 'multiple_choice', 'medium', '140 / 429', 'ប្រើប្រាស់បន្សំ C(8,2) × C(7,3) ចែកនឹង C(15,5) ដើម្បីរកប្រូបាប。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - ប្រូបាប')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 144;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (144, '168 / 429', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (144, '140 / 429', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (144, '70 / 429', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (144, '140 / 1001', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (145, 4, 'secondary', 'Mathematics', 'សិក្សាអថេរភាព និងសង់ខ្សែកោង y = -x^3 - 3x^2 + 1。', 'multiple_choice', 'medium', 'មានអប្បបរមាធៀបត្រង់ x = -2 និងអតិបរមាធៀបត្រង់ x = 0', 'រកដែនកំណត់ លីមីត ដេរីវេទីមួយនិងទីពីរ រួចរកចំណុចរបត់ I(-1, -1) ជាផ្ចិតឆ្លុះ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - អនុគមន៍ពុធា')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 145;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (145, 'មានអតិបរមាធៀបត្រង់ x = -2 និងអប្បបរមាធៀបត្រង់ x = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (145, 'មានអប្បបរមាធៀបត្រង់ x = 0 និងអតិបរមាធៀបត្រង់ x = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (145, 'មានអប្បបរមាធៀបត្រង់ x = -1 និងគ្មានអតិបរមា', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (145, 'មានអប្បបរមាធៀបត្រង់ x = -2 និងអតិបរមាធៀបត្រង់ x = 0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (146, 4, 'secondary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ប៉ះខ្សែកោង y = -x^3 - 3x^2 + 1 ដែលស្របនឹងបន្ទាត់ d: y = -9x + 19。', 'multiple_choice', 'medium', 'y = -9x + 6 និង y = -9x - 26', 'ដោះស្រាយសមីការ f''(x) = -9 ដើម្បីរកអាប់ស៊ីសចំណុចប៉ះ x = 1 និង x = -3。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - បន្ទាត់ប៉ះ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 146;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (146, 'y = -9x + 6 និង y = -9x - 26', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (146, 'y = -9x - 6 និង y = -9x + 26', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (146, 'y = -9x + 6 និង y = -9x + 26', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (146, 'y = -9x + 12 និង y = -9x - 20', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (147, 5, 'secondary', 'Mathematics', 'បន្ទាត់ d កាត់ I(1,-3,3) ស្របនឹង v=(-1,2,1) និងប្លង់ P: 2x+y-2z+9=0។ សរសេរសមីការប៉ារ៉ាម៉ែត្រ d。', 'multiple_choice', 'easy', 'x = 1 - t, y = -3 + 2t, z = 3 + t', 'ប្រើប្រាស់កូអរដោនេចំណុច I និងវ៉ិចទ័រប្រាប់ទិស v ដើម្បីសរសេរសមីការប៉ារ៉ាម៉ែត្រ。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - បន្ទាត់ក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 147;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (147, 'x = 1 + t, y = -3 + 2t, z = 3 + t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (147, 'x = 1 + 2t, y = -3 + t, z = 3 - 2t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (147, 'x = -1 - t, y = 3 + 2t, z = -3 + t', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (147, 'x = 1 - t, y = -3 + 2t, z = 3 + t', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (148, 5, 'secondary', 'Mathematics', 'រកកូអរដោនេចំណុច D លើបន្ទាត់ d ដឹងថាចម្ងាយពី D ទៅប្លង់ P ស្មើនឹង 2。', 'multiple_choice', 'hard', 'D(3, -7, 1) និង D(-3, 5, 7)', 'ជំនួសកូអរដោនេប៉ារ៉ាម៉ែត្ររបស់ D ចូលទៅក្នុងរូបមន្តចម្ងាយពីចំណុចទៅប្លង់ស្មើនឹង 2。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - ចម្ងាយក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 148;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (148, 'D(2, -5, 2) និង D(-2, 3, 6)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (148, 'D(-3, 7, -1) និង D(3, -5, -7)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (148, 'D(3, -7, 1) និង D(-3, 5, 7)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (148, 'D(3, -7, 1) តែមួយគត់', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (149, 5, 'secondary', 'Mathematics', 'រកកូអរដោនេចំណុចប្រសព្វ A រវាងបន្ទាត់ d និងប្លង់ P。', 'multiple_choice', 'medium', 'A(0, -1, 4)', 'ជំនួសសមីការប៉ារ៉ាម៉ែត្ររបស់ d ចូលទៅក្នុងប្លង់ P ដើម្បីរកតម្លៃ t = 1 រួចទាញរកកូអរដោនេ A。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - ធរណីមាត្រក្នុងលំហ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 149;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (149, 'A(2, -5, 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (149, 'A(0, -1, 4)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (149, 'A(1, -3, 3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (149, 'A(0, 1, 4)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (150, 6, 'secondary', 'Mathematics', 'ប៉ារ៉ាបូលមានកំនុំ F(5, 2) និងបន្ទាត់ប្រាប់ទិស x + 1 = 0។ រកកំពូល V និងសមីការស្តង់ដានៃប៉ារ៉ាបូល。', 'multiple_choice', 'hard', 'កំពូល V(2, 2) និងសមីការ (y - 2)^2 = 12(x - 2)', 'រកកូអរដោនេកំពូល V ស្ថិតនៅកណ្តាលរវាងកំនុំ និងបន្ទាត់ប្រាប់ទិស រួចសរសេរសមីការស្តង់ដា。', 'វិញ្ញាសាគណិតវិទ្យា គ្រូមធ្យម ឆ្នាំ ២០១៧ - កោណទ្វេភាគ')
ON CONFLICT (question_id) DO UPDATE SET
  topic_id = EXCLUDED.topic_id,
  exam_name = EXCLUDED.exam_name,
  subject_name = EXCLUDED.subject_name,
  question_text = EXCLUDED.question_text,
  question_type = EXCLUDED.question_type,
  difficulty_level = EXCLUDED.difficulty_level,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  reference_note = EXCLUDED.reference_note;

DELETE FROM answer_option WHERE question_id = 150;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (150, 'កំពូល V(2, 2) និងសមីការ (y - 2)^2 = 12(x - 2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (150, 'កំពូល V(2, 2) និងសមីការ (x - 2)^2 = 12(y - 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (150, 'កំពូល V(2, 2) និងសមីការ (y - 2)^2 = 6(x - 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (150, 'កំពូល V(5, 2) និងសមីការ (y - 2)^2 = 12(x - 5)', FALSE);

-- Reset sequence for question_id
SELECT setval(pg_get_serial_sequence('question', 'question_id'), COALESCE(MAX(question_id), 1)) FROM question;

COMMIT;
