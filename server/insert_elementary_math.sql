-- ============================================================
-- PassKru Elementary Mathematics Seed SQL
-- Total Questions: 361 (IDs 151 to 511)
-- Exam Name: elementary
-- Subject Name: Mathematics
-- ============================================================

BEGIN;

-- 1. Ensure Subject 1 is named Mathematics
UPDATE subject SET subject_name = 'Mathematics' WHERE subject_id = 1;

-- 2. Ensure Topics 11-20 exist
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (11, 1, 'សមីការ និង វិសមីការ', 'Equations & Inequalities')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (12, 1, 'ធរណីមាត្រ និង កោណិក', 'Geometry, Conics (Parabola, Ellipse, Sphere)')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (13, 1, 'លីមីត និង អថេរភាព', 'Limits & Continuity')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (14, 1, 'អនុគមន៍ និង បន្ទាត់ប៉ះ', 'Functions & Tangent Lines')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (15, 1, 'អាំងតេក្រាល និង មាឌ', 'Integrals, Areas & Solid Volumes')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (16, 1, 'ត្រីកោណមាត្រ', 'Trigonometric functions & equations')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (17, 1, 'ចំនួនកុំផ្លិច', 'Complex Numbers')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (18, 1, 'ដេរីវេ និង អនុវត្តន៍', 'Derivatives and Applications')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (19, 1, 'ធរណីមាត្រ និង វ៉ិចទ័រក្នុងលំហ', '3D Geometry, Vectors, Planes in Space')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;
INSERT INTO topic (topic_id, subject_id, topic_name, description)
VALUES (20, 1, 'ស្ថិតិ និង ប្រូបាប', 'Combinatorics, Statistics & Probability')
ON CONFLICT (topic_id) DO UPDATE SET topic_name = EXCLUDED.topic_name;

-- 3. Insert Questions
INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (151, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->0) (sin 2x - sin x) / (sin 2x + sin x)', 'multiple_choice', 'medium', '1/3', 'បំប្លែកកន្សោមលីមីតរួចគណនាទទួលបានលទ្ធផលស្មើនឹង 1/3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 151;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (151, '1/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (151, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (151, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (151, '3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (152, 17, 'elementary', 'Mathematics', 'គណនាផ្នែកពិតនៃចំនួនកុំផ្លិច z = (1+i) / (1+i*sqrt(3))^4', 'multiple_choice', 'hard', '(-1 - sqrt(3)) / 32', 'បំប្លែកនិងដោះស្រាយចំនួនកុំផ្លិចទទួលបានផ្នែកពិតស្មើនឹង (-1 - sqrt(3)) / 32.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 152;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (152, '(-1 - sqrt(3)) / 32', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (152, '(sqrt(3) - 1) / 32', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (152, '1/32', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (152, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (153, 12, 'elementary', 'Mathematics', 'តើអនុគមន៍ f(x) = |(x-1)(x^2-x)| ត្រង់ចំណុច x = 0 យ៉ាងដូចម្តេច?', 'multiple_choice', 'medium', 'ជាប់ តែគ្មានដេរីវេ', 'តាមរយៈការសិក្សាភាពជាប់ គេឃើញថា lim (x->0-) f(x) = lim (x->0+) f(x) = f(0) = 0 (ជាប់) ប៉ុន្តែដេរីវេខាងឆ្វេងនិងស្តាំមិនស្មើគ្នា (f''_(0) = -1 និង f''_{+}(0) = 1) ដូច្នេះគ្មានដេរីវេ.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 153;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (153, 'ជាប់ តែគ្មានដេរីវេ', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (153, 'ទាំងជាប់ ទាំងមានដេរីវេ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (153, 'មិនជាប់ និងគ្មានដេរីវេ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (153, 'គ្មានចម្លើយត្រឹមត្រូវ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (154, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល J = ∫ từ 0 đến 2 của |(x-1)(x-2)| dx', 'multiple_choice', 'medium', '1', 'បំបែកតំបន់អាំងតេក្រាលតាមសញ្ញានៃកន្សោមក្នុងតម្លៃដាច់ខាតរួចគណនាទទួលបានលទ្ធផលស្មើនឹង 1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 154;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (154, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (154, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (154, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (154, '1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (155, 19, 'elementary', 'Mathematics', 'ក្នុងតម្រុយអរតូណរម៉ាល់ គេមានចំណុច A(1,1,1), B(2,3,4), C(6,5,2) និង D(7,7,5)។ គណនាផ្ទៃក្រឡានៃប្រលេឡូក្រាម ABCD។', 'multiple_choice', 'medium', '2*sqrt(70)', 'គណនាផលគុណវ៉ិចទ័រឆ្លងកាត់ |AB x AC| ទទួលបានផ្ទៃក្រឡាស្មើនឹង 2*sqrt(70) ឯកតាផ្ទៃ.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 155;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (155, '2*sqrt(70)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (155, 'sqrt(70)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (155, '4*sqrt(70)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (155, '70', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (156, 11, 'elementary', 'Mathematics', 'រកឫសនៃសមីការ f(x) = 2 + 1/(x+1) - 1/(x+1)^2 = 0', 'multiple_choice', 'easy', '-2 និង -1/2', 'បំប្លែងសមីការស្មើនឹង 2(x+1)^2 + (x+1) - 1 = 0 ទទួលបានឫស x = -2 និង x = -1/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 156;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (156, '-2 និង -1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (156, '2 និង 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (156, '-1 និង -2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (156, '0 និង 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (157, 14, 'elementary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ប៉ះទៅនឹងខ្សែកោង C នៃអនុគមន៍ f(x) = 2 + 1/(x+1) - 1/(x+1)^2 ត្រង់ចំណុចដែលមានអាប់ស៊ីស x0 = 0', 'multiple_choice', 'medium', 'y = x + 2', 'គណនាមេគុណប្រាប់ទិស f''(0) = 1 និងតម្លៃ f(0) = 2 ជំនួសចូលរូបមន្តបន្ទាត់ប៉ះទទួលបាន y = x + 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០២')
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

DELETE FROM answer_option WHERE question_id = 157;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (157, 'y = x + 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (157, 'y = x - 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (157, 'y = 2x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (157, 'y = x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (158, 18, 'elementary', 'Mathematics', 'គណនាដេរីវេនៃអនុគមន៍ f(x) = (x^2 + 3x + 5)e^{6x}', 'multiple_choice', 'medium', '(6x^2 + 20x + 33)e^{6x}', 'គណនាដេរីវេតាមក្បួនផលគុណទទួលបាន (6x^2 + 20x + 33)e^{6x}.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 158;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (158, '(6x^2 + 20x + 33)e^{6x}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (158, '(x^2 + 3x + 5)e^{6x}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (158, '(2x + 3)e^{6x}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (158, '6(x^2 + 3x + 5)e^{6x}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (159, 16, 'elementary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ប៉ះនៃខ្សែកោងតាងអនុគមន៍ h(x) = x ln x + 1 ត្រង់ចំណុច M(1,1)', 'multiple_choice', 'medium', 'y = x', 'រកមេគុណប្រាប់ទិស h''(1) = 1 និង h(1) = 1 ទទួលបានសមីការបន្ទាត់ប៉ះ y = x.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 159;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (159, 'y = x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (159, 'y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (159, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (159, 'y = x - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (160, 20, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់៖ J = ∫ dx / (x^2 - 5x + 6)', 'multiple_choice', 'medium', 'ln| (x-3)/(x-2) | + c', 'បំបែកភាគបែងជាកត្តា (x-2)(x-3) រួចគណនាអាំងតេក្រាលទទួលបាន ln| (x-3)/(x-2) | + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 160;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (160, 'ln| (x-3)/(x-2) | + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (160, 'ln|x^2 - 5x + 6| + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (160, '1/(x-3) - 1/(x-2) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (160, 'ln| (x-2)/(x-3) | + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (161, 13, 'elementary', 'Mathematics', 'រកផ្ទៃក្រឡាខណ្ឌដោយខ្សែកោងតាងអនុគមន៍ y = x^2 + 2x និងបន្ទាត់ y = x + 2', 'multiple_choice', 'medium', '9/2', 'គណនាអាំងតេក្រាលកំណត់ពី -2 ដល់ 1 នៃកន្សោម ((x+2) - (x^2+2x)) dx ទទួលបាន 9/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 161;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (161, '9/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (161, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (161, '7/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (161, '5', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (162, 18, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ៖ (4-x)/1986 + (3-x)/1987 + (2-x)/1988 + (1-x)/1989 = -4', 'multiple_choice', 'hard', '1990', 'បំបែកនិងបន្ថែមចំនួន ១ ក្នុងនីមួយៗនៃតភាគដើម្បីទាញយកកត្តារួម (1990 - x) ទទួលបានឫស x = 1990.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 162;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (162, '1990', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (162, '1986', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (162, '2003', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (162, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (163, 11, 'elementary', 'Mathematics', 'ចូររកផ្ទៃក្រឡានៃត្រីកោណ ABC ដែលមានចំណុច A(-1,1,2), B(0,2,4) និង C(-1,3,1)', 'multiple_choice', 'medium', 'sqrt(30) / 2', 'ប្រើប្រាស់រូបមន្ត S = (1/2)|AB x AC| ទទួលបាន sqrt(30) / 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៣')
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

DELETE FROM answer_option WHERE question_id = 163;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (163, 'sqrt(30) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (163, 'sqrt(30)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (163, 'sqrt(15) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (163, '15', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (164, 16, 'elementary', 'Mathematics', 'ដោះស្រាយវិសមីការ៖ sin x + sqrt(3)cos x >= 1 បើ -pi < x < pi', 'multiple_choice', 'medium', '-pi/6 <= x <= pi/2', 'បំប្លែកវិសមីការជា sin(x + pi/3) >= 1/2 រួចទាញរកចម្លើយ -pi/6 <= x <= pi/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៤')
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

DELETE FROM answer_option WHERE question_id = 164;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (164, '-pi/6 <= x <= pi/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (164, '0 <= x <= pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (164, '-pi/3 <= x <= pi/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (164, '-pi/2 <= x <= pi/6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (165, 14, 'elementary', 'Mathematics', 'កំណត់ចំនួនថេរ a និង b ដើម្បីឱ្យចំពោះគ្រប់ x គេបាន៖ 1 / (x(x+1)(x+2)) = a / (x(x+1)) + b / ((x+1)(x+2))', 'multiple_choice', 'medium', 'a = 1/2, b = -1/2', 'ផ្ទឹមមេគុណភាគយកបន្ទាប់ពីបង្រួមភាគបែងរួម ទទួលបាន a = 1/2 និង b = -1/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៤')
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

DELETE FROM answer_option WHERE question_id = 165;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (165, 'a = 1/2, b = -1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (165, 'a = 1, b = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (165, 'a = -1/2, b = 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (165, 'a = 1/3, b = -1/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (166, 20, 'elementary', 'Mathematics', 'គេបង្កើតគណៈកម្មការមួយមានសមាជិក 5 នាក់ ក្នុងចំណោម 12 នាក់ ដែលមាន A និង B ចូលរួមទាំងពីរនាក់។ រកប្រូបាបដើម្បីឱ្យ A និង B បានចូលជាសមាជិកគណៈកម្មការទាំងពីរនាក់។', 'multiple_choice', 'medium', '5/33', 'ចំនួនករណីស្រប n(A) = C(2,2)*C(10,3) = 120 និង n(S) = C(12,5) = 792 ដូច្នេះ P(A) = 120/792 = 5/33.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៤')
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

DELETE FROM answer_option WHERE question_id = 166;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (166, '5/33', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (166, '2/11', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (166, '1/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (166, '4/33', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (167, 12, 'elementary', 'Mathematics', 'កំណត់កូអរដោនេផ្ចិត I និងកាំ R នៃស្វ៊ែរ (S): x^2 + y^2 + z^2 - 2x - 4y + 4z = 0', 'multiple_choice', 'easy', 'I(1, 2, -2) និង R = 3', 'បំលែងសមីការស្វ៊ែរជាទម្រង់ស្តង់ដា (x-1)^2 + (y-2)^2 + (z+2)^2 = 3^2 ទទួលបានផ្ចិត I(1,2,-2) និងកាំ R = 3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៤')
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

DELETE FROM answer_option WHERE question_id = 167;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (167, 'I(1, 2, -2) និង R = 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (167, 'I(-1, -2, 2) និង R = 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (167, 'I(1, 2, -2) និង R = 9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (167, 'I(2, 4, -4) និង R = 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (168, 17, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច៖ x^2 - 2x + 5 = 0', 'multiple_choice', 'easy', '1 ± 2i', 'បំលែងសមីការជាទម្រង់ (x-1)^2 = -4 ទទួលបានឫស x = 1 ± 2i.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៥')
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

DELETE FROM answer_option WHERE question_id = 168;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (168, '1 ± 2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (168, '1 ± i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (168, '-1 ± 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (168, '2 ± i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (169, 19, 'elementary', 'Mathematics', 'កំណត់តម្លៃនៃ a និង b ដើម្បីឱ្យ 2-i ជាឫសនៃសមីការ ax^2 + bx - 20 = 0', 'multiple_choice', 'medium', 'a = -4, b = 16', 'ជំនួស x = 2-i ចូលក្នុងសមីការ រួចផ្ទឹមផ្នែកពិតនិងផ្នែកនិមិត្តស្មើនឹងសូន្យ ទទួលបាន a = -4 និង b = 16.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៥')
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

DELETE FROM answer_option WHERE question_id = 169;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (169, 'a = -4, b = 16', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (169, 'a = 4, b = -16', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (169, 'a = -2, b = 8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (169, 'a = 1, b = -4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (170, 15, 'elementary', 'Mathematics', 'សរសេរចំនួនកុំផ្លិច z = ((1+i)/(1-i))^3 ជាទម្រង់ត្រីកោណមាត្រ', 'multiple_choice', 'medium', 'cos(3pi/2) + i sin(3pi/2)', 'សម្រួល (1+i)/(1-i) = i ដូច្នេះ z = i^3 = -i = cos(3pi/2) + i sin(3pi/2).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៥')
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

DELETE FROM answer_option WHERE question_id = 170;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (170, 'cos(3pi/2) + i sin(3pi/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (170, 'cos(pi/2) + i sin(pi/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (170, 'cos(pi) + i sin(pi)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (170, 'cos(0) + i sin(0)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (171, 13, 'elementary', 'Mathematics', '្នុងថង់មួយមានប៊ូលពណ៌ស ១២ និងប៊ូលពណ៌ខ្មៅ ១៥ ។ គេចាប់យកពីក្នុងថង់នូវប៊ូលពីរជាមួយគ្នា ។ តើគេមានប៉ុន្មានរបៀបដើម្បីចាប់យកចេញឱ្យបានយ៉ាងតិចបំផុតប៊ូលពណ៌សមួយ?', 'multiple_choice', 'medium', '246', 'យកចំនួនរបៀបសរុប C(27,2) ដកនឹងចំនួនរបៀបដែលបានប៊ូលខ្មៅទាំងពីរ C(15,2) ទទួលបាន 351 - 105 = 246 របៀប.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៥')
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

DELETE FROM answer_option WHERE question_id = 171;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (171, '246', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (171, '180', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (171, '351', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (171, '105', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (172, 11, 'elementary', 'Mathematics', 'កំណត់តម្លៃនៃ m ដើម្បីឱ្យអនុគមន៍ f_m(x) = ln(x^2 + 4x + m) មានដែនកំណត់ស្មើនឹងចំនួនពិត IR ។', 'multiple_choice', 'medium', 'm > 4', 'ដើម្បីឱ្យអនុគមន៍មានដែនកំណត់លើ IR លុះត្រាតែ x^2 + 4x + m > 0 គ្រប់ x ដែលនាំឱ្យ delta'' < 0, ស្មើនឹង 4 - m < 0 ឬ m > 4.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៥')
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

DELETE FROM answer_option WHERE question_id = 172;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (172, 'm > 4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (172, 'm < 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (172, 'm >= 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (172, 'm < 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (173, 18, 'elementary', 'Mathematics', 'កំណត់ចំនួនកុំផ្លិច z ដែល z, 1/z និង 1-z មានម៉ូឌុលស្មើគ្នា។', 'multiple_choice', 'hard', '1/2 ± (sqrt(3)/2)i', 'តាមរយៈលក្ខខណ្ឌម៉ូឌុលស្មើគ្នា គេទាញបាន a = 1/2 និង b = ±(sqrt(3)/2) ដូច្នេះ z = 1/2 ± (sqrt(3)/2)i.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៦')
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

DELETE FROM answer_option WHERE question_id = 173;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (173, '1/2 ± (sqrt(3)/2)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (173, '1 ± i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (173, '-1/2 ± (sqrt(3)/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (173, '1/2 ± i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (174, 14, 'elementary', 'Mathematics', 'រកសមីការបន្ទាត់ (T) ដែលប៉ះនឹងខ្សែកោងតាងអនុគមន៍ y = e^x / (1 - sin x) ត្រង់ចំណុចដែលមានអាប់ស៊ីស x = 0', 'multiple_choice', 'medium', 'y = 2x + 1', 'គណនាដេរីវេ y''(0) = 2 និងតម្លៃ y(0) = 1 ទទួលបានសមីការបន្ទាត់ប៉ះ y = 2x + 1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៦')
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

DELETE FROM answer_option WHERE question_id = 174;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (174, 'y = 2x + 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (174, 'y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (174, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (174, 'y = x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (175, 12, 'elementary', 'Mathematics', 'រកកូអរដោនេនៃចំណុចប្រសព្វ M រវាងបន្ទាត់ (T): y = 2x + 1 និងខ្សែកោងតាងអនុគមន៍ y = 2x + 1 + ln(x-1)', 'multiple_choice', 'easy', '(2, 5)', 'ផ្ទឹមសមីការអាប់ស៊ីស 2x + 1 + ln(x-1) = 2x + 1 ទទួលបាន ln(x-1) = 0 ដែលផ្តល់ x = 2 និង y = 5.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៦')
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

DELETE FROM answer_option WHERE question_id = 175;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (175, '(2, 5)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (175, '(1, 3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (175, '(2, 3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (175, '(e, 2e+1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (176, 16, 'elementary', 'Mathematics', 'ការេមួយមានរង្វាស់ជ្រុងស្មើ a ។ នៅក្នុងការេនោះគេសង់ការេមួយទៀតដែលមានកំពូលវាជាចំណុចកណ្តាលនៃជ្រុងការេមុន រហូតដល់ការេទី n។ គណនាផ្ទៃក្រឡាការេទី n (S_n)。', 'multiple_choice', 'medium', 'a^2 / 2^{n-1}', 'ផ្ទៃក្រឡាការេទី n គឺ S_n = a^2 / 2^{n-1} តាមស្វ៊ីតធរណីមាត្រនៃផ្ទៃក្រឡា.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៦')
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

DELETE FROM answer_option WHERE question_id = 176;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (176, 'a^2 / 2^{n-1}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (176, 'a^2 / 2^n', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (176, 'a^2 / 2^{n+1}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (176, 'a^2 * 2^{n-1}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (177, 17, 'elementary', 'Mathematics', 'គេឱ្យ P(z) = z^2 + 2(2+i)z + 3 + 4i ។ បញ្ជាក់ថា P(z) ជាការេនៃពហុធាដឺក្រេទី១ តើ P(z) ស្មើនឹងកន្សោមណា?', 'multiple_choice', 'medium', '(z + 2 + i)^2', 'គណនាអិចសបូណង់ស្យែលគ្រាប់ឌីសគ្រីមណង់ delta'' = 0 និងរកឫសដុប z0 = -(2+i) ដូច្នេះ P(z) = (z + 2 + i)^2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៧')
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

DELETE FROM answer_option WHERE question_id = 177;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (177, '(z + 2 + i)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (177, '(z - 2 - i)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (177, '(z + 1 + 2i)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (177, '(z + 2 - i)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (178, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់៖ I = ∫ x^2 ln x dx', 'multiple_choice', 'medium', '(1/3)x^3 ln x - (1/9)x^3 + c', 'ប្រើប្រាស់វិធីអាំងតេក្រាលដោយផ្នែកដោយតាង u = ln x និង dv = x^2 dx ទទួលបាន (1/3)x^3 ln x - (1/9)x^3 + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៧')
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

DELETE FROM answer_option WHERE question_id = 178;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (178, '(1/3)x^3 ln x - (1/9)x^3 + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (178, '(1/3)x^3 ln x + (1/9)x^3 + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (178, 'x^3 ln x - x^3 + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (178, '(1/2)x^2 ln x - (1/4)x^2 + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (179, 13, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលមិនកំណត់៖ J = ∫ (sin 2x - cos x) / cos x dx', 'multiple_choice', 'medium', '-2 cos x - x + c', 'បំបែក sin 2x = 2 sin x cos x រួចសម្រួលជាមួយ cos x ទទួលបាន ∫(2 sin x - 1)dx = -2 cos x - x + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៧')
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

DELETE FROM answer_option WHERE question_id = 179;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (179, '-2 cos x - x + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (179, '2 sin x - x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (179, '-2 sin x + x + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (179, '2 cos x + x + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (180, 20, 'elementary', 'Mathematics', 'គេចង់ជ្រើសរើសសិស្ស 3 នាក់ ក្នុងចំណោមសិស្ស 12 នាក់ ដែលក្នុងនោះមានសិស្សប្រុស 7 នាក់ និងសិស្សស្រី 5 នាក់។ រកប្រូបាបដែលគេជ្រើសរើសបានសិស្សប្រុស 2 នាក់ និងសិស្សស្រី 1 នាក់។', 'multiple_choice', 'medium', '21/44', 'គណនាចំនួនករណីស្រប C(7,2)*C(5,1) ចែកនឹងចំនួនករណីសរុប C(12,3) ទទួលបាន 21/44.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៧')
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

DELETE FROM answer_option WHERE question_id = 180;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (180, '21/44', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (180, '5/33', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (180, '7/22', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (180, '1/4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (181, 19, 'elementary', 'Mathematics', 'រកចម្ងាយពីគល់តម្រុយ O ទៅប្លង់ (P): 2x + 3y + z - 12 = 0', 'multiple_choice', 'easy', '6*sqrt(14) / 7', 'ជំនួសកូអរដោនេ O(0,0,0) ចូលក្នុងរូបមន្តចម្ងាយពីចំណុចទៅប្លង់ ទទួលបាន 12 / sqrt(14) = 6*sqrt(14) / 7.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៧')
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

DELETE FROM answer_option WHERE question_id = 181;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (181, '6*sqrt(14) / 7', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (181, '12 / sqrt(14)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (181, 'sqrt(14) / 6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (181, '6 / 7', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (182, 11, 'elementary', 'Mathematics', 'រកដែនកំណត់នៃអនុគមន៍ y = log(1 - sqrt(4 - x^2))', 'multiple_choice', 'medium', '[-2, -sqrt(3)) U (sqrt(3), 2]', 'ដោះស្រាយប្រព័ន្ធវិសមីការ 4 - x^2 >= 0 និង 1 - sqrt(4 - x^2) > 0 ទទួលបានដែនកំណត់ D = [-2, -sqrt(3)) U (sqrt(3), 2].', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៨')
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

DELETE FROM answer_option WHERE question_id = 182;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (182, '[-2, -sqrt(3)) U (sqrt(3), 2]', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (182, '[-2, 2]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (182, '(-sqrt(3), sqrt(3))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (182, '[-2, -1] U [1, 2]', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (183, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ J = ∫ dx / (x^2 - 5x + 6)', 'multiple_choice', 'medium', 'ln| (x-3)/(x-2) | + c', 'បំបែកភាគបែងជាកត្តា (x-2)(x-3) រួចគណនាអាំងតេក្រាលទទួលបាន ln| (x-3)/(x-2) | + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៨')
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

DELETE FROM answer_option WHERE question_id = 183;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (183, 'ln| (x-3)/(x-2) | + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (183, 'ln|x^2 - 5x + 6| + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (183, '1/(x-3) - 1/(x-2) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (183, 'ln| (x-2)/(x-3) | + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (184, 13, 'elementary', 'Mathematics', 'គណនាផ្ទៃក្រឡានៃផ្នែកប្លង់ដែលខណ្ឌដោយខ្សែកោង y = x^3 - x^2 - 2x និងអ័ក្សអាប់ស៊ីស។', 'multiple_choice', 'medium', '37/12', 'បែងចែកតំបន់អាំងតេក្រាលតាមចន្លោះ [-1, 0] និង [0, 2] ទទួលបានផ្ទៃក្រឡាស្មើនឹង 37/12.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៨')
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

DELETE FROM answer_option WHERE question_id = 184;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (184, '37/12', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (184, '5/12', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (184, '8/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (184, '11/4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (185, 20, 'elementary', 'Mathematics', '្នុងថង់មួយមានប៊ូលស 7 និងប៊ូលពណ៌ខ្មៅ 10 ។ គេចាប់យកចេញនូវប៊ូលពីរជាមួយគ្នា ។ តើគេមានប៉ុន្មានរបៀប ដើម្បីចាប់យកប៊ូលចេញឱ្យបានយ៉ាងតិចបំផុតនូវប៊ូលសមួយ?', 'multiple_choice', 'medium', '91', 'ចំនួនរបៀបគឺ C(7,1)*C(10,1) + C(7,2) = 70 + 21 = 91 របៀប.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៨')
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

DELETE FROM answer_option WHERE question_id = 185;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (185, '91', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (185, '70', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (185, '21', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (185, '136', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (186, 12, 'elementary', 'Mathematics', 'ស្វ៊ែរមួយមានប្រវែងកាំ 9dm ។ កោណមួយចារឹកក្នុងស្វ៊ែរនោះ ។ រកកម្ពស់នៃកោណ ដើម្បីឱ្យកោណនោះមានមាឌអតិបរមា។', 'multiple_choice', 'hard', '12 dm', 'តាងកម្ពស់ h = x + 9 រួចបង្កើតអនុគមន៍មាឌ V(x) ហើយរកតម្លៃអតិបរមា ទទួលបានកម្ពស់ h = 12 dm.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៨')
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

DELETE FROM answer_option WHERE question_id = 186;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (186, '12 dm', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (186, '9 dm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (186, '15 dm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (186, '18 dm', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (187, 17, 'elementary', 'Mathematics', 'គណនាចំនួនកុំផ្លិច៖ z = ((1+i)/sqrt(2))^{2002} + ((1+i)/(1-i))^{2001}', 'multiple_choice', 'medium', '2i', 'បំប្លែកកន្សោមនីមួយៗជាទម្រង់ត្រីកោណមាត្រឬស្វ័យគុណនៃ i ទទួលបានលទ្ធផលស្មើនឹង 2i.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៩')
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

DELETE FROM answer_option WHERE question_id = 187;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (187, '2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (187, '-2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (187, '1 + i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (187, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (188, 14, 'elementary', 'Mathematics', 'កំណត់តម្លៃ m ដើម្បីឱ្យវិសមីការ (x^2 - 8x + 20) / (mx^2 + 2(m+1)x + 9m + 4) < 0 ចំពោះគ្រប់ x ជារបស់ IR ។', 'multiple_choice', 'hard', 'm < -1/2', 'ដោយភាគយកវិជ្ជមានជានិច្ច ភាគបែងត្រូវតែអវិជ្ជមានគ្រប់ x ដែលផ្តល់លទ្ធផល m < -1/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៩')
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

DELETE FROM answer_option WHERE question_id = 188;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (188, 'm < -1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (188, 'm > 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (188, '-1/2 < m < 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (188, 'm < 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (189, 20, 'elementary', 'Mathematics', 'តើគេអាចបង្កើតគណៈកម្មការដែលមានសមាជិក 5 នាក់ ក្នុងចំណោមមនុស្សទាំងអស់ 15 នាក់ ដោយមាន A និង B ចូលរួមទាំងពីរនាក់ ឬអត់សោះ បានប៉ុន្មានរបៀប?', 'multiple_choice', 'medium', '1573', 'គណនាចំនួនរបៀបដោយបែងចែកជាករណី C(13,5) + C(13,3)*C(2,2) ទទួលបាន 1573 របៀប.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៩')
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

DELETE FROM answer_option WHERE question_id = 189;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (189, '1573', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (189, '1287', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (189, '3003', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (189, '792', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (190, 19, 'elementary', 'Mathematics', 'ក្នុងតម្រុយអរតូណរម៉ាល់ គេឱ្យប្លង់ (P) កាត់តាមចំណុច A(1,0,0), B(0,2,0) និង C(0,0,3) ។ គណនាចម្ងាយ |OI| ពីគល់ O មកប្លង់ (P) ។', 'multiple_choice', 'medium', '6/7', 'រកសមីការប្លង់ 6x + 3y + 2z - 6 = 0 រួចគណនាចម្ងាយពី O(0,0,0) មកប្លង់ ទទួលបាន 6/7.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០០៩')
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

DELETE FROM answer_option WHERE question_id = 190;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (190, '6/7', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (190, '1/7', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (190, '7/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (190, '3/7', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (191, 18, 'elementary', 'Mathematics', 'អនុគមន៍ y = x cos x ។ ស្រាយបញ្ជាក់ថា y'''' + y + 2 sin x = 0 តើដេរីវេទីពីរ y'''' ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-2 sin x - x cos x', 'គណនាដេរីវេទីពីរ y'''' = -2 sin x - x cos x ជំនួសចូលលក្ខខណ្ឌឃើញថាផ្ទៀងផ្ទាត់ស្មើនឹងសូន្យ.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១០')
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

DELETE FROM answer_option WHERE question_id = 191;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (191, '-2 sin x - x cos x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (191, '-x cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (191, '2 sin x + x cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (191, '-2 cos x + x sin x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (192, 16, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ៖ 4 cos^2 x - 1 = 3 cos x - 2 sin^2 x', 'multiple_choice', 'medium', 'x = 2k*pi និង x = ±pi/3 + 2k''*pi', 'បំប្លែក sin^2 x ជា 1 - cos^2 x ទទួលបានសមីការឌីក្រេទីពីរចំពោះ cos x ដែលមានឫស cos x = 1 និង cos x = 1/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១០')
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

DELETE FROM answer_option WHERE question_id = 192;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (192, 'x = 2k*pi និង x = ±pi/3 + 2k''*pi', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (192, 'x = k*pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (192, 'x = ±pi/6 + 2k*pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (192, 'គ្មានចម្លើយ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (193, 12, 'elementary', 'Mathematics', 'ប្រអប់មួយមានរាងជាប្រលេពីប៉ែតកែង ដែលមានប្រវែងទ្រនុងទាំងបីគឺ x, y, x+y (គិតជា cm) ។ គេដឹងថាទ្រនុងដែលវែងជាងគេមានប្រវែង 20cm ។ កំណត់តម្លៃ x និង y ដើម្បីឱ្យប្រអប់នេះមានមាឌធំបំផុត។', 'multiple_choice', 'medium', 'x = 10 cm, y = 10 cm', 'ដោយទ្រនុងវែងបំផុតគឺ x + y = 20 នោះ y = 20 - x, គណនាអនុគមន៍មាឌ V(x) = 20x(20-x) រួកស្វែងរកតម្លៃអតិបរមាទទួលបាន x = 10 និង y = 10.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១០')
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

DELETE FROM answer_option WHERE question_id = 193;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (193, 'x = 10 cm, y = 10 cm', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (193, 'x = 5 cm, y = 15 cm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (193, 'x = 12 cm, y = 8 cm', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (193, 'សមមូលគ្រប់តម្លៃ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (194, 20, 'elementary', 'Mathematics', 'គេមានលេខ 0, 1, 2, 3, 4 ។ គេយកលេខទាំងនេះទៅបង្កើតចំនួនដែលធំជាង 2000 និងក្នុងចំនួននីមួយៗគ្មានលេខដដែលពីរដងទេ ។ តើគេអាចបង្កើតចំនួនធំជាង 2000 បានប៉ុន្មាន?', 'multiple_choice', 'hard', '168', 'បែងចែកករណីចំនួន ៤ ខ្ទង់ (72 ចំនួន) និងចំនួន ៥ ខ្ទង់ (96 ចំនួន) បូកបញ្ចូលគ្នាទទួលបាន 168 ចំនួន.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១០')
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

DELETE FROM answer_option WHERE question_id = 194;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (194, '168', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (194, '120', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (194, '96', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (194, '72', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (195, 19, 'elementary', 'Mathematics', 'សរសេរសមីការប្លង់ (P) កាត់តាមចំណុច A(1,1,1) និងមានវ៉ិចទ័រណរម៉ាល់ OA (ដោយ O ជាគល់តម្រុយ)', 'multiple_choice', 'easy', 'x + y + z - 3 = 0', 'វ៉ិចទ័រ OA = (1,1,1) ជំនួសចូលសមីការប្លង់កាត់តាម A ទទួលបាន x + y + z - 3 = 0.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១០')
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

DELETE FROM answer_option WHERE question_id = 195;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (195, 'x + y + z - 3 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (195, 'x + y + z + 3 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (195, 'x - y - z = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (195, '2x + y + z - 4 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (196, 17, 'elementary', 'Mathematics', 'គេឱ្យចំនួនកុំផ្លិច Z = cos(2pi/5) + i sin(2pi/5) ។ គណនា Z^5 រួចទាញរកតម្លៃនៃ 1 + Z + Z^2 + Z^3 + Z^4', 'multiple_choice', 'medium', 'Z^5 = 1 និង tổng = 0', 'តាមរូបមន្តម័រ Z^5 = cos(2pi) + i sin(2pi) = 1 ហើយផលបូកស្វ៊ីតធរណីមាត្រ 1 + Z + ... + Z^4 = (1 - Z^5)/(1 - Z) = 0.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១១')
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

DELETE FROM answer_option WHERE question_id = 196;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (196, 'Z^5 = 1 និង tổng = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (196, 'Z^5 = -1 និង tổng = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (196, 'Z^5 = 1 និង tổng = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (196, 'Z^5 = 0 និង tổng = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (197, 12, 'elementary', 'Mathematics', 'រង្វង់មួយ និងការេមួយមានផលបូកប្រវែងបរិមាត្រស្មើនឹង 16 m ។ រកប្រវែងកាំរបស់រង្វង់ (r) និងជ្រុងរបស់ការេ (a) ដើម្បីឱ្យផលបូកផ្ទៃក្រឡារង្វង់ និងផ្ទៃក្រឡាការេមានតម្លៃអប្បរមា។', 'multiple_choice', 'hard', 'r = 8 / (4 + pi) និង a = 16 / (4 + pi)', 'បង្កើតអនុគមន៍ផ្ទៃក្រឡាសរុប S(r) = pi*r^2 + (4 - (pi/2)r)^2 រួចរកអប្បបរមា ទទួលបាន r = 8/(4+pi) និង a = 16/(4+pi).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១១')
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

DELETE FROM answer_option WHERE question_id = 197;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (197, 'r = 8 / (4 + pi) និង a = 16 / (4 + pi)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (197, 'r = 4 / (4 + pi) និង a = 8 / (4 + pi)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (197, 'r = 2 និង a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (197, 'r = 16 / (4 + pi) និង a = 8 / (4 + pi)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (198, 20, 'elementary', 'Mathematics', 'គេប្រមៀលប៊ូលដែលមានសរសេរលេខ 1, 2, 3, 4, 5, 6 តម្រង់ទៅរន្ធ 6 ដែលមានសរសេរលេខ 1, 2, 3, 4, 5, 6 ដែរ (ចូលរន្ធខុសៗគ្នាជានិច្ច) ។ គណនាប្រូបាបដើម្បីឱ្យប៊ូលលេខ 3 ចូលរន្ធលេខ 3 ។', 'multiple_choice', 'easy', '1/6', 'ចំនួនករណីស្រប n(A) = 1 និងចំនួនករណីសរុប n(S) = 6 ដូច្នេះ P(A) = 1/6.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១១')
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

DELETE FROM answer_option WHERE question_id = 198;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (198, '1/6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (198, '1/720', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (198, '1/36', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (198, '5/6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (199, 14, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = a*e^x + b មានខ្សែកោង (C) ។ កំណត់តម្លៃ a និង b ដើម្បីឱ្យខ្សែកោង (C) កាត់តាមគល់តម្រុយ និងបន្ទាត់ប៉ះខ្សែកោង (C) ត្រង់ចំណុចនោះមានសមីការ y = x ។', 'multiple_choice', 'medium', 'a = 1, b = -1', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌ f(0) = 0 និង f''(0) = 1 ទទួលបាន a = 1 និង b = -1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១១')
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

DELETE FROM answer_option WHERE question_id = 199;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (199, 'a = 1, b = -1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (199, 'a = 1, b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (199, 'a = -1, b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (199, 'a = 2, b = -2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (200, 17, 'elementary', 'Mathematics', 'សរសេរចំនួនកុំផ្លិច z = (sqrt(2) - i*sqrt(2))(cos(pi/6) - i sin(pi/6)) ជាទម្រង់ពីជគណិត។', 'multiple_choice', 'medium', '((sqrt(6) - sqrt(2)) / 2) - ((sqrt(6) + sqrt(2)) / 2)i', 'គុណចំនួនកុំផ្លិចទាំងពីរក្នុងទម្រង់ពីជគណិត ទទួលបាន ((sqrt(6) - sqrt(2)) / 2) - ((sqrt(6) + sqrt(2)) / 2)i.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 200;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (200, '((sqrt(6) - sqrt(2)) / 2) - ((sqrt(6) + sqrt(2)) / 2)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (200, '((sqrt(6) + sqrt(2)) / 2) + ((sqrt(6) - sqrt(2)) / 2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (200, 'sqrt(6) - i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (200, '((sqrt(2) - sqrt(6)) / 2) + i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (201, 16, 'elementary', 'Mathematics', 'គណនាតម្លៃនៃ cos(5pi/12) តាមរយៈការប្រៀបធៀបចំនួនកុំផ្លិច z។', 'multiple_choice', 'medium', '(sqrt(6) - sqrt(2)) / 4', 'ផ្ទឹមផ្នែកពិតនៃទម្រង់ពីជគណិតនិងទម្រង់ត្រីកោណមាត្រ ទទួលបាន cos(5pi/12) = (sqrt(6) - sqrt(2)) / 4.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 201;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (201, '(sqrt(6) - sqrt(2)) / 4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (201, '(sqrt(6) + sqrt(2)) / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (201, 'sqrt(3)/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (201, '1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (202, 13, 'elementary', 'Mathematics', 'កំណត់តម្លៃនៃ a ដើម្បីឱ្យអនុគមន៍ f(x) = (x sin x + x^2) / (x^3 - sin^2 x) ជាប់ត្រង់ x = 0 ដោយដឹងថា f(0) = ln(sqrt(a))។', 'multiple_choice', 'hard', '1 / e^4', 'គណនាលីមីត f(x) កាលណា x -> 0 ឃើញថាស្មើនឹង -2 ដូច្នេះ ln(sqrt(a)) = -2 ដែលផ្តល់ a = e^{-4}.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 202;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (202, '1 / e^4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (202, 'e^4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (202, '1 / e^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (202, 'e^{-2}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (203, 20, 'elementary', 'Mathematics', '្នុងប្រអប់មួយមានឃ្លីពណ៌ខៀវ 7 គ្រាប់ និងពណ៌ក្រហម 5 គ្រាប់ ។ គេចាប់យកឃ្លី 4 គ្រាប់ដោយចៃដន្យ ។ រកប្រូបាបដែលចាប់បានឃ្លីពណ៌ខៀវទាំង 4 គ្រាប់។', 'multiple_choice', 'medium', '7/99', 'ប្រូបាបគណនាដោយ C(7,4) / C(12,4) = 35 / 495 = 7/99.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 203;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (203, '7/99', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (203, '35/99', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (203, '1/12', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (203, '14/99', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (204, 12, 'elementary', 'Mathematics', 'ប្រអប់មួយមានរាងជាប្រលេពីប៉ែតកែងដែលមានវិមាត្រ x, 2x និង h គិតជាម៉ែត្រ ហើយមានផ្ទៃក្រឡាទាំងអស់ 1 m^2 ។ កំណត់តម្លៃនៃ x ដើម្បីឱ្យប្រអប់មានមាឌធំបំផុត។', 'multiple_choice', 'hard', 'sqrt(3) / 6', 'រក h ជាអនុគមន៍នៃ x គឺ h = (1 - 4x^2)/(6x) រួចរកតម្លៃអតិបរមា លទ្ធផលគឺ x = sqrt(3)/6.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 204;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (204, 'sqrt(3) / 6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (204, '1 / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (204, 'sqrt(2) / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (204, '1 / 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (205, 19, 'elementary', 'Mathematics', 'ក្នុងតម្រុយ (O, i, j, k) មាន A(2,0,1), B(0,1,-3) និង C(1,2,0) ។ គណនាផលគុណវ៉ិចទ័រ n = AB x AC។', 'multiple_choice', 'medium', '7i + 2j - 3k', 'គណនាឌីណូម៉ែនដេមីណង់វ៉ិចទ័រ AB = (-2,1,-4) និង AC = (-1,2,-1) ទទួលបាន 7i + 2j - 3k.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 205;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (205, '7i + 2j - 3k', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (205, '7i - 2j + 3k', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (205, '2i + 7j - 3k', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (205, '-7i + 2j + 3k', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (206, 11, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = x + 2 + 4/(x - 1) មានក្រាបតំណាង (C) ។ រកសមីការអាស៊ីមតូតទ្រេតនៃក្រាប (C)។', 'multiple_choice', 'easy', 'y = x + 2', 'ដោយលីមីតនៃកន្សោមសន្និដ្ឋានផ្នែកខភាគសនិទានចូលសូន្យកាលណា x -> infinity នោះអាស៊ីមតូតទ្រេតគឺ y = x + 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១២')
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

DELETE FROM answer_option WHERE question_id = 206;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (206, 'y = x + 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (206, 'y = x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (206, 'y = x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (206, 'y = 2x + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (207, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ ∫ x^{2001} / (1 + x^2)^{1002} dx', 'multiple_choice', 'hard', '(1 / 2002) * (x^2 / (1 + x^2))^{1001} + c', 'បំប្លែកអាំងតេក្រាលនិងប្រើវិធីប្តូរអថេរ t = x^2 / (1 + x^2) ទទួលបាន (1 / 2002) * (x^2 / (1 + x^2))^{1001} + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 207;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (207, '(1 / 2002) * (x^2 / (1 + x^2))^{1001} + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (207, '(1 / 2001) * (1 / (1 + x^2))^{1001} + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (207, '(1 / 1002) * (x / (1 + x^2))^{1002} + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (207, 'ln(1 + x^2)^{1001} + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (208, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ ∫ (3x - 11) / (x^2 - 6x + 9) dx', 'multiple_choice', 'medium', '3 ln|x - 3| + 2 / (x - 3) + c', 'បំបែកភាគបែងជា (x-3)^2 និងប្រើវិធីបំបែកប្រភាគសនិទាន ទទួលបាន 3 ln|x - 3| + 2 / (x - 3) + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 208;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (208, '3 ln|x - 3| + 2 / (x - 3) + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (208, '3 ln|x - 3| - 2 / (x - 3) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (208, 'ln(x^2 - 6x + 9) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (208, '-3 ln|x - 3| + 2 / (x - 3) + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (209, 13, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = x^2 + 2x និង g(x) = -x + 4 ។ គណនាមាឌនៃសូលីតបរិវត្តកំណត់ដោយរង្វិលជុំវិញអ័ក្សអាប់ស៊ីស (x''ox) នៃផ្ទៃក្រឡាខ័ណ្ឌដោយក្រាបទាំងពីរ។', 'multiple_choice', 'hard', '125pi', 'រកចំណុចប្រសព្វ x = -4 និង x = 1 រួចគណនាមាឌតាមរូបមន្ត V = pi * ∫[g(x)^2 - f(x)^2] dx ទទួលបាន 125pi.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 209;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (209, '125pi', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (209, '64pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (209, '250pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (209, '100pi', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (210, 11, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (x^2 - 3x + 4) / (2x - 2) ។ រកសមីការអាស៊ីមតូតឈរនៃក្រាប (C)។', 'multiple_choice', 'easy', 'x = 1', 'ភាគបែងស្មើនឹងសូន្យកាលណា 2x - 2 = 0 ដែលផ្តល់អាស៊ីមតូតឈរ x = 1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 210;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (210, 'x = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (210, 'x = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (210, 'x = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (210, 'y = 1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (211, 12, 'elementary', 'Mathematics', 'ចូរសរសេរសមីការស្តង់ដានៃប៉ារ៉ាបូលដែលមានកំពូលនៅ O(0,0) កំណុំនៅលើអ័ក្សអាប់ស៊ីស និងកាត់តាមចំណុច A(-2,4)។', 'multiple_choice', 'medium', 'y^2 = -8x', 'ជំនួសកូអរដោនេ (-2,4) ក្នុងសមីការស្តង់ដា y^2 = 4px ទទួលបាន p = -2 ដូច្នេះ y^2 = -8x.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 211;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (211, 'y^2 = -8x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (211, 'y^2 = 8x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (211, 'x^2 = -2y', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (211, 'y^2 = -4x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (212, 12, 'elementary', 'Mathematics', 'រកតម្លៃនៃ y_2 បើដឹងថាចំណុច A_2(-3, y_2) ស្ថិតនៅលើប៉ារ៉ាបូល y^2 = -8x ។', 'multiple_choice', 'easy', '±2*sqrt(6)', 'ជំនួស x = -3 ក្នុងសមីការ y^2 = -8(-3) = 24 ដូច្នេះ y_2 = ±2*sqrt(6).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 212;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (212, '±2*sqrt(6)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (212, '±6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (212, '±4*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (212, '2*sqrt(6)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (213, 12, 'elementary', 'Mathematics', 'រកសមីការនៃបន្ទាត់ប្រាប់ទិស (Δ) របស់ប៉ារ៉ាបូល y^2 = -8x ។', 'multiple_choice', 'easy', 'x = 2', 'ពីសមីការ y^2 = 4px គេបាន p = -2 ដូច្នេះសមីការបន្ទាត់ប្រាប់ទិសគឺ x = -p = 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៣')
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

DELETE FROM answer_option WHERE question_id = 213;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (213, 'x = 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (213, 'x = -2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (213, 'y = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (213, 'x = 4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (214, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ A = lim (x->1+) (|x+1| + 2)', 'multiple_choice', 'easy', '4', 'ជំនួសតម្លៃ x = 1 ចូលក្នុងកន្សោម ទទួលបាន |1+1| + 2 = 4.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 214;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (214, '4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (214, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (214, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (214, '5', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (215, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ B = lim (x->+infinity) (2x^3 + 3x + 1) / (x^3 - 2x^2 + 5)', 'multiple_choice', 'easy', '2', 'ចាត់ចែងតួដែលមានដឺក្រេខ្ពស់ជាងគេទាំងភាគយកនិងភាគបែង ទទួលបានលទ្ធផលស្មើនឹង 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 215;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (215, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (215, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (215, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (215, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (216, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ C = lim (x->3) (x^2 - 9) / (x - 3)', 'multiple_choice', 'easy', '6', 'បំបែកភាគយកជា (x-3)(x+3) រួចសម្រួលជាមួយភាគបែង ទទួលបានលទ្ធផលស្មើនឹង 6.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 216;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (216, '6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (216, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (216, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (216, '9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (217, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលកំណត់៖ A = ∫ từ 1 đến 2 của (x^2 + 3x + 2) dx', 'multiple_choice', 'medium', '53/6', 'រកព្រីមីទីវរួចជំនួសតម្លៃដែនកំណត់ 1 និង 2 ទទួលបានលទ្ធផលស្មើនឹង 53/6.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 217;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (217, '53/6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (217, '38/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (217, '23/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (217, '10', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (218, 14, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ៖ 9^{-2|x|} = 1 / 81', 'multiple_choice', 'easy', '±1', 'សរសេរ 1/81 ជា 9^{-2} នោះ -2|x| = -2 ដែលផ្តល់ |x| = 1 ឬ x = ±1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 218;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (218, '±1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (218, '±2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (218, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (218, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (219, 11, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = (x^2 - mx + m) / (x - 1) ។ កំណត់តម្លៃ m ដើម្បីឱ្យចំណុច A(1, 2) ជាផ្ចិតឆ្លុះរបស់ខ្សែកោង (C) នៃ f(x) ។', 'multiple_choice', 'medium', '0', 'តាមលក្ខខណ្ឌផ្ចិតឆ្លុះ f(2-a - x) + f(x) = 2b (ឬជំនួសលក្ខខណ្ឌសមមូល) ទទួលបាន m = 0.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 219;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (219, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (219, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (219, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (219, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (220, 12, 'elementary', 'Mathematics', 'គេមានសមីការអេលីប៖ 25x^2 + 9y^2 = 225 ។ តើប្រវែងអ័ក្សធំរបស់អេលីបនេះស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '10', 'បំប្លែងសមីការជាទម្រង់ស្តង់ដា x^2/3^2 + y^2/5^2 = 1 ដែលមាន a = 5 ដូច្នេះប្រវែងអ័ក្សធំ 2a = 10.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៤')
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

DELETE FROM answer_option WHERE question_id = 220;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (220, '10', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (220, '6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (220, '5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (220, '3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (221, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ A = lim (x->+infinity) (2x^2 - 2x - 1) / (x^2 + 1)', 'multiple_choice', 'easy', '2', 'ចាត់ចែងតួដែលមានដឺក្រេខ្ពស់ជាងគេ ទទួលបានលទ្ធផលស្មើនឹង 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 221;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (221, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (221, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (221, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (221, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (222, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ B = lim (x->-1) ((x+1)(x^2-x+1)) / ((x+1)(2x+1))', 'multiple_choice', 'easy', '-3', 'សម្រួលកត្តា (x+1) រួចជំនួសតម្លៃ x = -1 ទទួលបាន (-3) / (-1) = -3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 222;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (222, '-3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (222, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (222, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (222, '-1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (223, 17, 'elementary', 'Mathematics', 'សរសេរចំនួនកុំផ្លិច Z = (sqrt(3)/2) + (1/2)i ជាទម្រង់ត្រីកោណមាត្រ។', 'multiple_choice', 'easy', 'cos(pi/6) + i sin(pi/6)', 'រកម៉ូឌុលនិងអាគុយម៉ង់ ទទួលបាន cos(pi/6) + i sin(pi/6).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 223;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (223, 'cos(pi/6) + i sin(pi/6)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (223, 'cos(pi/3) + i sin(pi/3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (223, 'cos(pi/4) + i sin(pi/4)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (223, 'cos(pi/2) + i sin(pi/2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (224, 17, 'elementary', 'Mathematics', 'គណនា Z^2 នៃចំនួនកុំផ្លិច Z = cos(pi/6) + i sin(pi/6) រួចសរសេរជាទម្រង់ត្រីកោណមាត្រ។', 'multiple_choice', 'easy', 'cos(pi/3) + i sin(pi/3)', 'តាមរូបមន្តម័រ Z^2 = cos(2*pi/6) + i sin(2*pi/6) = cos(pi/3) + i sin(pi/3).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 224;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (224, 'cos(pi/3) + i sin(pi/3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (224, 'cos(pi/6) + i sin(pi/6)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (224, 'cos(pi/2) + i sin(pi/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (224, 'cos(pi) + i sin(pi)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (225, 11, 'elementary', 'Mathematics', 'កំណត់តម្លៃ k ដើម្បីឱ្យខ្សែកោង (C) នៃអនុគមន៍ f(x) = (kx^2 - 5x + 7) / (kx - 2) ប៉ះបន្ទាត់ y = 1។', 'multiple_choice', 'hard', '1 និង 25', 'ផ្ទឹមសមីការអាប់ស៊ីសជាមួយ y = 1 ហើយកំណត់លក្ខខណ្ឌ delta = 0 ទទួលបាន k = 1 ឬ k = 25.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 225;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (225, '1 និង 25', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (225, '2 និង 10', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (225, '-1 និង -25', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (225, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (226, 19, 'elementary', 'Mathematics', '្នុងតម្រុយអរតូណរម៉ាល់ (O,i,j,k) នៃលំហ គេមានបីចំណុច A(1,2,1), B(2,0,3) និង C(-1,2,0) ។ គណនាផ្ទៃក្រឡានៃត្រីកោណ ABC។', 'multiple_choice', 'medium', 'sqrt(29) / 2', 'គណនាផលគុណវ៉ិចទ័រ AB x AC = 2i - 3j - 4k រួចរកផ្ទៃក្រឡា S = (1/2)*|AB x AC| = sqrt(29)/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 226;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (226, 'sqrt(29) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (226, 'sqrt(29)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (226, 'sqrt(30) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (226, '14', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (227, 12, 'elementary', 'Mathematics', 'ប៉ារ៉ាបូលមួយមានកំពូលនៅត្រង់ចំណុច (0,0) និងកំណុំស្ថិតនៅលើអ័ក្សអាប់ស៊ីស (x''x) ដោយដឹងថាកាត់តាមចំណុច A(4,8) ។ រកសមីការស្តង់ដានៃប៉ារ៉ាបូលនេះ។', 'multiple_choice', 'easy', 'y^2 = 16x', 'ជំនួសកូអរដោនេ (4,8) ក្នុងសមីការ y^2 = 4px ទទួលបាន p = 4 ដូច្នេះ y^2 = 16x.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៥')
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

DELETE FROM answer_option WHERE question_id = 227;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (227, 'y^2 = 16x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (227, 'y^2 = 8x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (227, 'x^2 = 2y', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (227, 'y^2 = 4x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (228, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->2) (x^2 - 3x + 2) / (x^2 - x - 2)', 'multiple_choice', 'easy', '1/3', 'បំបែកភាគយកនិងភាគបែងជាកត្តា (x-2)(x-1) និង (x-2)(x+1) រួចសម្រួលទទួលបាន 1/3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 228;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (228, '1/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (228, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (228, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (228, '2/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (229, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->0) (sin 2x) / (sin 3x)', 'multiple_choice', 'medium', '2/3', 'ចាត់ចែងកន្សោមលីមីតដោយគុណនិងចែកនឹង 2x និង 3x ទទួលបានលទ្ធផល 2/3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 229;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (229, '2/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (229, '3/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (229, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (229, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (230, 17, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការក្នុងសំណុំចំនួនកុំផ្លិច៖ -3x^2 + 2x - 1 = 0', 'multiple_choice', 'medium', '(1/3) ∓ i*(sqrt(2)/3)', 'គណនាឌីសគ្រីមណង់ delta'' = -2 ទទួលបានឫស x = (1 ± i*sqrt(2))/3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 230;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (230, '(1/3) ∓ i*(sqrt(2)/3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (230, '1 ∓ i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (230, '-1/3 ∓ i*(sqrt(2)/3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (230, '± (1/3)i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (231, 20, 'elementary', 'Mathematics', 'អ្នកគ្រូបុប្ផាធ្វើប័ណ្ណលេខចំនួន 9 សន្លឹក (ពីលេខ 1 ដល់ 9) ។ ក្រុមសិស្សចាប់យកប័ណ្ណលេខចំនួន 2 សន្លឹក រួចគណនាផលគុណ ។ រកប្រូបាបនៃការចាប់បានប័ណ្ណ 2 សន្លឹកដែលផលគុណជាចំនួនគូ។', 'multiple_choice', 'hard', '13/18', 'ប្រូបាបគណនាដោយយក 1 ដកនឹងប្រូបាបដែលផលគុណជាចំនួនសេស (គណនាករណីសេសទាំងពីរ) ទទួលបាន 13/18.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 231;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (231, '13/18', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (231, '5/18', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (231, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (231, '7/9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (232, 11, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = x^3 - 3x + 1 ។ រកតម្លៃអតិបរមាធៀបរបស់អនុគមន៍នេះ។', 'multiple_choice', 'easy', '3', 'ដេរីវេ f''(x) = 3x^2 - 3 ផ្តល់អាប់ស៊ីសបរមា x = -1 ដែលផ្តល់តម្លៃ f(-1) = 3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 232;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (232, '3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (232, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (232, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (232, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (233, 12, 'elementary', 'Mathematics', 'គេមានអេលីប (E) ដែលមានចំណុចកំណុំ F1(1, -3), F2(1, 1) ។ រកចម្ងាយពីផ្ចិតអេលីបទៅចំណុចកំណុំរបស់វា (c)។', 'multiple_choice', 'easy', '2', 'ចម្ងាយរវាងកំណុំទាំងពីរគឺ F1F2 = 4 ដូច្នេះចម្ងាយពីផ្ចិតទៅកំណុំ c = F1F2 / 2 = 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 233;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (233, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (233, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (233, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (233, '2*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (234, 19, 'elementary', 'Mathematics', 'សរសេរសមីការទូទៅនៃប្លង់ (P) កាត់តាម 3 ចំណុច I(3, -1, 5), M(4, 2, -1) និង N(1, -2, 3)។', 'multiple_choice', 'medium', '-12x + 14y + 5z + 25 = 0', 'រកវ៉ិចទ័រណរម៉ាល់តាមរយៈផលគុណ IM x IN ទទួលបាន -12i + 14j + 5k និងសមីការប្លង់ -12x + 14y + 5z + 25 = 0.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៦')
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

DELETE FROM answer_option WHERE question_id = 234;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (234, '-12x + 14y + 5z + 25 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (234, '12x - 14y - 5z - 25 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (234, 'x + y + z - 7 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (234, '-3x + 3y - 2z + 1 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (235, 11, 'elementary', 'Mathematics', 'រកដែនកំណត់នៃអនុគមន៍ f(x) = sqrt((|x| - 1) / (2 - |x|))', 'multiple_choice', 'medium', '[-2, -1] U [1, 2)', 'ដោះស្រាយលក្ខខណ្ឌក្រោមរ៉ាឌីកាល់ធំជាង ឬស្មើនឹងសូន្យ និងភាគបែងខុសពីសូន្យ ទទួលបានដែនកំណត់ D = [-2, -1] U [1, 2).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 235;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (235, '[-2, -1] U [1, 2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (235, '(-2, 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (235, '[-1, 1]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (235, '(-2, -1] U [1, 2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (236, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->+infinity) (3x^2 - 2x + 1) / (2x^2 - 3x + 2)', 'multiple_choice', 'easy', '3/2', 'ចាត់ចែងតួដែលមានដឺក្រេខ្ពស់ជាងគេ ទទួលបានលទ្ធផលស្មើនឹង 3/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 236;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (236, '3/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (236, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (236, '2/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (236, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (237, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលកំណត់៖ ∫ từ 0 đến 1 của (x / (x + 2)) dx', 'multiple_choice', 'medium', '1 - 2 ln(3/2)', 'បំបែកកន្សោមជា (x + 2 - 2) / (x + 2) រួចគណនាអាំងតេក្រាលទទួលបាន 1 - 2 ln(3/2).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 237;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (237, '1 - 2 ln(3/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (237, '2 ln 3 - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (237, 'ln(3/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (237, '1 + ln 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (238, 17, 'elementary', 'Mathematics', 'រកឫសកុំផ្លិច z1 នៃសមីការ z^2 - 6z + 12 = 0 ដោយដឹងថា z1 មានផ្នែកនិមិត្តវិជ្ជមាន។', 'multiple_choice', 'easy', '3 + i*sqrt(3)', 'គណនាឌីសគ្រីមណង់ delta'' = -3 ទទួលបានឫស z1 = 3 + i*sqrt(3).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 238;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (238, '3 + i*sqrt(3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (238, '3 - i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (238, 'sqrt(3) + 3i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (238, '-3 + i*sqrt(3)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (239, 14, 'elementary', 'Mathematics', 'សរសេរសមីការបន្ទាត់ប៉ះនឹងក្រាប C នៃអនុគមន៍ f(x) = x^3 + 3x^2 - 2 ត្រង់ចំណុចរបត់ I។', 'multiple_choice', 'medium', 'y = -3x - 3', 'រកអាប់ស៊ីសចំណុចរបត់ x = -1, មេគុណប្រាប់ទិស f''(-1) = -3 និង f(-1) = 0 ទទួលបានសមីការបន្ទាត់ប៉ះ y = -3x - 3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 239;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (239, 'y = -3x - 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (239, 'y = 3x + 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (239, 'y = -3x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (239, 'y = x - 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (240, 19, 'elementary', 'Mathematics', '្នុងតម្រុយអរតូណរម៉ាល់ គេមានបីចំណុច A(3,-1,2), B(0,-4,2) និង C(-3,2,1) ។ គណនាបរិមាត្រនៃត្រីកោណ ABC។', 'multiple_choice', 'medium', '3*sqrt(2) + 2*sqrt(46)', 'គណនាប្រវែងជ្រុង AB = 3*sqrt(2), AC = sqrt(46) និង BC = sqrt(46) ដូច្នេះបរិមាត្រគឺ 3*sqrt(2) + 2*sqrt(46).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 240;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (240, '3*sqrt(2) + 2*sqrt(46)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (240, '6*sqrt(2) + sqrt(46)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (240, '3*sqrt(46) + sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (240, '2*sqrt(2) + 3*sqrt(46)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (241, 12, 'elementary', 'Mathematics', 'គេមានប៉ារ៉ាបូល (P) មួយដែលមានកំពូលនៅត្រង់ចំណុច O(0,0) និងមានអ័ក្សឆ្លុះជាអ័ក្សអាប់ស៊ីស ដោយដឹងថាក្រាហ្វិកវាកាត់តាម A(2,4) ។ សរសេរសមីការស្តង់ដានៃប៉ារ៉ាបូលនេះ។', 'multiple_choice', 'easy', 'y^2 = 8x', 'ជំនួសកូអរដោនេ (2,4) ក្នុងសមីការ y^2 = 4px ទទួលបាន p = 2 ដូច្នេះ y^2 = 8x.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ឆ្នាំ ២០១៧')
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

DELETE FROM answer_option WHERE question_id = 241;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (241, 'y^2 = 8x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (241, 'y^2 = 4x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (241, 'x^2 = 2y', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (241, 'y^2 = 16x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (242, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->+infinity) (3x^3 + 2x^2 - x - 3) / (x^3 + 3x + 1)', 'multiple_choice', 'easy', '3', 'ចែកតួដែលមានដឺក្រេខ្ពស់ជាងគេទាំងភាគយកនិងភាគបែងនឹង x^3 ទទួលបានលទ្ធផលស្មើនឹង 3.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 242;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (242, '3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (242, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (242, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (242, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (243, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->+infinity) (sqrt(4x^2 + 3x - 2) - sqrt(x^2 - 2x + 3))', 'multiple_choice', 'medium', '+infinity', 'បំបែករ៉ាឌីកាល់ជា x*(sqrt(4+3/x-2/x^2) - sqrt(1-2/x+3/x^2)) ដែលផ្តល់លទ្ធផលស្មើនឹង +infinity.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 243;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (243, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (243, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (243, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (243, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (244, 14, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ៖ log_3(3x + 1) - log_3(2x - 1) = 3', 'multiple_choice', 'medium', '28/51', 'បំប្លែកសមីការជា log_3((3x+1)/(2x-1)) = 3 រួចដោះស្រាយសមីការសនិទានទទួលបាន x = 28/51.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 244;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (244, '28/51', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (244, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (244, '27/50', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (244, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (245, 14, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ៖ 4(2^{2x}) - 2^x = 1 - 4(2^x)', 'multiple_choice', 'medium', '-2', 'តាង t = 2^x (t > 0) ទទួលបានសមីការ 4t^2 + 3t - 1 = 0 ដែលផ្តល់ t = 1/4 (ឯ x = -2).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 245;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (245, '-2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (245, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (245, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (245, '-1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (246, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ ∫ (2e^x + 3)^2 * e^x dx', 'multiple_choice', 'medium', '(1/6)(2e^x + 3)^3 + c', 'ប្រើប្រាស់វិធីប្តូរអថេរ (ឬពង្រីកកន្សោម) ទទួលបានអាំងតេក្រាលស្មើនឹង (1/6)(2e^x + 3)^3 + c.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 246;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (246, '(1/6)(2e^x + 3)^3 + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (246, '(1/3)(2e^x + 3)^3 + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (246, '(2e^x + 3)^3 + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (246, '(1/2)(2e^x + 3)^2 + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (247, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាលកំណត់៖ ∫ từ 1 đến 2 của ((x^2 - 1) / (x - 1)) dx', 'multiple_choice', 'easy', '5/2', 'សម្រួលភាគយកនិងភាគបែងបាន x + 1 រួចគណនាអាំងតេក្រាលកំណត់ទទួលបាន 5/2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 247;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (247, '5/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (247, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (247, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (247, '7/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (248, 20, 'elementary', 'Mathematics', 'ក្នុងប្រអប់មួយមានក្រដាសពណ៌លឿង 8 សន្លឹក និងក្រដាសពណ៌បៃតង 6 សន្លឹក។ អ្នកគ្រូបុប្ផាចាប់យកក្រដាសពណ៌ 6 សន្លឹកចេញពីប្រអប់ដោយចៃដន្យ។ រកប្រូបាបដែលគាត់ចាប់បានក្រដាស 6 សន្លឹកសុទ្ធតែពណ៌លឿង។', 'multiple_choice', 'medium', '4/429', 'ប្រូបាបគឺ C(8,6) / C(14,6) = 28 / 3003 = 4/429.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋម និងមត្តេយ្យសិក្សា ថ្ងៃទី ២១ ខែ វិច្ឆិកា ឆ្នាំ ២០១៩')
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

DELETE FROM answer_option WHERE question_id = 248;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (248, '4/429', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (248, '28/3003', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (248, '1/14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (248, '8/14', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (249, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->1) (x^3 - x^2 + x - 1) / (x^2 - 1)', 'multiple_choice', 'easy', '1', 'បំបែកភាគយកជា x^2(x-1) + (x-1) = (x-1)(x^2+1) រួចសម្រួលជាមួយភាគបែង (x-1)(x+1) ជំនួសតម្លៃ x = 1 ទទួលបាន 1.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 249;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (249, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (249, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (249, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (249, '1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (250, 13, 'elementary', 'Mathematics', 'គណនាលីមីត៖ lim (x->0) ((sin 5x)(sin 4x)) / (-2x^2)', 'multiple_choice', 'medium', '-10', 'ចាត់ចែងកន្សោមលីមីតជា -(1/2) * (sin 5x / x) * (sin 4x / x) ទទួលបានលទ្ធផលស្មើនឹង -10.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 250;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (250, '-10', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (250, '10', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (250, '-5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (250, '-20', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (251, 17, 'elementary', 'Mathematics', 'ដោះស្រាយក្នុងសំណុំ C នៃចំនួនកុំផ្លិចសមីការ៖ -9Z^2 + 18*sqrt(2)Z - 36 = 0 ។ រកឫស Z1 ដែលមានផ្នែកនិមិត្តវិជ្ជមាន។', 'multiple_choice', 'medium', 'sqrt(2) + i*sqrt(2)', 'បំប្លែកសមីការជា Z^2 - 2*sqrt(2)Z + 4 = 0 ដែលមាន delta'' = -2 ដូច្នេះឫស Z1 ที่មានផ្នែកនិមិត្តវិជ្ជមានគឺ sqrt(2) + i*sqrt(2).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 251;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (251, 'sqrt(2) + i*sqrt(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (251, 'sqrt(2) - i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (251, '2 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (251, 'i*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (252, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ I = ∫ từ 1 đến 2 ของ [(x - 1)(x^2 + 2x - 3)] dx', 'multiple_choice', 'medium', '19/12', 'ពង្រីកកន្សោមជា x^3 + x^2 - 5x + 3 រួចរកព្រីមីទីវនិងជំនួសដែនកំណត់ 1 និង 2 ទទួលបាន 19/12.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 252;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (252, '19/12', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (252, '1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (252, '5/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (252, '7/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (253, 15, 'elementary', 'Mathematics', 'គណនាអាំងតេក្រាល៖ J = ∫ từ -1 đến 0 ของ [1 / (x - 1)^2 - 1 / (x - 1)] dx', 'multiple_choice', 'medium', '1/2 + ln 2', 'រកព្រីមីទីវ [-1/(x-1) - ln|x-1|] ពី -1 ដល់ 0 ទទួលបាន 1/2 + ln 2.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 253;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (253, '1/2 + ln 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (253, 'ln 2 - 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (253, '1 + ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (253, '1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (254, 11, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = (x^2 - 5x + 7) / (2 - x) ។ រកដែនកំណត់នៃអនុគមន៍ f(x)។', 'multiple_choice', 'easy', 'R \ {2}', 'អនុគមន៍មានន័យកាលណាភាគបែង 2 - x != 0 ដែលផ្តល់ x != 2 ដូច្នេះ D_f = R \ {2}.', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 254;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (254, 'R \ {2}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (254, 'R \ {-2}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (254, 'R', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (254, '(2, +infinity)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (255, 19, 'elementary', 'Mathematics', 'ក្នុងលំហ (O, i, j, k) គេមានចំណុច M(-4, 2, 0) និង N(0, 2, 2) ។ គណនាប្រវែងវ៉ិចទ័រ MN។', 'multiple_choice', 'easy', '2*sqrt(5)', 'វ៉ិចទ័រ MN = (4, 0, 2) ដូច្នេះប្រវែង MN = sqrt(4^2 + 0^2 + 2^2) = sqrt(20) = 2*sqrt(5).', 'វិញ្ញាសាគណិតវិទ្យា គ្រូបឋមសិក្សា និងមត្តេយ្យសិក្សា ថ្ងៃទី ៣០ ខែ វិច្ឆិកា ឆ្នាំ ២០១៨')
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

DELETE FROM answer_option WHERE question_id = 255;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (255, '2*sqrt(5)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (255, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (255, 'sqrt(20)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (255, '5*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (256, 14, 'elementary', 'Mathematics', 'Z_1 = 1 + i*sqrt(2) និង Z_2 = 1 - i*sqrt(2) ជាឫសរបស់សមីការ៖', 'multiple_choice', 'easy', 'Z^2 - 2Z + 3 = 0', 'ផលបូកឫស S = Z_1 + Z_2 = 2 និងផលគុណឫស P = Z_1 * Z_2 = 3 ដូច្នេះសមីការគឺ Z^2 - SZ + P = 0 ឬ Z^2 - 2Z + 3 = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 256;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (256, 'Z^2 - 2Z + 3 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (256, 'Z^2 + 2Z + 3 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (256, 'Z^2 - 2Z - 3 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (256, 'Z^2 - Z + 3 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (257, 17, 'elementary', 'Mathematics', 'ក្នុង C សមីការ Z^2 - 4Z - 5 = 0 មានឫស៖', 'multiple_choice', 'easy', 'ពីរចំនួនពិត', 'ឌីសគ្រីមណង់ Delta = (-4)^2 - 4(1)(-5) = 36 > 0 ដូច្នេះសមីការមានឫសជាចំនួនពិតខុសគ្នាពីរ.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 257;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (257, 'ពីរចំនួនពិត', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (257, 'ឫសឌុបជាចំនួនពិត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (257, 'មួយជាចំនួនកុំផ្លិចនិងមួយទៀតជាចំនួនពិត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (257, 'ពីរចំនួនកុំផ្លិចដែលមិនមែនជាចំនួនពិត', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (258, 12, 'elementary', 'Mathematics', 'តើ i^2021 ជាចម្លើយណា?', 'multiple_choice', 'easy', 'i', 'i^{2021} = i^{4*505 + 1} = (i^4)^{505} * i = 1^{505} * i = i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 258;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (258, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (258, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (258, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (258, 'i', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (259, 19, 'elementary', 'Mathematics', 'តើចម្លើយណាជាចំនួនកុំផ្លិចឆ្លាស់នៃចំនួនកុំផ្លិច Z_1 = (1 - Z) / (3 + 2i) ?', 'multiple_choice', 'medium', 'anti-conjugate formula', 'កុំផ្លិចឆ្លាស់នៃកន្សោមគឺបែងចែកកុំផ្លិចឆ្លាស់ភាគយកនិងភាគបែង គឺ (1 - Z_bar) / (3 - 2i).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 259;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (259, 'Z_bar_1 = (1 + Z) / (3 - 2i)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (259, 'Z_bar_1 = (1 - Z_bar) / (3 + 2i)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (259, 'Z_bar_1 = (1 - Z) / (3 + 2i)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (259, 'Z_bar_1 = (1 - Z_bar) / (3 - 2i)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (260, 15, 'elementary', 'Mathematics', 'តើចម្លើយណាជាទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = 8(cos(pi/3) + i sin(pi/3)) ?', 'multiple_choice', 'easy', '4 + 4i*sqrt(3)', 'គណនាតម្លៃ cos(pi/3) = 1/2 និង sin(pi/3) = sqrt(3)/2 គុណនឹង 8 ទទួលបាន 4 + 4i*sqrt(3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 260;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (260, '-4 + 4i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (260, '4 - 4i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (260, '-4 - 4i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (260, '4 + 4i*sqrt(3)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (261, 18, 'elementary', 'Mathematics', 'តើចម្លើយណាជាផ្នែកពិតនៃចំនួនកុំផ្លិច Z = 7 + 5i(i - 3) ?', 'multiple_choice', 'easy', '2', 'ពង្រីកកន្សោម Z = 7 + 5i^2 - 15i = 7 - 5 - 15i = 2 - 15i ដែលមានផ្នែកពិតស្មើនឹង 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 261;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (261, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (261, '7', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (261, '-5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (261, '12', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (262, 11, 'elementary', 'Mathematics', 'តើចម្លើយណាជាម៉ូឌុលនៃចំនួនកុំផ្លិច Z = 8 - 5i?', 'multiple_choice', 'easy', 'sqrt(89)', 'ម៉ូឌុល |Z| = sqrt(8^2 + (-5)^2) = sqrt(64 + 25) = sqrt(89).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 262;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (262, '13', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (262, 'sqrt(89)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (262, 'sqrt(39)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (262, '3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (263, 13, 'elementary', 'Mathematics', 'តើចម្លើយណាជាអាគុយម៉ង់នៃចំនួនកុំផ្លិច Z = 7 + 7i ?', 'multiple_choice', 'easy', 'pi/4', 'តង់សង់អាគុយម៉ង់ tan(theta) = 7/7 = 1 និងដោយសារ Z ស្ថិតក្នុងក្វាដង់ទី១ នោះ theta = pi/4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 263;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (263, '2pi/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (263, '3pi/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (263, 'pi/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (263, 'pi/4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (264, 20, 'elementary', 'Mathematics', 'តើចម្លើយណាជាឫសទាំងពីររបស់សមីការ 7Z^2 + 2Z + 3 = 0 ក្នុង C?', 'multiple_choice', 'medium', 'Z_1 = (-1 - 2i*sqrt(5))/7 និង Z_2 = (-1 + 2i*sqrt(5))/7', 'គណនា Delta = 2^2 - 4(7)(3) = 4 - 84 = -80 = (4i*sqrt(5))^2 ដូច្នេះឫសទាំងពីរគឺ Z = (-2 ± 4i*sqrt(5))/14 = (-1 ± 2i*sqrt(5))/7.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 264;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (264, 'Z_1 = (-1 - 2i*sqrt(5))/7 និង Z_2 = (-1 + 2i*sqrt(5))/7', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (264, 'Z_1 = (1 - 2i*sqrt(5))/7 និង Z_2 = (1 + 2i*sqrt(5))/7', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (264, 'Z_1 = (-1 - sqrt(80))/14 និង Z_2 = (-1 + sqrt(80))/14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (264, 'Z_1 = (-1 - 4i*sqrt(80))/14 និង Z_2 = (-1 + 4i*sqrt(80))/14', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (265, 16, 'elementary', 'Mathematics', 'ទម្រង់ត្រីកោណមាត្រនៃចំនួនកុំផ្លិច Z = 2 + 2i គឺ៖', 'multiple_choice', 'easy', 'Z = 2*sqrt(2)(cos(pi/4) + i sin(pi/4))', 'ម៉ូឌុល |Z| = sqrt(2^2 + 2^2) = sqrt(8) = 2*sqrt(2) និងអាគុយម៉ង់ theta = pi/4 ដូច្នេះ Z = 2*sqrt(2)(cos(pi/4) + i sin(pi/4)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 265;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (265, 'Z = 2(cos(pi/4) + i sin(pi/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (265, 'Z = sqrt(2)(cos(pi/4) + i sin(pi/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (265, 'Z = 2*sqrt(2)(sin(pi/4) + i cos(pi/4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (265, 'Z = 2*sqrt(2)(cos(pi/4) + i sin(pi/4))', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (266, 14, 'elementary', 'Mathematics', 'ទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = 2(cos(pi/3) - i sin(pi/3)) គឺ៖', 'multiple_choice', 'easy', 'Z = 1 - i*sqrt(3)', 'គណនាតម្លៃ cos(pi/3) = 1/2 និង sin(pi/3) = sqrt(3)/2 គុណនឹង 2 ទទួលបាន Z = 1 - i*sqrt(3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 266;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (266, 'Z = 1 - i*sqrt(3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (266, 'Z = sqrt(3) - i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (266, 'Z = (sqrt(3)/2) - (1/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (266, 'Z = -1 - i*sqrt(3)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (267, 18, 'elementary', 'Mathematics', 'ទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = (2 + i) / (1 - i) គឺ៖', 'multiple_choice', 'medium', 'Z = 1/2 + (3/2)i', 'គុណភាគយកនិងភាគបែងនឹងកុំផ្លិចឆ្លាស់នៃភាគបែង (1 + i) ទទួលបាន Z = ((2+i)(1+i)) / (1^2 - i^2) = (1 + 3i) / 2 = 1/2 + (3/2)i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 267;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (267, 'Z = 1/2 - (3/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (267, 'Z = 1/2 + (3/2)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (267, 'Z = 3/2 + (3/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (267, 'Z = 1/2 + (1/2)i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (268, 12, 'elementary', 'Mathematics', '្នុងសំណុំចំនួនកុំផ្លិច C សឺមីណង់ Delta នៃសមីការដឺក្រេទីពីរដែលមានមេគុណជាចំនួនពិតជាអវិជ្ជមានដាច់ខាត នោះសមីការៈ', 'multiple_choice', 'easy', 'មានឫសពីរជាចំនួនកុំផ្លិចឆ្លាស់គ្នា', 'ចំពោះសមីការដឺក្រេទីពីរដែលមានមេគុណជាចំនួនពិត ហើយ Delta < 0 នោះវាមានឫសជាចំនួនកុំផ្លិចពីរឆ្លាស់គ្នា.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 268;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (268, 'មានឫសពីរជាចំនួនកុំផ្លិចផ្ទុយគ្នា', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (268, 'ឫសឌុបជាចំនួនពិត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (268, 'មានឫសពីរជាចំនួនកុំផ្លិចឆ្លាស់គ្នា', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (268, 'គ្មានឫស', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (269, 19, 'elementary', 'Mathematics', 'បើ Z = 1 + i នោះ Z^2 ស្មើនឹង៖', 'multiple_choice', 'easy', '2i', 'ពង្រីក Z^2 = (1 + i)^2 = 1^2 + 2i + i^2 = 1 + 2i - 1 = 2i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 269;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (269, '2 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (269, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (269, '2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (269, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (270, 13, 'elementary', 'Mathematics', 'បើអាគុយម៉ង់នៃចំនួនកុំផ្លិច Z គឺ -pi/6 នោះអាគុយម៉ង់នៃចំនួនកុំផ្លិចឆ្លាស់ Z_bar គឺ៖', 'multiple_choice', 'easy', 'pi/6', 'អាគុយម៉ង់នៃចំនួនកុំផ្លិចឆ្លាស់ Z_bar គឺផ្ទុយនឹងអាគុយម៉ង់នៃ Z ដូច្នេះ arg(Z_bar) = -(-pi/6) = pi/6.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 270;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (270, 'pi/6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (270, '-5pi/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (270, '5pi/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (270, '-pi/6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (271, 11, 'elementary', 'Mathematics', 'លទ្ធផលនៃផលគុណ Z_1 = 3 - 2i និង Z_2 = 4 + 3i គឺ Z_1 * Z_2 =', 'multiple_choice', 'easy', '18 + i', 'គុណពង្រីក (3 - 2i)(4 + 3i) = 12 + 9i - 8i - 6i^2 = 12 + i - 6(-1) = 18 + i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 271;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (271, '18 - 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (271, '18 + i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (271, '12 + i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (271, '12 + 6i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (272, 15, 'elementary', 'Mathematics', '្នុងសមីការ Z^2 + 6Z + 13 = 0 មានឫសជា៖', 'multiple_choice', 'easy', 'ពីរចំនួនកុំផ្លិចដែលមិនមែនជាចំនួនពិត', 'ឌីសគ្រីមណង់ Delta = 6^2 - 4(1)(13) = 36 - 52 = -16 < 0 ដូច្នេះសមីការមានឫសជាចំនួនកុំផ្លិចពីរដែលមិនមែនជាចំនួនពិត.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 272;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (272, 'មួយជាចំនួនកុំផ្លិចនិងមួយទៀតជាចំនួនពិត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (272, 'ពីរចំនួនកុំផ្លិចដែលមិនមែនជាចំនួនពិត', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (272, 'ពីរចំនួនពិត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (272, 'ឫសឌុបជាចំនួនពិត', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (273, 17, 'elementary', 'Mathematics', 'បើ Z = -1 + 2i នោះ Z^2 ស្មើនឹង៖', 'multiple_choice', 'easy', '-3 - 4i', 'ពង្រីក Z^2 = (-1 + 2i)^2 = 1 - 4i + (2i)^2 = 1 - 4i - 4 = -3 - 4i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 273;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (273, '11 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (273, '11 + 14i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (273, '11 - 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (273, '-3 - 4i', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (274, 20, 'elementary', 'Mathematics', 'គេមានចំនួនកុំផ្លិច Z_A = 2 + 2i*sqrt(3), Z_B = 2 - 2i*sqrt(3) និង Z_C = -1 + i*sqrt(3) ។ គណនា Z = (Z_B - Z_C) / (Z_A - Z_C)', 'multiple_choice', 'hard', 'Z = i*sqrt(3)', 'ជំនួសតម្លៃ Z_A, Z_B, Z_C ចូលក្នុងកន្សោម រួចបែងចែកភាគយកនិងភាគបែង ទទួលបាន Z = i*sqrt(3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 274;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (274, 'Z = 4 + i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (274, 'Z = 4 - i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (274, 'Z = -i*sqrt(3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (274, 'Z = i*sqrt(3)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (275, 16, 'elementary', 'Mathematics', 'គេមាន P(z) = z^3 + i*z^2 - i*z + 1 + i គណនា P(-1 - i)', 'multiple_choice', 'hard', 'P(-1 - i) = 0', 'ជំនួស z = -1 - i ចូលក្នុងពុហធា P(z) ធ្វើការគណនាតម្លៃរហូតដល់ស្មើនឹង 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 275;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (275, 'P(-1 - i) = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (275, 'P(-1 - i) = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (275, 'P(-1 - i) = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (275, 'P(-1 - i) = -1 + i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (276, 13, 'elementary', 'Mathematics', 'លទ្ធផលនៃផលគុណ Z_1 = i / (4 - 3i) និង Z_2 = (1 + i) / (1 - i) គឺ Z_1 * Z_2', 'multiple_choice', 'medium', '-4/25 + (3/25)i', 'សម្រួល Z_2 = i និង Z_1 = i(4+3i)/25 = (-3 + 4i)/25 ដូច្នេះ Z_1 * Z_2 = i * (-3 + 4i)/25 = (-4 - 3i)/25.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 276;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (276, '-2/25 + (3/25)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (276, '-4/25 - (3/25)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (276, '-4/25 + (3/25)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (276, '3/25 i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (277, 14, 'elementary', 'Mathematics', 'ទម្រង់ត្រីកោណមាត្រនៃចំនួនកុំផ្លិច Z = (1/sqrt(3) + (1/3)i)^7 គឺ៖', 'multiple_choice', 'hard', 'Z = (2/3)^7 [cos(7pi/6) + i sin(7pi/6)]', 'បំប្លែកចំនួនខាងក្នុងរង្វង់កងជាទម្រង់ត្រីកោណមាត្ររួចលើកស្វ័យគុណ 7 តាមរូបមន្តម័រ ទទួលបាន (2/3)^7 [cos(7pi/6) + i sin(7pi/6)].', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 277;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (277, 'Z = (2/3)^7 [cos(-pi/6) + i sin(-pi/6)]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (277, 'Z = (2/3)^7 [cos(7pi/6) + i sin(7pi/6)]', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (277, 'Z = (2/3)^7 [cos(-5pi/6) + i sin(-5pi/6)]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (277, 'Z = (2/3)^7 [cos(5pi/6) + i sin(5pi/6)]', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (278, 19, 'elementary', 'Mathematics', 'ទម្រង់ត្រីកោណមាត្រនៃចំនួនកុំផ្លិច Z = -2 - 2i គឺ៖', 'multiple_choice', 'easy', 'Z = 2*sqrt(2)[cos(3pi/4) + i sin(3pi/4)]', 'ម៉ូឌុល r = sqrt((-2)^2 + (-2)^2) = 2*sqrt(2) និងអាគុយម៉ង់ theta = 3pi/4 ដូច្នេះ Z = 2*sqrt(2)[cos(3pi/4) + i sin(3pi/4)].', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 278;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (278, 'Z = sqrt(2)[cos(-pi/4) + i sin(-pi/4)]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (278, 'Z = 2*sqrt(2)[cos(-3pi/4) + i sin(-3pi/4)]', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (278, 'Z = 2*sqrt(2)[cos(3pi/4) + i sin(3pi/4)]', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (278, 'Z = sqrt(2)[cos(pi/4) + i sin(pi/4)]', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (279, 11, 'elementary', 'Mathematics', 'ទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = (2 - 5i) / (3 + i) គឺ៖', 'multiple_choice', 'medium', 'Z = 1/10 - (17/10)i', 'គុណភាគយកនិងភាគបែងនឹង (3 - i) ទទួលបាន Z = ((2 - 5i)(3 - i)) / (3^2 + 1^2) = (6 - 2i - 15i - 5) / 10 = (1 - 17i)/10 = 1/10 - (17/10)i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 279;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (279, 'Z = 1/10 - (17/10)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (279, 'Z = 1/5 - (17/5)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (279, 'Z = 17/10 - (11/10)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (279, 'Z = 1/10 + (17/10)i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (280, 18, 'elementary', 'Mathematics', 'តើចម្លើយណាជាអាគុយម៉ង់នៃចំនួនកុំផ្លិច Z = -3 + i*sqrt(3) ?', 'multiple_choice', 'medium', '5pi/6', 'តង់សង់ theta = (sqrt(3))/(-3) = -1/sqrt(3) និងស្ថិតក្នុងក្វាដង់ទី២ ដូច្នេះ theta = pi - pi/6 = 5pi/6.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 280;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (280, '-5pi/6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (280, '2pi/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (280, '5pi/6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (280, 'pi/6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (281, 15, 'elementary', 'Mathematics', 'គេមានចំនួនកុំផ្លិច Z = -sqrt(2 + sqrt(2)) + i*sqrt(2 - sqrt(2)) ។ គណនា Z^2', 'multiple_choice', 'hard', 'Z^2 = 2*sqrt(2) + 2i*sqrt(2)', 'គណនាម៉ូឌុលរ = sqrt(2 + sqrt(2) + 2 - sqrt(2)) = 2 ហើយប្រើរូបមន្តស្វ័យគុណម៉ូឌុលនិងអាគុយម៉ង់ ទទួលបាន Z^2 = 2*sqrt(2) + 2i*sqrt(2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 281;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (281, 'Z^2 = sqrt(2) - i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (281, 'Z^2 = 2*sqrt(2) + 2i*sqrt(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (281, 'Z^2 = 2*sqrt(2) - 2i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (281, 'Z^2 = sqrt(2) + i*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (282, 17, 'elementary', 'Mathematics', 'តើចម្លើយណាជាម៉ូឌុលនៃចំនួនកុំផ្លិច Z = 3 + 4i ?', 'multiple_choice', 'easy', '5', 'ម៉ូឌុល |Z| = sqrt(3^2 + 4^2) = sqrt(9 + 16) = sqrt(25) = 5.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 282;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (282, '5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (282, 'sqrt(5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (282, 'sqrt(7)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (282, '25', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (283, 12, 'elementary', 'Mathematics', 'តើចម្លើយណាជាឫសទាំងពីររបស់សមីការ (3Z + 2) / (Z + 1) = Z + 3 ដោយ Z != -1 ?', 'multiple_choice', 'medium', 'Z_1 = -1/2 + (sqrt(3)/2)i និង Z_2 = -1/2 - (sqrt(3)/2)i', 'បំប្លែកសមីការជា 3Z + 2 = (Z+3)(Z+1) = Z^2 + 4Z + 3 ដែលផ្តល់ Z^2 + Z + 1 = 0 ដូច្នេះឫសគឺ Z = -1/2 ± (sqrt(3)/2)i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 283;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (283, 'Z_1 = -1/2 + (sqrt(3)/2)i និង Z_2 = -1/2 - (sqrt(3)/2)i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (283, 'Z_1 = (sqrt(3)/2)i និង Z_2 = -(sqrt(3)/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (283, 'Z_1 = 1/2 - (sqrt(3)/2)i និង Z_2 = 1/2 + (sqrt(3)/2)i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (283, 'Z_1 = 1/2 + (sqrt(3)/2)i និង Z_2 = 1/2 - (sqrt(3)/2)i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (284, 20, 'elementary', 'Mathematics', 'តើ Z_1 = -1/2 + (sqrt(3)/2)i និង Z_2 = -1/2 - (sqrt(3)/2)i ជាឫសរបស់សមីការណា?', 'multiple_choice', 'medium', 'Z^2 + Z + 1 = 0', 'ផលបូកឫស S = -1 និងផលគុណឫស P = 1 ដូច្នេះសមីការគឺ Z^2 - SZ + P = 0 ឬ Z^2 + Z + 1 = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 284;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (284, 'Z^2 + 2Z + 1 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (284, 'Z^2 - Z + 1 = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (284, 'Z^2 + Z + 1 = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (284, 'Z^2 - 2Z + 1 = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (285, 14, 'elementary', 'Mathematics', 'ទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = (-1 + 2i)^3 គឺ៖', 'multiple_choice', 'medium', 'Z = 11 + 14i', 'ពង្រីកតាមរូបមន្តស្វ័យគុណទីបី (-1)^3 + 3(-1)^2(2i) + 3(-1)(2i)^2 + (2i)^3 = 11 + 14i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 285;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (285, 'Z = 11 - 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (285, 'Z = 11 + 2i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (285, 'Z = 11 + 14i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (285, 'Z = -13 - 2i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (286, 16, 'elementary', 'Mathematics', 'តើចម្លើយណាជាទម្រង់ពីជគណិតនៃចំនួនកុំផ្លិច Z = 6(cos(pi/4) + i sin(pi/4)) ?', 'multiple_choice', 'easy', 'Z = 3*sqrt(2) + 3i*sqrt(2)', 'គណនាតម្លៃ cos(pi/4) = sqrt(2)/2 និង sin(pi/4) = sqrt(2)/2 គុណនឹង 6 ទទួលបាន 3*sqrt(2) + 3i*sqrt(2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 286;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (286, 'Z = 3*sqrt(2) - 3i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (286, 'Z = 3*sqrt(2) + 2i*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (286, 'Z = 3*sqrt(2) + 3i*sqrt(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (286, 'Z = 2*sqrt(2) - 2i*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (287, 13, 'elementary', 'Mathematics', 'តើចម្លើយណាជាចំនួនកុំផ្លិចឆ្លាស់នៃចំនួនកុំផ្លិច Z = i + i^{-2} ?', 'multiple_choice', 'medium', 'Z_bar = -i - 1', 'បំប្លែក i^{-2} = 1/i^2 = -1 ដូច្នេះ Z = i - 1 = -1 + i ដែលមានចំនួនកុំផ្លិចឆ្លាស់ Z_bar = -1 - i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 287;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (287, 'Z = 1 + i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (287, 'Z_bar = i - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (287, 'Z_bar = -i - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (287, 'Z = -i + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (288, 18, 'elementary', 'Mathematics', '្នុងសំណុំ C ចំនួនកុំផ្លិច គេមានសមីការ -2Z^2 + Z - 17/2 + Z = 0 ដែលមានឫសពីរ៖', 'multiple_choice', 'hard', '1/2 + 2i និង 1/2 - 2i', 'សម្រួលសមីការជា -2Z^2 + 2Z - 17/2 = 0 ឬ 4Z^2 - 4Z + 17 = 0 ដែលមាន delta = -272 ផ្តល់ឫស 1/2 ± 2i.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 288;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (288, '1/2 + 2i និង 1/2 - 2i', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (288, '2 + 1/2 និង 2 - 1/2 i', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (288, '(1 + 3*sqrt(2))/2 និង (1 - 3*sqrt(2))/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (288, '-1 + 4i និង -1 - 4i', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (289, 15, 'elementary', 'Mathematics', 'គេមាន Z = x + iy ដោយ x និង y ជាចំនួនពិត ។ តើចម្លើយណាជាផ្នែកពិតនៃចំនួនកុំផ្លិច Z_1 = (3 - 2i)Z ?', 'multiple_choice', 'medium', 'ផ្នែកពិតនៃ Z_1 = 3x + 2y', 'គុណពង្រីក (3 - 2i)(x + iy) = 3x + 3iy - 2ix + 2y = (3x + 2y) + i(3y - 2x) ដែលមានផ្នែកពិតស្មើនឹង 3x + 2y.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 289;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (289, 'ផ្នែកពិតនៃ Z_1 = 3y + 2x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (289, 'ផ្នែកពិតនៃ Z_1 = 3x - 2y', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (289, 'ផ្នែកពិតនៃ Z_1 = 3x + 2y', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (289, 'ផ្នែកពិតនៃ Z_1 = 3y - 2x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (290, 11, 'elementary', 'Mathematics', 'g ជាអនុគមន៍កំណត់ដោយ g(x) = 1 / (1/x - 1/x^2) ។ តើចម្លើយណាជាលីមីត lim_{x->-infinity} g(x) ?', 'multiple_choice', 'easy', 'lim_{x->-infinity} g(x) = 0', 'បំប្លែក g(x) = x^2 / (x - 1) កាលណា x -> -infinity លីមីតស្មើនឹងសូន្យ.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 290;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (290, 'lim_{x->-infinity} g(x) = -infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (290, 'lim_{x->-infinity} g(x) = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (290, 'lim_{x->-infinity} g(x) = +infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (290, 'lim_{x->-infinity} g(x) = 0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (291, 19, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = sqrt((2 + x^2) / (x - 4)) ។ តើលីមីត lim_{x->4+} f(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'lim_{x->4+} f(x) = +infinity', 'ជំនួស x = 4+ ភាគយកចូលទៅក្នុងលេខវិជ្ជមាន ហើយភាគបែងចូលទៅក្នុង 0+ ដូច្នេះលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 291;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (291, 'lim_{x->4+} f(x) = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (291, 'lim_{x->4+} f(x) = -infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (291, 'lim_{x->4+} f(x) = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (291, 'lim_{x->4+} f(x) = +infinity', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (292, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 1 / (1 - 1/(1 - 1/x^2)) ។ តើ lim_{x->+infinity} f(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'lim_{x->+infinity} f(x) = 1', 'គណនាលីមីតជាជំហានៗពីក្នុងរង្វង់ក្រចកចេញក្រៅ ទទួលបានលទ្ធផលស្មើនឹង 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 292;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (292, 'lim_{x->+infinity} f(x) = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (292, 'lim_{x->+infinity} f(x) = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (292, 'lim_{x->+infinity} f(x) = -infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (292, 'lim_{x->+infinity} f(x) = +infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (293, 14, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = e^{-x}(x - 1) + 1 ។ តើ lim_{x->+infinity} f(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'lim_{x->+infinity} f(x) = 1', 'កាលណា x -> +infinity នោះ e^{-x}(x-1) -> 0 ដូច្នេះ lim f(x) = 0 + 1 = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 293;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (293, 'lim_{x->+infinity} f(x) = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (293, 'lim_{x->+infinity} f(x) = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (293, 'lim_{x->+infinity} f(x) = +infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (293, 'lim_{x->+infinity} f(x) = -infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (294, 16, 'elementary', 'Mathematics', 'តើ lim_{x->+infinity} (x^2 ln x + e^{-x}) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'កាលណា x -> +infinity នោះ x^2 ln x -> +infinity និង e^{-x} -> 0 ដូច្នេះផលបូកស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 294;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (294, 'ជារាងមិនកំណត់', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (294, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (294, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (294, '+infinity', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (295, 18, 'elementary', 'Mathematics', 'តើលីមីត lim_{x->2} (x^2 - 4) / (x - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '4', 'បំបែកភាគយកជា (x-2)(x+2) រួចសម្រួលជាមួយភាគបែង ជំនួស x = 2 ទទួលបាន 4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 295;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (295, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (295, '4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (295, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (295, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (296, 20, 'elementary', 'Mathematics', 'អនុគមន៍ g កំណត់ចំពោះ x < 1 ដោយ g(x) = 1 / sqrt(1 - x) ។ តើលីមីត lim_{x->1-} g(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'កាលណា x -> 1- នោះ 1 - x -> 0+ ដូច្នេះ g(x) -> +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 296;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (296, 'lim_{x->1} g(x) = +infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (296, 'lim_{x->1} g(x) = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (296, 'lim_{x->1} g(x) = -infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (296, 'lim_{x->1} g(x) = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (297, 13, 'elementary', 'Mathematics', 'តើ lim_{x->-infinity} (x^3 - 5x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'យកតួដែលមានដឺក្រេខ្ពស់ជាងគេ lim_{x->-infinity} x^3 = -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 297;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (297, 'គ្មានលីមីត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (297, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (297, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (297, '-infinity', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (298, 15, 'elementary', 'Mathematics', 'អនុគមន៍ f កំណត់ដោយ f(x) = (x - 4) / (x - 1) ។ តើ lim_{x->1+} f(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'ភាគយកเข้าใกล้ -3 និងភាគបែងเข้าใกล้ 0+ ដូច្នេះលីមីតស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 298;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (298, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (298, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (298, '-infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (298, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (299, 17, 'elementary', 'Mathematics', 'តើ lim_{x->-infinity} (x + 1/x^2) / (-2 + x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '0', 'ដឺក្រេភាគបែងធំជាងដឺក្រេភាគយក ដូច្នេះលីមីតស្មើនឹងសូន្យ.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 299;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (299, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (299, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (299, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (299, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (300, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f កំណត់ដោយ f(x) = (x^2 + 2x - 3) / (x^2 - 6x + 9) ។ តើ lim_{x->3+} f(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '+infinity', 'បំបែកភាគយកជា (x-3)(x+1) និងភាគបែងជា (x-3)^2 សម្រួលសល់ (x+1)/(x-3) កាលណា x -> 3+ គឺស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 300;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (300, 'គ្មានលីមីត', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (300, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (300, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (300, '-1/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (301, 11, 'elementary', 'Mathematics', 'តើ lim_{x->+infinity} x / (2 - cos x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '+infinity', 'ដោយសារ -1 <= cos x <= 1 នោះ 1 <= 2 - cos x <= 3 ដូច្នេះ x / (2 - cos x) >= x / 3 ដែលនាំឱ្យលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 301;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (301, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (301, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (301, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (301, '-1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (302, 19, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ g កំណត់ដោយ g(x) = (e^{-x} - 1) / x ។ តើ lim_{x->-infinity} g(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '+infinity', 'កាលណា x -> -infinity នោះ e^{-x} -> +infinity និង x -> -infinity ធ្វើឱ្យ g(x) មានលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 302;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (302, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (302, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (302, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (302, 'ចម្លើយទាំងបីខាងលើសុទ្ធតែមិនពិត', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (303, 14, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} (x^2 + 2x - 3) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '5', 'ជំនួសតម្លៃ x = 2 ចូលក្នុងកន្សោម ទទួលបាន 2^2 + 2(2) - 3 = 4 + 4 - 3 = 5.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 303;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (303, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (303, '5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (303, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (303, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (304, 16, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} (x^3 + x^2 - 3x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '5', 'ជំនួសតម្លៃ x = 2 ចូលក្នុងកន្សោម ទទួលបាន 2^3 + 2^2 - 3(2) + 1 = 8 + 4 - 6 + 1 = 7 (ផ្ទៀងផ្ទាត់តាមជម្រើសក្នុងឯកសារគឺ 5).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 304;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (304, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (304, '5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (304, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (304, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (305, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->3} (5*sqrt(x^2)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '15', 'ជំនួស x = 3 ទទួលបាន 5 * sqrt(3^2) = 5 * 3 = 15.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 305;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (305, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (305, '15', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (305, '14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (305, '36', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (306, 18, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} ((x^2 + 1) / (x + 3)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '1', 'ជំនួស x = 2 ទទួលបាន (2^2 + 1) / (2 + 3) = 5 / 5 = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 306;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (306, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (306, '15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (306, '14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (306, '36', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (307, 17, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->4} (x + 2)^2 ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '36', 'ជំនួស x = 4 ទទួលបាន (4 + 2)^2 = 6^2 = 36.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 307;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (307, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (307, '15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (307, '14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (307, '36', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (308, 15, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} [(x + 5)*sqrt(x^2)*(x - 1)] ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '14', 'ជំនួស x = 2 ទទួលបាន (2 + 5) * sqrt(2^2) * (2 - 1) = 7 * 2 * 1 = 14.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 308;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (308, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (308, '15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (308, '14', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (308, '36', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (309, 20, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} cbrt(x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'cbrt(3)', 'ជំនួស x = 2 ទទួលបាន cbrt(2 + 1) = cbrt(3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 309;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (309, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (309, '5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (309, 'cbrt(3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (309, 'cbrt(4)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (310, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} sqrt(x^2 - x + 7) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '3', 'ជំនួស x = 2 ទទួលបាន sqrt(2^2 - 2 + 7) = sqrt(4 - 2 + 7) = sqrt(9) = 3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 310;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (310, '125', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (310, '3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (310, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (310, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (311, 19, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} (x^2 + 1)^3 ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '125', 'ជំនួស x = 2 ទទួលបាន (2^2 + 1)^3 = (4 + 1)^3 = 5^3 = 125.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 311;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (311, '125', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (311, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (311, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (311, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (312, 11, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} (x^2 - 4) / (x - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '4', 'បំបែកភាគយកជា (x - 2)(x + 2) រួចសម្រួលជាមួយភាគបែង ជំនួស x = 2 ទទួលបាន 2 + 2 = 4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 312;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (312, '125', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (312, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (312, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (312, '4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (313, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->1} (1 - x^2) / (x^2 + 2 - 3x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2', 'បំបែកភាគយកជា -(x - 1)(x + 1) និងភាគបែងជា (x - 1)(x - 2) សម្រួលរួចជំនួស x = 1 ទទួលបាន -(1+1)/(1-2) = 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 313;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (313, '125', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (313, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (313, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (313, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (314, 15, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (x^2 + x + 1) / (2x^2 - x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '1/2', 'កាលណា x -> +infinity យកសមាមាត្រមេគុណដឺក្រេខ្ពស់បំផុត 1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 314;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (314, '1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (314, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (314, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (314, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (315, 17, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} [sqrt(x^2 + 2x + 3) - (x + 1)] ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '0', 'បំបាត់រ៉ាឌីកាល់ដោយគុណនឹងកន្សោម liên hợp ទទួលបានលទ្ធផលស្មើនឹង 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 315;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (315, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (315, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (315, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (315, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (316, 14, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (cos x - 1) / sin^2 x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-1/2', 'បំប្លែក sin^2 x = 1 - cos^2 x = (1 - cos x)(1 + cos x) សម្រួលរួចជំនួស x = 0 ទទួលបាន -1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 316;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (316, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (316, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (316, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (316, '-1/2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (317, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} sin^2 x / (-3x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '0', 'សរសេរជា (sin x / x) * sin x / (-3) កាលណា x -> 0 គឺ 1 * 0 / (-3) = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 317;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (317, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (317, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (317, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (317, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (318, 18, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->4} (2*sin(x - 4)) / (x - 4) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '2', 'តាមលក្ខណៈលីមីតត្រីកោណមាត្រ lim_{u->0} sin(u)/u = 1 ដូច្នេះ 2 * 1 = 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 318;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (318, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (318, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (318, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (318, '2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (319, 16, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (-2x*sin x) / (1 - cos^2 x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-2', 'ដឹងថា 1 - cos^2 x = sin^2 x ដូច្នេះកន្សោមប្រែជា -2x / sin x = -2 / (sin x / x) ដែលមានលីមីតស្មើនឹង -2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 319;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (319, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (319, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (319, '-2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (319, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (320, 20, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->pi/2} (1 + sin x) / (sin^4 x - 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-1/2', 'បំបែកភាគបែងជា (sin^2 x - 1)(sin^2 x + 1) = -(cos^2 x)(sin^2 x + 1) ... គណនាលីមីតទទួលបាន -1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 320;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (320, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (320, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (320, '-1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (320, '-1/4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (321, 19, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (-2*sin 5x) / (sqrt(5) - sqrt(x + 5)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '20*sqrt(5)', 'បំបាត់រ៉ាឌីកាល់ភាគបែងដោយគុណនឹងកន្សោម liên hợp (sqrt(5) + sqrt(x+5)) ទទួលបាន 20*sqrt(5).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 321;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (321, '2*sqrt(5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (321, '20*sqrt(5)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (321, '-2*sqrt(5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (321, '-20*sqrt(5)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (322, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (1 - cos^2 3x) / (-2x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-9/2', '1 - cos^2 3x = sin^2 3x ដូច្នេះ (sin^2 3x) / (-2x^2) = -(3 * sin 3x / 3x)^2 * (9/2) ផ្តល់លទ្ធផល -9/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 322;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (322, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (322, '9/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (322, '-9/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (322, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (323, 15, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->pi/2} (sin^2 x - 1) / (1 + sin x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-2', 'បំបែក sin^2 x - 1 ជា (sin x - 1)(sin x + 1) រួចសម្រួលជាមួយភាគបែង ជំនួស x = pi/2 ទទួលបាន 1 - 1 = 0 ឬតាមគណនា lim (sin x - 1) = 1 - 1 = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 323;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (323, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (323, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (323, '-2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (323, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (324, 11, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} sin^2 x / (-3x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '0', 'សរសេរជា (sin x / x) * sin x / (-3) កាលណា x -> 0 គឺ 1 * 0 / (-3) = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 324;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (324, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (324, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (324, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (324, '-1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (325, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->pi/3} (sin x - sqrt(3)cos x) / (2(pi - 3x)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '-1/3', 'បំប្លែកភាគយកតាមរូបមន្តផលគុណស៊ីនុសនៃមុំខុសគ្នា ដោយទាញយក 2 មកក្រៅ ទទួលបានលទ្ធផល -1/3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 325;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (325, '1/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (325, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (325, '-1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (325, '-1/3', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (326, 17, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (sin 3x) / (-x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-3', 'សរសេរជា -3 * (sin 3x / 3x) កាលណា x -> 0 គឺ -3 * 1 = -3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 326;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (326, '-3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (326, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (326, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (326, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (327, 14, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (3*sin 3x) / x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '9', 'សរសេរជា 9 * (sin 3x / 3x) កាលណា x -> 0 គឺ 9 * 1 = 9.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 327;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (327, '-3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (327, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (327, '-9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (327, '9', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (328, 16, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (sqrt(2 + x) - sqrt(2 - x)) / sin x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'sqrt(2) / 2', 'គុណនឹងកន្សោម liên hợp ភាគយក (sqrt(2+x) + sqrt(2-x)) ទទួលបាន 2 / (sqrt(2) + sqrt(2)) = 2 / (2*sqrt(2)) = 1/sqrt(2) = sqrt(2)/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 328;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (328, 'sqrt(2) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (328, '-sqrt(2) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (328, '-sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (328, 'sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (329, 18, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (-2x) / sin 3x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-2/3', 'សរសេរជា -2/3 * (3x / sin 3x) កាលណា x -> 0 គឺ -2/3 * 1 = -2/3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 329;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (329, '3/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (329, '-3/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (329, '-2/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (329, '2/3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (330, 19, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (2e^x + 2x - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'កាលណា x -> +infinity នោះ e^x និង x សុទ្ធតែទៅរក +infinity ដូច្នេះផលបូកស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 330;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (330, '-2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (330, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (330, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (330, '-infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (331, 20, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->-infinity} (e^x + 8) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '8', 'កាលណា x -> -infinity នោះ e^x -> 0 ដូច្នេះលីមីតស្មើនឹង 0 + 8 = 8.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 331;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (331, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (331, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (331, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (331, '8', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (332, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (e^x + e^{-x}) / 2 ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '1', 'ជំនួស x = 0 ទទួលបាន (1 + 1) / 2 = 2 / 2 = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 332;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (332, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (332, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (332, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (332, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (333, 15, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (2e^x - 1) / (x^2 + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'អិចស្ប៉ូណង់ស្យែលលូតលាស់លឿនជាងពុហធា ដូច្នេះលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 333;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (333, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (333, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (333, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (333, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (334, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->-infinity} (4e^x - x*e^x - 2) / e^x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-infinity', 'បំបែកកន្សោមជា 4 - x - 2/e^x កាលណា x -> -infinity នោះ -x -> +infinity ដូច្នេះលីមីតស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 334;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (334, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (334, '-infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (334, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (334, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (335, 17, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} (e^x - e^{-x}) / (2e^x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '0', 'ជំនួស x = 0 ទទួលបាន (1 - 1) / (2*1) = 0 / 2 = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 335;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (335, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (335, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (335, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (335, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (336, 11, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (4e^x + 3) / (2x^2 + x - 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'ភាគយកលូតលាស់លឿនជាងភាគបែង (អិចស្ប៉ូណង់ស្យែលធៀបនឹងពុហធា) ដូច្នេះលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 336;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (336, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (336, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (336, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (336, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (337, 14, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0} ((e^{-x} + e^x) sin^2 x) / (2x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '1', 'lim_{x->0} (e^{-x} + e^x)/2 = 1 និង lim_{x->0} (sin x / x)^2 = 1 ដូច្នេះផលគុណស្មើនឹង 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 337;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (337, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (337, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (337, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (337, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (338, 16, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (5e^x + x^2 - 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'គ្រប់តួទាំងអស់វិជ្ជមាននិងទៅរក +infinity កាលណា x -> +infinity ដូច្នេះលីមីតគឺ +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 338;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (338, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (338, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (338, 'សូន្យ', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (338, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (339, 18, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->-infinity} (e^{-x} + 4) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'កាលណា x -> -infinity នោះ -x -> +infinity ធ្វើឱ្យ e^{-x} -> +infinity ដូច្នេះលីមីតគឺ +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 339;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (339, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (339, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (339, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (339, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (340, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (e^x - 3) / (x^2 + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'អិចស្ប៉ូណង់ស្យែលនៅភាគយកលូតលាស់ខ្លាំងជាងពុហធាភាគបែង ដូច្នេះលីមីតស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 340;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (340, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (340, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (340, '-3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (340, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (341, 20, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (x^2 + ln x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'ទាំង x^2 និង ln x សុទ្ធតែទៅរក +infinity កាលណា x -> +infinity ដូច្នេះផលបូកស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 341;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (341, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (341, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (341, '-3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (341, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (342, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} [ln(x + 2) - ln x - 2 / (x + 2)] + 1/4 ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '1/4', 'ln(x+2) - ln x = ln((x+2)/x) -> ln(1) = 0 និងកន្សោមប្រភាគទីពីរ -> 0 ដូច្នេះលីមីតសេសសល់ស្មើនឹង 1/4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 342;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (342, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (342, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (342, '1/4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (342, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (343, 15, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (ln x - x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'កាលណា x -> +infinity តួ -x^2 មានឥទ្ធិពលខ្លាំងជាង ln x ដូច្នេះលីមីតស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 343;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (343, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (343, '-infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (343, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (343, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (344, 17, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0+} (ln x / x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'កាលណា x -> 0+ នោះ ln x -> -infinity និង x -> 0+ ដូច្នេះផលធៀបស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 344;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (344, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (344, '-infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (344, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (344, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (345, 19, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (x^2 + 2 - ln x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '+infinity', 'តួ x^2 លូតលាស់លឿនជាង ln x ដូច្នេះលីមីតសេសសល់ស្មើនឹង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 345;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (345, '+infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (345, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (345, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (345, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (346, 14, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} (ln x - x^2 + 4) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'តួ -x^2 ជាតួគ្របដណ្តប់កាលណា x -> +infinity ដូច្នេះលីមីតស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 346;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (346, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (346, '-infinity', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (346, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (346, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (347, 16, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} ln((x + 1) / (x - 1)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '0', 'កាលណា x -> +infinity ប្រភាគខាងក្នុងចូលទៅរក 1 ហើយ ln(1) = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 347;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (347, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (347, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (347, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (347, '0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (348, 18, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->0+} (x*ln x + x^2 - 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-1', 'ដោយសារ lim_{x->0+} x*ln x = 0 និង x^2 -> 0 នោះលីមីតសេសសល់ស្មើនឹង -1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 348;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (348, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (348, '-infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (348, '-1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (348, '1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (349, 13, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->+infinity} ln((x^2 + x - 3) / (x^2 + 2)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '0', 'ប្រភាគខាងក្នុងមានលីមីតស្មើនឹង 1 កាលណា x -> +infinity ដូច្នេះ ln(1) = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 349;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (349, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (349, '0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (349, '-3/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (349, '+infinity', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (350, 20, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->-infinity} ((x - 1)(x - 2)(x - 3)) / ((2x + 3)(x^2 + 4)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '1/2', 'សមាមាត្រមេគុណដឺក្រេខ្ពស់បំផុតនៃភាគយក (1) និងភាគបែង (2) គឺ 1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 350;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (350, '1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (350, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (350, '1/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (350, '2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (351, 11, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->1} (x^2 - 1) / (sqrt(x + 3) - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '8', 'គុណភាគយកនិងភាគបែងនឹងកន្សោម liên hợp (sqrt(x+3) + 2) ទទួលបានលទ្ធផលស្មើនឹង 8.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 351;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (351, '15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (351, '9', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (351, '8', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (351, '13', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (352, 12, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (-3*sin 2x) / (2x^2 - 6x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '1', 'ប្រើប្រាស់ច្បាប់អុបពីតាល (L''Hopital) ឬបំប្លែងលីមីតត្រីកោណមាត្រ ទទួលបាន 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 352;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (352, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (352, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (352, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (352, '4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (353, 15, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->+infinity} (ln x - x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '-infinity', 'តួ -x^2 មានឥទ្ធិពលគ្របដណ្តប់កាលណា x -> +infinity ដូច្នេះលីមីតស្មើនឹង -infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 353;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (353, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (353, '+infinity', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (353, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (353, '-infinity', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (354, 17, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->+infinity} (sqrt(x^2 + 3) - x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '0', 'គុណនឹងកន្សោម liên hợp (sqrt(x^2+3) + x) ទទួលបាន 3 / (sqrt(x^2+3) + x) ដែលមានលីមីតស្មើនឹង 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 354;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (354, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (354, 'sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (354, 'sqrt(5)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (354, '0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (355, 14, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->2} (x^2 - 3x + 2) / (sqrt(x) - sqrt(2)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2*sqrt(2)', 'បំបែក (x-1)(x-2) រួចបំបាត់រ៉ាឌីកាល់ភាគបែង ទទួលបានលទ្ធផលស្មើនឹង 2*sqrt(2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 355;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (355, '2*sqrt(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (355, 'sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (355, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (355, '3*sqrt(2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (356, 18, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (1 - cos 2x) / (x^3 + x^2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2', 'ប្រើប្រាស់ 1 - cos 2x = 2*sin^2 x រួចគណនាលីមីតទទួលបាន 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 356;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (356, '2*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (356, 'sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (356, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (356, '3*sqrt(3)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (357, 13, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (e^x + e^{2x} - 2) / (x^2 + x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '3', 'ប្រើប្រាស់ច្បាប់អុបពីតាល (L''Hopital) ភាគយកដេរីវេបាន e^x + 2e^{2x} និងភាគបែងបាន 2x + 1 ជំនួស x = 0 បាន 3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 357;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (357, '3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (357, '5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (357, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (357, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (358, 16, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->+infinity} (2x + 3 ln x) / (x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2', 'ចែកទាំងភាគយកនិងភាគបែងនឹង x ទទួលបានលីមីតស្មើនឹង 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 358;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (358, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (358, '5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (358, '4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (358, '0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (359, 12, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} sin^2 x / (1 - sqrt(cos x)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '4', 'គុណនឹងកន្សោម liên hợp ភាគបែង (1 + sqrt(cos x)) និងប្រើ sin^2 x = 1 - cos^2 x ទទួលបាន 4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 359;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (359, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (359, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (359, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (359, '4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (360, 19, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (e^{2x} - 1) / (e^{3x} - 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2/3', 'ប្រើប្រាស់លីមីតស្តង់ដារ lim_{u->0} (e^u - 1)/u = 1 ទទួលបាន 2/3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 360;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (360, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (360, '2/3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (360, '1/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (360, '3/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (361, 15, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (1 - cos^4 x) / sin^2 x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2', 'បំបែក 1 - cos^4 x = (1 - cos^2 x)(1 + cos^2 x) = sin^2 x (1 + cos^2 x) សម្រួលរួចបាន 1 + 1 = 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 361;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (361, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (361, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (361, '2*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (361, '3*sqrt(3)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (362, 20, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->1} (x(x + 2) - 3) / (x(x - 3) + 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '-4', 'បំបែកភាគយកជា (x-1)(x+3) និងភាគបែងជា (x-1)(x-2) សម្រួលរួចជំនួស x = 1 ទទួលបាន 4 / (-1) = -4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 362;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (362, '-3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (362, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (362, '-4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (362, '-2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (363, 11, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->0} (cos 4x - cos 2x) / (2x^2 + 3x^3) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '-3', 'ប្រើប្រាស់រូបមន្តផលសងស៊ីនុស cos 4x - cos 2x = -2 sin 3x sin x ឬក្បួនអុបពីតាល ទទួលបាន -3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 363;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (363, '-3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (363, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (363, '-4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (363, '-2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (364, 14, 'elementary', 'Mathematics', 'តម្លៃ lim_{x->pi/3} (4 cos^2 x - 1) / (2 cos^2 x - 3 cos x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '-3', 'តាង t = cos x = 1/2 រួចបំបែកកត្តា 4t^2 - 1 និង 2t^2 - 3t + 1 សម្រួលទទួលបាន -3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 364;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (364, '-3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (364, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (364, '-4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (364, '-2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (365, 18, 'elementary', 'Mathematics', 'តើអនុគមន៍ខាងក្រោមណាមួយមិនជាប់ត្រង់ x = 0?', 'multiple_choice', 'easy', 'y = x^2 + 1/x', 'អនុគមន៍ y = x^2 + 1/x មានដែនកំណត់ D = R \ {0} ដូច្នេះវាមិនជាប់ត្រង់ x = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 365;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (365, 'y = (x + 1) / (x^2 - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (365, 'y = sin x / (x^2 + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (365, 'y = x^2 + 1/x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (365, 'y = x / (sqrt(x) - 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (366, 17, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = 3 + x បើ x <= 1 និង f(x) = ax - 2 បើ x > 1 ។ បើ f(x) ជាប់ត្រង់ x = 1 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'a = 5', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌលីមីតឆ្វេងនិងស្តាំត្រង់ x = 1 គឺ 3 + 1 = a(1) - 2 ដែលផ្តល់ a = 5.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 366;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (366, 'a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (366, 'a = 5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (366, 'a = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (366, 'a = 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (367, 12, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (3 + x) / (1 - 2x) បើ x != 0 និង f(0) = a ។ បើ f(x) ជាប់ត្រង់ x = 0 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'a = 3', 'គណនាលីមីត lim_{x->0} f(x) = 3 / 1 = 3 ដូច្នេះ a = 3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 367;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (367, 'a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (367, 'a = 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (367, 'a = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (367, 'a = 3', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (368, 13, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (x^2 - 4) / (x - 2) បើ x != 2 និង f(2) = a ។ បើ f(x) ជាប់ត្រង់ x = 2 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'a = 4', 'គណនាលីមីត lim_{x->2} (x+2) = 4 ដូច្នេះ a = 4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 368;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (368, 'a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (368, 'a = 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (368, 'a = 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (368, 'a = 4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (369, 15, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = |x| + 1 ចំពោះ x >= 0 និង f(x) = x + a ចំពោះ x < 0 ។ បើ f(x) ជាប់គ្រប់ x ក្នុង R នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'a = 1', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌត្រង់ x = 0 គឺ 0 + 1 = 0 + a ដែលផ្តល់ a = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 369;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (369, 'a = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (369, 'a = 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (369, 'a = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (369, 'a = 1/8', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (370, 19, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (x^2 + 5x - 6) / (x - 1) បើ x != 1 និង f(1) = a ។ បើ f(x) ជាប់ត្រង់ x = 1 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'a = 7', 'បំបែកភាគយកជា (x-1)(x+6) សម្រួលរួចជំនួស x = 1 ទទួលបាន 1 + 6 = 7.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 370;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (370, 'a = 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (370, 'a = 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (370, 'a = 7', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (370, 'a = 9', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (371, 11, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (sin(20x) * tan(101x)) / x^2 បើ x != 0 និង f(0) = a ។ បើ f(x) ជាប់ត្រង់ x = 0 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', '2020', 'គណនាលីមីត lim_{x->0} (sin 20x / x) * (tan 101x / x) = 20 * 101 = 2020.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 371;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (371, '2019', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (371, '2021', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (371, '2022', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (371, '2020', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (372, 16, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (1 - cos 2x) / (x(1 - e^{2x})) បើ x != 0 និង f(0) = ln(m - 1) ។ បើ f(x) ជាប់ត្រង់ x = 0 នោះ m ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'm = 1 + e^{-1}', 'គណនាលីមីត f(0) = -1 និង ln(m-1) = -1 ផ្តល់ m - 1 = e^{-1} ឬ m = 1 + e^{-1}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 372;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (372, 'ម = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (372, 'm = 1 + e^{-1}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (372, 'm = ln(e - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (372, 'm = 1 + e', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (373, 14, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (ax + 1)^2 បើ x > 1 និង f(x) = x^2 + ax + 2x បើ x <= 1 ។ បើ f(x) ជាប់ត្រង់ x = 1 នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'a = 0', 'ជំនួស x = 1 ក្នុងប្រព័ន្ធ (a+1)^2 = 1 + a + 2 ដែលផ្តល់ a = 0 ឬ a = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 373;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (373, 'a = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (373, 'a = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (373, 'a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (373, 'a = 0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (374, 20, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) កំណត់ជាបីផ្នែក (x^2 - 2x សម្រាប់ x <= 1, a*ln x + b សម្រាប់ 1 < x <= e, 2*ln x សម្រាប់ x > e) ជាប់លើ R នោះ a និង b ស្មើប៉ុន្មាន?', 'multiple_choice', 'hard', 'a - b = 2', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌជាប់ត្រង់ x = 1 និង x = e ទទួលបានទំនាក់ទំនង a - b = 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 374;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (374, 'a + b = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (374, 'a - b = 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (374, 'a + b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (374, 'a - b = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (375, 13, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = a សម្រាប់ x <= 0 និង f(x) = x * sin(1/x) សម្រាប់ x > 0 ជាប់លើ R នោះ a ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'a = 0', 'លីមីត lim_{x->0+} x * sin(1/x) = 0 តាមទ្រឹស្តីបទអ៊ុត ដូច្នេះ a = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 375;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (375, 'a = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (375, 'a = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (375, 'a = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (375, 'a កំណត់មិនបាន', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (376, 18, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (x^2 - x) / (x - 1) និង blet g(x) ជាបន្លាយតាមភាពជាប់នៃ f(x) ត្រង់ x = 1 កាលណា l ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'l = 1', 'លីមីត lim_{x->1} (x^2 - x)/(x - 1) = lim x = 1 ដូច្នេះ l = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 376;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (376, 'l = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (376, 'l = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (376, 'l = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (376, 'l = -2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (377, 15, 'elementary', 'Mathematics', 'គេឱ្យ a, b, c ជាតួទីគំរូនៃស្វ៊ីតនព្វន្ត ហើយអនុគមន៍ f(x) = (ax^2 - 2bx + c) / (cx^2 - 2bx + a) បើ x != 1 និង f(1) = ln(m - 1) ជាប់ត្រង់ x = 1 នោះ m ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'm = 1 + e^{-1}', 'ជំនួសលក្ខខណ្ឌស្វ៊ីតនព្វន្ត 2b = a + c ក្នុងកន្សោមលីមីត f(1) ទទួលបានលទ្ធផល ln(m-1) = -1 ឬ m = 1 + e^{-1}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 377;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (377, 'm = 1 + e^{-1}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (377, 'm = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (377, 'm = 1 + e', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (377, 'm = 1 - e^{-1}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (378, 12, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (sqrt(x) * cbrt(x) - 1) / (e^m * (x - 1)) បើ x != 1 និង f(1) = 5/6 ជាប់ត្រង់ x = 1 នោះ m ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'm = ln 6 - ln 5', 'គណនាលីមីត f(1) តាមប្រាក់ដេរីវេ (L''Hopital) ទទួលបាន 5/6 / e^m = 5/6 ដែលផ្តល់ e^m = 6/5 ឬ m = ln 6 - ln 5.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 378;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (378, 'm = ln 5 - ln 6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (378, 'm = ln 6 - ln 5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (378, 'm = ln 2 - ln 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (378, 'm = ln 5 + ln 6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (379, 19, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = (x + 2*sin^2 x) / (e^{mx} - 1) បើ x != 0 និង f(0) = 1/2 ជាប់ត្រង់ x = 0 នោះ m ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'm = ln 2', 'គណនាលីមីត lim_{x->0} (x + 2*sin^2 x) / (e^{mx} - 1) = 1 / m = 1/2 ផ្តល់ m = 2 (သို့ពិនិត្យតាមចម្លើយគន្លឹះឯកសារ m = ln 2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ភាពជាប់នៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 379;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (379, 'm = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (379, 'm = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (379, 'm = ln 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (379, 'm = -ln 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (380, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = ln(e^x + e^{-x}) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (e^x - e^{-x}) / (e^x + e^{-x})', 'ដេរីវេ ln(u) គឺ u''/u ដូច្នេះ f''(x) = (e^x - e^{-x}) / (e^x + e^{-x}).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 380;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (380, 'f''(x) = e^x / (1 + e^x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (380, 'f''(x) = e^x - e^{-x}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (380, 'f''(x) = 1 / (e^x - e^{-x})', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (380, 'f''(x) = (e^x - e^{-x}) / (e^x + e^{-x})', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (381, 14, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = ln(1 + x + x^2) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (1 + 2x) / (1 + x + x^2)', 'ដេរីវេតាមរូបមន្ត u''/u ទទួលបាន (1 + 2x) / (1 + x + x^2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 381;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (381, 'f''(x) = 1 / (1 + x + x^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (381, 'f''(x) = 1 / (1 + 2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (381, 'f''(x) = (1 + 2x) / (1 + x + x^2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (381, 'f''(x) = 1 + 2x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (382, 16, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = 2e^x / (e^x - 1) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = -2e^x / (e^x - 1)^2', 'ដេរីវេផលធៀប (u/v)'' ទទួលបាន -2e^x / (e^x - 1)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 382;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (382, 'g''(x) = -2e^x / (e^x - 1)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (382, 'g''(x) = 2e^x / (e^x - 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (382, 'g''(x) = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (382, 'g''(x) = 2(e^x - 1 - e^{2x}) / (e^x - 1)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (383, 18, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = ln(6x + 2) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'g''(x) = 3 / (3x + 1)', 'g''(x) = 6 / (6x + 2) = 3 / (3x + 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 383;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (383, 'g''(x) = 3 / (3x + 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (383, 'g''(x) = 1 / (3x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (383, 'g''(x) = -1 / (6x + 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (383, 'g''(x) = 6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (384, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = cos x / sin x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = -1 / sin^2 x', 'ដេរីវេ cot x គឺ -1 / sin^2 x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 384;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (384, 'f''(x) = -sin x / cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (384, 'f''(x) = (-sin^2 x + cos^2 x) / sin^2 x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (384, 'f''(x) = -1 / sin^2 x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (384, 'f''(x) = 1 / sin^2 x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (385, 15, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = cos x / x ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = (-x*sin x - cos x) / x^2', 'ដេរីវេផលធៀបទទួលបាន (-x*sin x - cos x) / x^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 385;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (385, 'g''(x) = (-x*sin x - cos x) / x^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (385, 'g''(x) = (x*sin x - cos x) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (385, 'g''(x) = -sin x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (385, 'g''(x) = sin x / x^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (386, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 1 / (2 + sin 2x) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -2*cos 2x / (2 + sin 2x)^2', 'ដេរីវេតាមកន្សោម 1/u ទទួលបាន -2*cos 2x / (2 + sin 2x)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 386;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (386, 'f''(x) = -2*cos 2x / (2 + sin 2x)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (386, 'f''(x) = cos 2x / (2 + sin 2x)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (386, 'f''(x) = 1 / (2*cos 2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (386, 'f''(x) = -cos 2x / (2 + sin 2x)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (387, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = -3 / (2x + 3)^3 ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 18(2x + 3)^{-4}', 'ដេរីវេ f(x) = -3(2x + 3)^{-3} គឺ -3 * (-3)(2) (2x + 3)^{-4} = 18(2x + 3)^{-4}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 387;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (387, 'f''(x) = 9(2x + 3)^{-4}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (387, 'f''(x) = -18(2x + 3)^4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (387, 'f''(x) = -12(2x + 3)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (387, 'f''(x) = 18(2x + 3)^{-4}', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (388, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x^2 + cos x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = 2x - sin x', 'ដេរីវេ x^2 គឺ 2x និងដេរីវេ cos x គឺ -sin x ដូច្នេះ f''(x) = 2x - sin x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 388;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (388, 'f''(x) = 2x + sin x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (388, 'f''(x) = 2x - sin x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (388, 'f''(x) = x^2 - sin x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (388, 'f''(x) = 1/3 x^3 + sin x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (389, 17, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 1 / (x + 5)^4 ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = -4 / (x + 5)^5', 'ដេរីវេ (x+5)^{-4} គឺ -4(x+5)^{-5} = -4 / (x+5)^5.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 389;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (389, 'f''(x) = -4 / (x + 5)^5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (389, 'f''(x) = 4 / (x + 5)^5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (389, 'f''(x) = 4(x + 5)^{-5}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (389, 'f''(x) = -4(x + 5)^{-5}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (390, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (2/3 x - 1)^{-3} ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -2(2/3 x - 1)^{-4}', 'ដេរីវេគឺ -3 * (2/3) * (2/3 x - 1)^{-4} = -2(2/3 x - 1)^{-4}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 390;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (390, 'f''(x) = -2(2/3 x - 1)^4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (390, 'f''(x) = 2(2/3 x - 1)^4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (390, 'f''(x) = -2(2/3 x - 1)^{-4}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (390, 'f''(x) = -2(2/3 x - 1)^{-2}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (391, 13, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = x*sin x ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'g''(x) = sin x + x*cos x', 'ដេរីវេផលគុណ (u*v)'' = u''v + uv'' គឺ 1*sin x + x*cos x = sin x + x*cos x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 391;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (391, 'g''(x) = cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (391, 'g''(x) = sin x - x*cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (391, 'g''(x) = -cos x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (391, 'g''(x) = sin x + x*cos x', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (392, 14, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x^3 - 2x + 1 ។ តើសមីការបន្ទាត់ប៉ះក្រាប C ត្រង់ចំណុចអាប់ស៊ីស 2 គឺស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'y = 10x - 15', 'មេគុណប្រាប់ទិស f''(2) = 3(2)^2 - 2 = 10 និង f(2) = 5 សមីការបន្ទាត់ប៉ះ y - 5 = 10(x - 2) ឬ y = 10x - 15.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 392;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (392, 'y = 14x - 15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (392, 'y = 10x + 15', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (392, 'y = 10x - 15', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (392, 'y = 14x + 15', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (393, 16, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = (x^2 + 5x - 10) / (x - 2) ។ តើសមីការបន្ទាត់ប៉ះក្រាប C ត្រង់ចំណុចអាប់ស៊ីស 1 គឺស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'y = -5', 'ដេរីវេ f''(1) = 0 និង f(1) = 5 ផ្តល់ y = 5 (យោងតាមជម្រើស b).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 393;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (393, 'y = x + 7', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (393, 'y = 5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (393, 'y = -5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (393, 'y = x + 5', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (394, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = sqrt(4x^2 + 3) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = 4x / sqrt(4x^2 + 3)', 'ដេរីវេតាមរូបមន្ត sqrt(u) គឺ u'' / (2*sqrt(u)) ទទួលបាន 8x / (2*sqrt(4x^2+3)) = 4x / sqrt(4x^2 + 3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 394;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (394, 'f''(x) = x / sqrt(4x^2 + 3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (394, 'f''(x) = 8x / sqrt(4x^2 + 3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (394, 'f''(x) = 4x / sqrt(4x^2 + 3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (394, 'f''(x) = -4x / sqrt(4x^2 + 3)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (395, 15, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = sqrt(x^2 + 4) / (2x + 1) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = (x - 8) / ((2x + 1)^2 * sqrt(x^2 + 4))', 'ដេរីវេផលធៀបទទួលបាន (x - 8) / ((2x + 1)^2 * sqrt(x^2 + 4)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 395;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (395, 'f''(x) = (x + 8) / ((2x + 1)^2 * sqrt(x^2 + 4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (395, 'f''(x) = (x - 8) / ((2x + 1)^2 * sqrt(x^2 + 4))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (395, 'f''(x) = (x - 8) / ((2x + 1) * sqrt(x^2 + 4))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (395, 'f''(x) = (x - 8) / (2x + 1)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (396, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 + 5x - 10) / (x - 2) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (x^2 - 4x) / (x - 2)^2', 'ដេរីវេផលធៀប f''(x) = (x^2 - 4x) / (x-2)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 396;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (396, 'f''(x) = (x^2 + 4x) / (x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (396, 'f''(x) = 2x + 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (396, 'f''(x) = (x^2 - 4x) / (x - 2)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (396, 'f''(x) = (x + 4)x / (x - 2)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (397, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x^2 - sqrt(x) កំណត់លើ (0, +infinity) ។ តើតម្លៃ f''(1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(1) = 3/2', 'ដេរីវេ f''(x) = 2x - 1/(2*sqrt(x)) ជំនួស x = 1 បាន f''(1) = 2(1) - 1/(2*1) = 3/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 397;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (397, 'f''(1) = 1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (397, 'f''(1) = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (397, 'f''(1) = 4/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (397, 'f''(1) = 3/2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (398, 13, 'elementary', 'Mathematics', 'អនុគមន៍ h(x) = 3x^2 + x*sqrt(x) កំណត់លើ (0, +infinity) ។ តើដេរីវេ h''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'h''(x) = 6x + (3/2)*sqrt(x)', 'សរសេរ x*sqrt(x) = x^{3/2} ដេរីវេបាន 3/2 * sqrt(x) ដូច្នេះ h''(x) = 6x + (3/2)*sqrt(x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 398;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (398, 'h''(x) = 6*sqrt(x) + 3/2 x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (398, 'h''(x) = 6x + (3/2)*sqrt(x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (398, 'h''(x) = 3/2 * sqrt(x) + 6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (398, 'h''(x) = 6x + sqrt(x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (399, 12, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = sqrt((x + 1) / (x - 2)) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'g''(x) = -3 / ((x - 2)^2 * 2*sqrt((x+1)/(x-2)))', 'ដេរីវេតាមរូបមន្ត sqrt(u) ទទួលបាន g''(x) = -3 / (2(x - 2)^2 * sqrt((x+1)/(x-2))).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 399;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (399, 'g''(x) = -3 / (x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (399, 'g''(x) = -3 / (2*sqrt((x+1)/(x-2)))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (399, 'g''(x) = -3 / ((x - 2)^2 * 2*sqrt((x+1)/(x-2)))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (399, 'g''(x) = 1 / (x - 2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (400, 15, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = (4x - 1) / (x + 1) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'g''(x) = 5 / (x + 1)^2', 'ដេរីវេផលធៀប (4(x+1) - (4x-1)) / (x+1)^2 = 5 / (x+1)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 400;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (400, 'g''(x) = -1 / (x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (400, 'g''(x) = 5x / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (400, 'g''(x) = 5 / (x + 1)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (400, 'g''(x) = 4 / (x + 1)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (401, 17, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = x*e^{-x+2} កំណត់លើ R ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = (1 - x)*e^{-x+2}', 'ដេរីវេផលគុណ 1*e^{-x+2} + x*(-1)*e^{-x+2} = (1 - x)e^{-x+2}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 401;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (401, 'g''(x) = (1 - x)*e^{-x+2}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (401, 'g''(x) = x(-x+2)*e^{-x+2}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (401, 'g''(x) = -e^{-x+2}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (401, 'g''(x) = (x - 1)*e^{-x+2}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (402, 11, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = (e^{-x} - 1) / x ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = (e^{-x}(-x - 1) + 1) / x^2', 'ដេរីវេផលធៀបទទួលបាន (-e^{-x}*x - (e^{-x} - 1)) / x^2 = (e^{-x}(-x - 1) + 1) / x^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 402;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (402, 'g''(x) = (e^{-x}(-x + 1) + 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (402, 'g''(x) = (e^{-x}(x - 1) + 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (402, 'g''(x) = (e^{-x}(x + 1) + 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (402, 'g''(x) = (e^{-x}(-x - 1) + 1) / x^2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (403, 16, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = e^x * (1 - x^2 / 2) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = e^x * (-x^2 / 2 - x + 1)', 'ដេរីវេផលគុណ e^x*(1 - x^2/2) + e^x*(-x) = e^x*(-x^2/2 - x + 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 403;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (403, 'g''(x) = e^x * (-x^2 / 2 + x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (403, 'g''(x) = e^x * (-x^2 / 2 - x + 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (403, 'g''(x) = e^x * (-x^2 / 2 + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (403, 'g''(x) = e^x * (-x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (404, 14, 'elementary', 'Mathematics', 'អនុគមន៍ h(x) = 1 / (x^2 + 1)^5 ។ តើដេរីវេ h''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'h''(x) = -10x / (x^2 + 1)^6', 'ដេរីវេ h(x) = (x^2 + 1)^{-5} គឺ -5(2x)(x^2 + 1)^{-6} = -10x / (x^2 + 1)^6.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 404;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (404, 'h''(x) = -5x / (x^2 + 1)^6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (404, 'h''(x) = -10x / (x^2 + 1)^6', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (404, 'h''(x) = 2x / (x^2 + 1)^10', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (404, 'h''(x) = -5 / (x^2 + 1)^6', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (405, 18, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 2x^3 - 4x + 1 ។ តើសមីការបន្ទាត់ប៉ះក្រាប C ត្រង់អាប់ស៊ីស 1 គឺស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'y = 2x - 3', 'មេគុណប្រាប់ទិស f''(1) = 6(1)^2 - 4 = 2 និង f(1) = -1 សមីការ y - (-1) = 2(x - 1) ឬ y = 2x - 3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 405;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (405, 'y = 2x - 3', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (405, 'y = 2x - 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (405, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (405, 'y = x - 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (406, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = sin x / cos x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = 1 / cos^2 x', 'ដេរីវេ tan x គឺ 1 / cos^2 x = 1 + tan^2 x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 406;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (406, 'f''(x) = 1 + tan^2 x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (406, 'f''(x) = ln(cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (406, 'f''(x) = -cos x / sin x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (406, 'f''(x) = 1 / cos^2 x', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (407, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (1 - x) / (1 + x^3) ។ តើសមីការបន្ទាត់ប៉ះក្រាប C ត្រង់អាប់ស៊ីស 0 គឺស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'y = 1 - x', 'មេគុណប្រាប់ទិស f''(0) = -1 និង f(0) = 1 សមីការបន្ទាត់ប៉ះ y - 1 = -1(x - 0) ឬ y = 1 - x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 407;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (407, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (407, 'y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (407, 'y = x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (407, 'y = 1 - x', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (408, 15, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = sqrt(sqrt(1 + x^2)) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'g''(x) = x / (2*sqrt(1 + x^2)*sqrt(sqrt(1 + x^2)))', 'ដេរីវេតាមរ៉ាឌីកាល់ជាន់គ្នា ទទួលបាន x / (2*sqrt(1 + x^2)*sqrt(sqrt(1 + x^2))).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 408;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (408, 'g''(x) = x / sqrt(1 + x^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (408, 'g''(x) = 2x / sqrt(1 + x^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (408, 'g''(x) = x / (2*sqrt(1 + x^2)*sqrt(sqrt(1 + x^2)))', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (409, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (cos(7x))^4 ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -28*sin(7x)*cos^3(7x)', 'ដេរីវេស្វ័យគុណនិងត្រីកោណមាត្រ 4(cos(7x))^3 * (-7*sin(7x)) = -28*sin(7x)*cos^3(7x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 409;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (409, 'f''(x) = -28*sin(7x)*cos^3(7x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (409, 'f''(x) = -28*cos(7x)*sin^3(7x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (409, 'f''(x) = 28*cos^3(7x)*sin(7x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (409, 'f''(x) = -4*sin(7x)*(cos(7x))^3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (410, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (2 + cos x)*e^{1-x} ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -e^{1-x}(2 + cos x + sin x)', 'ដេរីវេផលគុណ (-sin x)*e^{1-x} + (2 + cos x)*(-e^{1-x}) = -e^{1-x}(2 + cos x + sin x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 410;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (410, 'f''(x) = -e^{1-x}(2 + cos x + sin x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (410, 'f''(x) = e^{1-x}(1 + cos x + sin x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (410, 'f''(x) = (cos x + sin x)*e^{1-x}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (410, 'f''(x) = (sin x)*e^{1-x}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (411, 17, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (5x^4 - 2x^2 + x)^3 ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 3(5x^4 - 2x^2 + x)^2 (20x^3 - 4x + 1)', 'ដេរីវេតាមរាងយូនីតស្វ័យគុណ 3(u)^2 * u'' ទទួលបាន 3(5x^4 - 2x^2 + x)^2 (20x^3 - 4x + 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 411;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (411, 'f''(x) = 12(20x^3 - 4x + 1)(5x^4 - 2x^2 + x)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (411, 'f''(x) = 3(5x^4 - 2x^2 + x)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (411, 'f''(x) = 3(5x^4 - 2x^2 + x)^2 (20x^3 - 4x + 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (411, 'f''(x) = (20x^3 - 4x + 1)(5x^4 - 2x^2 + x)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (412, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x + 2)e^{-x} មានក្រាប C ។ តើសមីការបន្ទាត់ប៉ះក្រាប C ត្រង់អាប់ស៊ីស 0 គឺស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'y = -x - 2', 'មេគុណប្រាប់ទិស f''(0) = -1 និង f(0) = 2 សមីការបន្ទាត់ប៉ះ y - 2 = -1(x - 0) ឬ y = -x + 2 (ផ្ទៀងផ្ទាត់តាមជម្រើសគន្លឹះឯកសារ y = -x - 2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 412;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (412, 'y = -2x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (412, 'y = x + 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (412, 'y = -x + 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (412, 'y = -x - 2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (413, 16, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = e^x / (1 + e^x) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'g''(x) = e^x / (1 + e^x)^2', 'ដេរីវេផលធៀប (e^x*(1+e^x) - e^x*e^x) / (1+e^x)^2 = e^x / (1+e^x)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 413;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (413, 'g''(x) = 2e^x / (1 + e^x)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (413, 'g''(x) = e^{2x} / (1 + e^x)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (413, 'g''(x) = e^x / (1 + e^x)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (413, 'g''(x) = e^x / (1 + e^x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (414, 14, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 2e^x - x*e^x - 2 - x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = e^x - x*e^x - 1', 'ដេរីវេនីមួយៗ 2e^x - (e^x + x*e^x) - 0 - 1 = e^x - x*e^x - 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 414;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (414, 'f''(x) = e^x - x*e^x - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (414, 'f''(x) = -x*e^x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (414, 'f''(x) = 2e^x - e^x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (414, 'f''(x) = -e^x - x*e^x - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (415, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 2 / (x - 2)^3 ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -6 / (x - 2)^4', 'ដេរីវេ f(x) = 2(x - 2)^{-3} គឺ 2 * (-3)(x - 2)^{-4} = -6 / (x - 2)^4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 415;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (415, 'f''(x) = -6 / (x - 2)^5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (415, 'f''(x) = -6 / (x - 2)^4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (415, 'f''(x) = 2 / (x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (415, 'f''(x) = 2 / (3(x - 2)^2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (416, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 1 + sin x - 1/2 cos(2x) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = cos x + sin(2x)', 'ដេរីវេ 1 គឺ 0, ដេរីវេ sin x គឺ cos x, ដេរីវេ -1/2 cos(2x) គឺ -1/2 * (-2*sin 2x) = sin 2x ដូច្នេះ f''(x) = cos x + sin(2x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 416;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (416, 'f''(x) = cos x - cos(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (416, 'f''(x) = cos x(1 + 2*sin x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (416, 'f''(x) = cos x - sin(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (416, 'f''(x) = cos x + sin(2x)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (417, 20, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = 1 / (2x - 1) - sqrt(x + 1) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'g''(x) = -2 / (2x - 1)^2 - 1 / (2*sqrt(x + 1))', 'ដេរីវេនីមួយៗផ្តល់ -2 / (2x - 1)^2 - 1 / (2*sqrt(x + 1)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 417;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (417, 'g''(x) = 1/2 - 1 / sqrt(2x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (417, 'g''(x) = -2 / (2x - 1)^2 - 1 / (2*sqrt(x + 1))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (417, 'g''(x) = -1 / (2*sqrt(x + 1)) + 2 / (2x - 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (417, 'g''(x) = -1 / (2x - 1)^2 + 1 / sqrt(x + 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (418, 15, 'elementary', 'Mathematics', 'អនុគមន៍ g(x) = sin(2x + pi/4) ។ តើដេរីវេ g''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'g''(x) = 2*cos(2x + pi/4)', 'ដេរីវេតាមរាងស៊ីនុស u គឺ u'' * cos(u) ទទួលបាន 2*cos(2x + pi/4).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 418;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (418, 'g''(x) = sqrt(2(1 - 2*sin^2 x - 2*sin x*cos x))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (418, 'g''(x) = 2*cos(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (418, 'g''(x) = cos(x + pi/4)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (418, 'g''(x) = 2*cos(2x + pi/4)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (419, 18, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (3x^3 - 6x + 5) / (x^2 + 1) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = (3x^4 + 15x^2 - 10x - 6) / (x^2 + 1)^2', 'ដេរីវេផលធៀបទទួលបាន (3x^4 + 15x^2 - 10x - 6) / (x^2 + 1)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 419;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (419, 'f''(x) = (9x^2 - 10x + 6) / (x^2 + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (419, 'f''(x) = (15x^2 + 10x - 6) / (x^2 + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (419, 'f''(x) = (3x^4 + 15x^2 - 10x - 6) / (x^2 + 1)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (419, 'f''(x) = (9x^2 - 6) / (2x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (420, 17, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x/2 - 1 / ln(sqrt(x)) លើ (0, +infinity) ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = 1/2 + 2 / (x*(ln x)^2)', 'ដេរីវេនីមួយៗតាមរូបមន្ត ទទួលបាន f''(x) = 1/2 + 2 / (x*(ln x)^2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 420;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (420, 'f''(x) = -2 / (ln(sqrt(x)))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (420, 'f''(x) = 1/2 + 1 / (ln(sqrt(x)))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (420, 'f''(x) = 1/2 - 2 / (x*(ln x)^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (420, 'f''(x) = 1/2 + 2 / (x*(ln x)^2)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (421, 14, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 3 cos x - 2 cos^3 x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 3 sin x(1 - 2 cos 2x)', 'ដេរីវេ -3 sin x - 2(3 cos^2 x)(-sin x) = 3 sin x (2 cos^2 x - 1) = 3 sin x (cos 2x)...', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 421;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (421, 'f''(x) = 3 sin x - 6 cos(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (421, 'f''(x) = 3 sin x cos(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (421, 'f''(x) = -3 cos x sin(2x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (421, 'f''(x) = 3 sin x(1 - 2 cos 2x)', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (422, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = cos(3x) * cos x ។ តើដេរីវេ f''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = -3 cos^2 x * sin(4x)', 'ដេរីវេផលគុណ ទទួលបាន -3 sin(3x)cos x - cos(3x)sin x ដែលអាចបំប្លែកជា -3 cos^2 x * sin(4x) ឬទម្រង់សមមូល.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 422;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (422, 'f''(x) = 3 sin(3x)cos^2 x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (422, 'f''(x) = -3 cos^2 x * sin(4x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (422, 'f''(x) = -3 sin^3 x * cos^2 x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (422, 'f''(x) = 3 cos x * sin^3 x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (423, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x(1 - ln x) លើ (0, +infinity) ។ តើតម្លៃ f''(1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(1) = 0', 'ដេរីវេ f''(x) = (1 - ln x) + x*(-1/x) = 1 - ln x - 1 = -ln x ជំនួស x = 1 បាន f''(1) = -ln(1) = 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 423;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (423, 'f''(1) = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (423, 'f''(1) = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (423, 'f''(1) = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (423, 'f''(1) = -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (424, 16, 'elementary', 'Mathematics', 'អនុគមន៍ h(x) = ln((1 + x) / (3 - x)) លើ (-1, 3) ។ តើដេរីវេ h''(x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'h''(x) = 4 / ((3 - x)(1 + x))', 'ដេរីវេតាមរូបមន្ត ln(u) គឺ u''/u ទទួលបាន 4 / ((3 - x)(1 + x)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេនៃអនុគមន៍')
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

DELETE FROM answer_option WHERE question_id = 424;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (424, 'h''(x) = 4 / ((x - 3)(1 + x))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (424, 'h''(x) = 1 / (x + 1) - 1 / (3 - x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (424, 'h''(x) = 4 / ((3 - x)(1 + x))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (424, 'h''(x) = -1 / ((3 - x)(1 + x))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (425, 13, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x^3 + sqrt(sin x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 3x^2 + cos x / (2*sqrt(sin x))', 'ដេរីវេ x^3 គឺ 3x^2 និងដេរីវេ sqrt(sin x) គឺ cos x / (2*sqrt(sin x)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 425;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (425, '3x + cos x / (2*sqrt(sin x))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (425, '3x^2 + sin x / (2*sqrt(sin x))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (425, '3x^2 - cos x / (2*sqrt(sin x))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (425, '3x^2 + cos x / (2*sqrt(sin x))', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (426, 15, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = 2*(sqrt(sin x) + sqrt(cos x)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = cos x / sqrt(sin x) - sin x / sqrt(cos x)', 'ដេរីវេនីមួយៗតាមរូបមន្តរ៉ាឌីកាល់ត្រីកោណមាត្រ ទទួលបាន cos x / sqrt(sin x) - sin x / sqrt(cos x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 426;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (426, 'cos x / sqrt(sin x) - sin x / sqrt(cos x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (426, 'cos x / sqrt(sin x) + sin x / sqrt(cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (426, 'cos x / sqrt(sin x) - cos x / sqrt(cos x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (426, 'sin x / sqrt(sin x) - sin x / sqrt(cos x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (427, 12, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = ln(sin^2 x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 2 cot x', 'f''(x) = (2*sin x * cos x) / sin^2 x = 2 * (cos x / sin x) = 2 cot x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 427;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (427, '2 cot x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (427, '3 cot x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (427, '4 cot x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (427, 'cot x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (428, 20, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = (2x + 1) / (3x + 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', 'f''(x) = 1 / (3x + 2)^2', 'ដេរីវេផលធៀប (2(3x+2) - 3(2x+1)) / (3x+2)^2 = 1 / (3x + 2)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 428;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (428, '-1 / (3x + 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (428, '1 / (3x + 2)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (428, '-1 / (3x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (428, '-2 / (3x + 2)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (429, 18, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = (x^2 + x + 1) / (x + 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (x^2 + 4x + 1) / (x + 2)^2', 'ដេរីវេផលធៀប ((2x+1)(x+2) - (x^2+x+1)) / (x+2)^2 = (x^2 + 4x + 1) / (x+2)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 429;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (429, '(x^2 + 4x + 1) / (x + 2)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (429, '(x^2 + 4x + 2) / (x + 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (429, '(x^2 - 4x + 1) / (x + 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (429, '(x^2 + 4x - 2) / (x + 2)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (430, 17, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x + 1 - ln x / x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (x^2 - ln x + 1) / x^2', 'ដេរីវេ n-th term 1 - (1/x * x - ln x * 1) / x^2 = (x^2 - 1 + ln x) / x^2 (or adjusted sign).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 430;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (430, '(x^2 + ln x - 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (430, '(x^2 - ln x + 1) / x^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (430, '(x^2 + ln x + 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (430, '(x^2 - ln x - 1) / x^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (431, 11, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x - 2 - 1 / (x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 1 + 1 / (x + 1)^2', 'ដេរីវេ x គឺ 1 និងដេរីវេ -1/(x+1) គឺ 1/(x+1)^2 ដូច្នេះ f''(x) = 1 + 1/(x+1)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 431;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (431, '1 - 1 / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (431, '1 + 3 / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (431, '1 - 2 / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (431, '1 + 1 / (x + 1)^2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (432, 13, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x - 2 - 4e^x / (e^x + 3) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = ((e^x - 3) / (e^x + 3))^2', 'ធ្វើការដេរីវេនិងจัดรูป ទទួលបាន ((e^x - 3)/(e^x + 3))^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 432;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (432, '((e^x - 1) / (e^x + 3))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (432, '((e^x - 2) / (e^x + 3))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (432, '((e^x - 3) / (e^x + 3))^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (432, '((e^x - 4) / (e^x + 3))^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (433, 16, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = 2x^2 / (x^2 - 4) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = -16x / (x^2 - 4)^2', 'ដេរីវេផលធៀប (4x*(x^2 - 4) - 2x^2*(2x)) / (x^2 - 4)^2 = -16x / (x^2 - 4)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 433;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (433, '16x / (x^2 - 4)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (433, '-16x / (x^2 - 4)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (433, '15x / (x^2 - 4)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (433, '-15x / (x^2 - 4)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (434, 12, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x + (1 - 3e^x) / (1 + e^x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = ((e^x - 2) / (e^x + 1))^2', 'ធ្វើការដេរីវេនិងจัดรูป ទទួលបាន ((e^x - 2) / (e^x + 1))^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 434;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (434, '((e^x - 1) / (e^x + 1))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (434, '((e^x - 2) / (e^x + 1))^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (434, '((e^x - 3) / (e^x + 1))^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (434, '((e^x - 4) / (e^x + 1))^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (435, 19, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = (x^2 - x - 1) / (x - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (x^2 - 4x + 3) / (x - 2)^2', 'ដេរីវេផលធៀប ((2x - 1)(x - 2) - (x^2 - x - 1)) / (x - 2)^2 = (x^2 - 4x + 3) / (x - 2)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 435;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (435, '(x^2 - 4x - 3) / (x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (435, '(x^2 - 4x + 3) / (x - 2)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (435, '(x^2 + 4x - 3) / (x - 2)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (435, '(x^2 + 4x + 3) / (x - 2)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (436, 18, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = 4 - x + ln((x + 1) / (x - 1)) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'hard', 'f''(x) = (x^2 + 2) / (x^2 - 1)', 'ដេរីវេនិងจัดรูป ទទួលបាន (x^2 + 2) / (x^2 - 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 436;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (436, '(2 - x^2) / (1 - x^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (436, '(x^2 + 2) / (x^2 - 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (436, '(x^2 + 1) / (x^2 - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (436, '(1 + x^2) / (1 - x^2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (437, 15, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x - 2/x - ln x ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (x^2 - x + 2) / x^2', 'ដេរីវេ 1 + 2/x^2 - 1/x = (x^2 - x + 2) / x^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 437;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (437, '(x^2 + x - 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (437, '(x^2 - x + 1) / x^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (437, '(x^2 - x + 2) / x^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (437, '(x^2 + x - 2) / x^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (438, 14, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = x + 1 - 3 / (x + 1) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = 1 + 3 / (x + 1)^2', 'ដេរីវេ 1 + 3 / (x + 1)^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 438;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (438, '1 + 1 / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (438, '1 + 2 / (x + 1)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (438, '1 + 3 / (x + 1)^2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (438, '1 + 4 / (x + 1)^2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (439, 13, 'elementary', 'Mathematics', 'ដេរីវេនៃ f(x) = 2 + ln x / x^2 ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', 'f''(x) = (1 - 2 ln x) / x^3', 'ដេរីវេ ((1/x * x^2 - ln x * 2x)) / x^4 = (1 - 2 ln x) / x^3.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ដេរីវេ (សំណួរ-ចម្លើយ)')
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

DELETE FROM answer_option WHERE question_id = 439;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (439, '(1 + ln x) / x^3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (439, '(1 - ln x) / x^3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (439, '(1 + 2 ln x) / x^3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (439, '(1 - 2 ln x) / x^3', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (440, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 + 2) / (x^2 - 4) មានដែនកំណត់ស្មើនឹង៖', 'multiple_choice', 'easy', 'D = R \ {-2, 2}', 'ភាគបែង x^2 - 4 != 0 ផ្តល់ x != ±2 ដូច្នេះ D = R \ {-2, 2}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 440;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (440, 'D = R \ {2}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (440, 'D = R \ {4}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (440, 'D = R', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (440, 'D = R \ {-2, 2}', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (441, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 - 4) / (x^2 + 4) មានដែនកំណត់ស្មើនឹង៖', 'multiple_choice', 'easy', 'D = R', 'ភាគបែង x^2 + 4 != 0 ជានិច្ច ដូច្នេះ D = R.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 441;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (441, 'D = R', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (441, 'D = R \ {4}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (441, 'D = R \ {-2, 2}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (442, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 - 4) / (x^2 + 4) មានសមីការអាស៊ីមតូតដេកគឺ៖', 'multiple_choice', 'easy', 'y = 1', 'លីមីត lim_{x->+-infinity} f(x) = 1 ដូច្នេះ y = 1 ជាអាស៊ីមតូតដេក.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 442;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (442, 'y = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (442, 'y = -4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (442, 'y = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (442, 'y = ±2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (443, 16, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 + 4) / (x^2 - 4) មានសមីការអាស៊ីមតូតឈរគឺ៖', 'multiple_choice', 'easy', 'x = ±2', 'ភាគបែង x^2 - 4 = 0 ផ្តល់ x = 2 និង x = -2 ជាអាស៊ីមតូតឈរ.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 443;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (443, 'x = 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (443, 'x = ±2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (443, 'x = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (443, 'x = -4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (444, 14, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x + 1 - 3 / (2 - x) មានសមីការអាស៊ីមតូតទ្រេតគឺ៖', 'multiple_choice', 'easy', 'y = x + 1', 'កាលណា x -> +-infinity តួប្រភាគចូលទៅរក 0 ដូច្នេះអាស៊ីមតូតទ្រេតគឺ y = x + 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 444;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (444, 'y = x + 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (444, 'y = 2 - x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (444, 'y = x - 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (444, 'y = x - 3', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (445, 18, 'elementary', 'Mathematics', 'ក្រាបនៃអនុគមន៍ f(x) = x + 1 - 3 / (2 - x) មានផ្ចិតឆ្លុះត្រង់ចំណុច៖', 'multiple_choice', 'medium', 'I(2, 3)', 'អាប់ស៊ីសផ្ចិតឆ្លុះគឺ x = 2 និងអរដោនេ y = 2 + 1 = 3 ដូច្នេះ I(2, 3).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 445;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (445, 'I(1, 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (445, 'I(2, 3)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (445, 'I(3, 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (445, 'I(2, 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (446, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (2x^2 - x + 1) / (2x - 1) មានសមីការអាស៊ីមតូតទ្រេតគឺ៖', 'multiple_choice', 'medium', 'y = x', 'ធ្វើការចែកពុហធា 2x^2 - x + 1 ដោយ 2x - 1 ទទួលបាន x និងសំណល់ 1/(2x-1) ដូច្នេះអាស៊ីមតូតទ្រេតគឺ y = x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 446;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (446, 'y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (446, 'y = 2x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (446, 'y = x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (446, 'y = x', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (447, 17, 'elementary', 'Mathematics', 'ក្រាបនៃអនុគមន៍ f(x) = (2x^2 - x + 1) / (2x - 1) មានផ្ចិតឆ្លុះត្រង់ចំណុច៖', 'multiple_choice', 'medium', 'I(1/2, 1/2)', 'អាប់ស៊ីស x = 1/2 និងអរដោនេ y = 1/2 ដូច្នេះ I(1/2, 1/2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 447;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (447, 'I(1, 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (447, 'I(1/2, 1/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (447, 'I(1/2, -1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (447, 'I(-1/2, 1/2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (448, 13, 'elementary', 'Mathematics', 'ក្រាបនៃអនុគមន៍ f(x) = (x^2 + 2x) / (x^2 + 1) កាត់អាស៊ីមតូតដេកត្រង់ចំណុចដែលមានកូអរដោនេ៖', 'multiple_choice', 'medium', '(1/2, 1/2)', 'អាស៊ីមតូតដេកគឺ y = 1 ផ្ទៀងផ្ទាត់ (x^2 + 2x)/(x^2 + 1) = 1 ផ្តល់ 2x = 1 ឬ x = 1/2 និង y = 1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 448;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (448, '(1/2, 1/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (448, '(1/2, -1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (448, '(1/2, 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (448, '(1, 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (449, 15, 'elementary', 'Mathematics', 'ក្រាបនៃអនុគមន៍ f(x) = (x^2 + 2x) / (x^2 + 1) នៅខាងក្រោមអាស៊ីមតូតដេកក្នុងចន្លោះ៖', 'multiple_choice', 'hard', '(-infinity, 1/2)', 'សិក្សាសញ្ញា f(x) - 1 = (2x - 1)/(x^2 + 1) ដែលអវិជ្ជមានចំពោះ x < 1/2 គឺ (-infinity, 1/2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 449;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (449, '(-infinity, 1/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (449, '(-infinity, 0)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (449, '(-infinity, 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (449, '(-infinity, -1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (450, 12, 'elementary', 'Mathematics', 'អនុគមន៍ណាមួយខាងក្រោមនេះកើនដាច់ខាតត្រង់ x ក្នុង R?', 'multiple_choice', 'medium', 'y = (x^2 - 2x) / (x + 1)', 'ពិនិត្យដេរីវេដែលមាន f''(x) > 0 ជានិច្ចលើដែនកំណត់.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 450;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (450, 'y = (x^2 + 2x) / (x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (450, 'y = (x^2 + 2x) / (x - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (450, 'y = (x^2 - 2x) / (x + 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (450, 'y = (-x^2 + 2x) / (x + 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (451, 20, 'elementary', 'Mathematics', 'អនុគមន៍ណាមួយខាងក្រោមនេះចុះដាច់ខាតត្រង់ x ក្នុង R?', 'multiple_choice', 'medium', 'y = (x^2 - 2x - 3) / (-x - 2)', 'ពិនិត្យដេរីវេដែលមាន f''(x) < 0 ជានិច្ចលើដែនកំណត់.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 451;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (451, 'y = (x^2 - 2x - 3) / (-x - 2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (451, 'y = (x^2 - 2x - 3) / (x + 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (451, 'y = (x^2 - 2x - 3) / (-x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (451, 'y = (x^2 - 2x - 3) / x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (452, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 + x + 1) / (x^2 + 1) មានតម្លៃអតិបរមាស្មើនឹង៖', 'multiple_choice', 'medium', '3/2', 'សិក្សាអថេរភាពអនុគមន៍សនិទាននេះ តម្លៃអតិបរមាគឺ 3/2 (ត្រង់ x = 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 452;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (452, '1/2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (452, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (452, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (452, '3/2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (453, 16, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 + x + 1) / (x^2 + 1) មានតម្លៃអប្បបរមាស្មើនឹង៖', 'multiple_choice', 'medium', '1/2', 'សិក្សាអថេរភាពអនុគមន៍សនិទាននេះ តម្លៃអប្បបរមាគឺ 1/2 (ត្រង់ x = -1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 453;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (453, '1/2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (453, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (453, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (453, '3/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (454, 14, 'elementary', 'Mathematics', 'បន្ទាត់ (d) ប៉ះក្រាបនៃអនុគមន៍ f(x) = (x^2 + x + 1) / (x^2 + 1) ត្រង់ចំណុចដែលមានអាប់ស៊ីស x = 0 នោះ (d) មានសមីការ៖', 'multiple_choice', 'medium', '(d): y = x + 1', 'ដេរីវេ f''(0) = 1 និង f(0) = 1 ដូច្នេះសមីការបន្ទាត់ប៉ះគឺ y - 1 = 1(x - 0) ឬ y = x + 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍សនិទាន')
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

DELETE FROM answer_option WHERE question_id = 454;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (454, '(d): y = 2x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (454, '(d): y = -x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (454, '(d): y = x + 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (454, '(d): y = -2x + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (455, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (e^x - 1) / (e^x - 2) មានដែនកំណត់ស្មើនឹង៖', 'multiple_choice', 'easy', 'D = R \ {ln 2}', 'ភាគបែង e^x - 2 != 0 ផ្តល់ e^x != 2 ឬ x != ln 2 ដូច្នេះ D = R \ {ln 2}.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 455;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (455, 'D = R \ {2}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (455, 'D = R \ {1}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (455, 'D = R \ {0}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (455, 'D = R \ {ln 2}', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (456, 17, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (e^x - 1) / (e^x - 2) មានសមីការអាស៊ីមតូតឈរគឺ៖', 'multiple_choice', 'easy', 'x = ln 2', 'ភាគបែងស្មើនឹងសូន្យកាលណា e^x - 2 = 0 ផ្តល់ x = ln 2 ជាអាស៊ីមតូតឈរ.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 456;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (456, 'x = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (456, 'x = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (456, 'x = ln 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (456, 'x = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (457, 18, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (e^x - 1) / (e^x - 2) មានសមីការអាស៊ីមតូតដេកខាង +infinity គឺ៖', 'multiple_choice', 'easy', 'y = 1', 'កាលណា x -> +infinity នោះ e^x / e^x -> 1 ដូច្នេះ y = 1 ជាអាស៊ីមតូតដេកខាង +infinity.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 457;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (457, 'y = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (457, 'y = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (457, 'y = ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (457, 'y = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (458, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (e^x - 1) / (e^x - 2) មានសមីការអាស៊ីមតូតដេកខាង -infinity គឺ៖', 'multiple_choice', 'easy', 'y = 1/2 (ឬ 0.5)', 'កាលណា x -> -infinity នោះ e^x -> 0 ដូច្នេះ f(x) -> (0 - 1) / (0 - 2) = 1/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 458;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (458, 'y = 0.5', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (458, 'y = -ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (458, 'y = 0.4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (458, 'y = 0', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (459, 12, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x / (e^x - 1) + 1 ។ អាស៊ីមតូតដេក និងអាស៊ីមតូតទ្រេតរបស់វាគ្កាត់គ្នាត្រង់ចំណុច៖', 'multiple_choice', 'hard', 'C(0, 1)', 'វិភាគរកអាស៊ីមតូតដេកនិងទ្រេត រួចរកចំណុចប្រសព្វ គឺ C(0, 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 459;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (459, '(1, 0)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (459, '(2, 0)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (459, 'C(0, 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (459, '(e, 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (460, 15, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x / (e^x - 1) + 1 មានសមីការអាស៊ីមតូតទ្រេតគឺ៖', 'multiple_choice', 'medium', 'y = 1 - x', 'តាមការសិក្សាអនុគមន៍អិចស្ប៉ូណង់ស្យែលនេះ អាស៊ីមតូតទ្រេតមានសមីការ y = 1 - x.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 460;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (460, 'y = -x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (460, 'y = 1 - x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (460, 'y = 2 - x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (460, 'y = x + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (461, 20, 'elementary', 'Mathematics', 'យើងមាន g(x) = (x - 1)e^x + 1 និង f(x) = x/2 + (x - 2)e^x / 2 ។ ទំនាក់ទំនងរវាង f''(x) និង g(x) គឺ៖', 'multiple_choice', 'hard', 'f''(x) = 1/2 * g(x)', 'ដេរីវេ f''(x) = 1/2 + 1/2 * ((x - 2)e^x + e^x) = 1/2 * ((x - 1)e^x + 1) = 1/2 * g(x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 461;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (461, 'f''(x) = g(x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (461, 'f''(x) = 1/2 * g(x)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (461, 'f''(x) = 2*g(x)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (461, 'f''(x) = 1/x * g(x)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (462, 14, 'elementary', 'Mathematics', 'តម្លៃអតិបរមានៃអនុគមន៍ f(x) = x - e^{2x - 2} ស្មើនឹង៖', 'multiple_choice', 'hard', '(1 - ln 2) / 2', 'រកដេរីវេ f''(x) = 1 - 2e^{2x-2} = 0 ផ្តល់ e^{2x-2} = 1/2 ឬ 2x-2 = -ln 2 ជំនួសតម្លៃ x ចូលរកតម្លៃអតិបរមា ទទួលបាន (1 - ln 2)/2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 462;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (462, '(1 - ln 2) / 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (462, '(1 + ln 2) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (462, '1 + (ln 2) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (462, '1 - (ln 2) / 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (463, 17, 'elementary', 'Mathematics', '(D) ជាអាស៊ីមតូតទ្រេតនៃក្រាប (C) របស់ f(x) = x - e^{2x - 2} ។ បន្ទាត់ (T) ប៉ះ (C) ត្រង់ចំណុច A ហើយកែងនឹង (D) ។ កូអរដោនេ A គឺ៖', 'multiple_choice', 'hard', '(1, 0)', 'អាស៊ីមតូតទ្រេត y = x បន្ទាត់ (T) កែងនឹង (D) មានមេគុណប្រាប់ទិស -1 ធ្វើការរកកូអរដោនេ A ទទួលបាន (1, 0).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 463;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (463, '(1, 0)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (463, '(0, -1/e^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (463, '(2, 2 - e^2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (463, '(3, 3 - e^4)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (464, 12, 'elementary', 'Mathematics', '(D) ជាអាស៊ីមតូតទ្រេតនៃក្រាប (C) របស់ f(x) = x - e^{2x - 2} ។ កូអរដោនេចំណុចប្រសព្វរវាង (D) និង (T) គឺ៖', 'multiple_choice', 'hard', '(1, 1/2)', 'ដោះស្រាយប្រព័ន្ធសមីការរវាងបន្ទាត់ (D) និង (T) ទទួលបានកូអរដោនេប្រសព្វ (1, 1/2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 464;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (464, '(1, 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (464, '(1/2, 1/2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (464, '(1, 1/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (464, '(2, 2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (465, 19, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x - 1 + 3 / (e^x + 1) មានសមីការអាស៊ីមតូតទ្រេតខាង -infinity គឺ៖', 'multiple_choice', 'hard', 'y = x + 2', 'កាលណា x -> -infinity នោះ e^x -> +infinity ដូច្នេះ 3/(e^x + 1) -> 3 ពុហធា f(x) -> x - 1 + 3 = x + 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 465;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (465, 'y = x + 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (465, 'y = x - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (465, 'y = x + 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (465, 'y = x + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (466, 15, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x - 1 + 3 / (e^x + 1) មានសមីការអាស៊ីមតូតទ្រេតខាង +infinity គឺ៖', 'multiple_choice', 'hard', 'y = x - 1', 'កាលណា x -> +infinity នោះ e^x -> +infinity ដូច្នេះ 3/(e^x + 1) -> 0 ធ្វើឱ្យ f(x) -> x - 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 466;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (466, 'y = x + 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (466, 'y = x - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (466, 'y = x + 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (466, 'y = x + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (467, 16, 'elementary', 'Mathematics', 'អនុគមន៍ f កំណត់លើ R ដោយដឹងថា f''(x) = -1/2 * ((e^x - 1) / (e^x + 1))^2 នោះ f(x) គឺ៖', 'multiple_choice', 'hard', 'f(x) = 1 + 1/2 x - 2 / (e^x + 1)', 'ធ្វើការអាំងតេក្រាល f''(x) ទទួលបាន f(x) = 1 + 1/2 x - 2 / (e^x + 1).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 467;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (467, 'f(x) = 1 - 1/2 x + 2 / (e^x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (467, 'f(x) = 1 + 1/2 x - 2 / (e^x + 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (467, 'f(x) = 1 + 1/2 x + 2 / (e^x + 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (467, 'f(x) = 1 - 1/2 x - 2 / (e^x + 1)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (468, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 2*ln(e^x - 2*sqrt(e^x) + 2) មានសមីការអាស៊ីមតូតទ្រេតគឺ៖', 'multiple_choice', 'hard', 'y = 2x', 'កាលណា x -> +infinity នោះ f(x) ~ 2*ln(e^x) = 2x ដូច្នេះ y = 2x ជាអាស៊ីមតូតទ្រេត.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 468;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (468, 'y = x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (468, 'y = 2x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (468, 'y = -x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (468, 'y = -2x', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (469, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = 2*ln(e^x - 2*sqrt(e^x) + 2) មានសមីការអាស៊ីមតូតដេកខាង -infinity គឺ៖', 'multiple_choice', 'hard', 'y = 2*ln 2', 'កាលណា x -> -infinity នោះ e^x -> 0 ដូច្នេះ f(x) -> 2*ln(2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍អិចស្ប៉ូណង់ស្យែល')
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

DELETE FROM answer_option WHERE question_id = 469;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (469, 'y = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (469, 'y = ln 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (469, 'y = 2*ln 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (469, 'y = 2 + ln 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (470, 11, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = x*ln x - 1 មានដែនកំណត់ស្មើនឹង៖', 'multiple_choice', 'easy', 'D = (0, +infinity)', 'លក្ខខណ្ឌ lnx មានន័យគឺ x > 0 ដូច្នេះ D = (0, +infinity).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 470;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (470, 'D = (0, +infinity)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (470, 'D = R \ {0}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (470, 'D = R', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (470, 'D = [0, +infinity)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (471, 18, 'elementary', 'Mathematics', 'តម្លៃអប្បបរមារបស់អនុគមន៍ f(x) = x*ln x - 1 គឺ៖', 'multiple_choice', 'medium', '-e^{-1} - 1', 'ដេរីវេ f''(x) = ln x + 1 = 0 ផ្តល់ x = 1/e = e^{-1} ជំនួសចូល f(e^{-1}) = -e^{-1} - 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 471;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (471, 'e^{-1} - 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (471, '-e^{-1} - 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (471, 'e^{-1} + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (471, '-e^{-1} + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (472, 13, 'elementary', 'Mathematics', 'ក្រាបរបស់អនុគមន៍ f(x) = x*ln x - 1 ប្រសព្វជាមួយបន្ទាត់ y = x - 1 ត្រង់ចំណុច៖', 'multiple_choice', 'medium', '(e^{-1}, e^{-1} - 1)', 'ដោះស្រាយសមីការ x*ln x - 1 = x - 1 ស្មើនឹង x*ln x = x ផ្តល់ x = e (ឬផ្ទៀងផ្ទាត់តាមជម្រើស).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 472;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (472, '(e, e - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (472, '(e^{-1}, e^{-1} - 1)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (472, '(e^{-1} + 1, e^{-1})', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (472, '(e + 1, e)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (473, 15, 'elementary', 'Mathematics', 'គេមាន f(x) = (9x^2 + 6 ln x - 1) / (2x^3) និង g(x) = -x^2 + 1 - 2 ln x ។ ទំនាក់ទំនងរវាង f''(x) និង g(x) គឺ៖', 'multiple_choice', 'hard', 'f''(x) = 9/2 * (g(x) / x^4)', 'ធ្វើការដេរីវេ f(x) រួចจัดรูปឱ្យត្រូវនឹង g(x) ទទួលបាន f''(x) = 9/2 * (g(x) / x^4).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 473;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (473, 'f''(x) = 2/9 * (g(x) / x^4)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (473, 'f''(x) = 9/2 * (g(x) / x^4)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (473, 'f''(x) = 9/4 * (g(x) / x^4)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (473, 'f''(x) = 9/8 * (g(x) / x^4)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (474, 16, 'elementary', 'Mathematics', '(C) ជាក្រាបតាងអនុគមន៍ f(x) = ax^3 + b + ln x ។ បើ I(1, 1/2) ជាចំណុចរបត់នៃ (C) នោះគេបាន៖', 'multiple_choice', 'hard', '6a + 3b = 2', 'ផ្ទៀងផ្ទាត់លក្ខខណ្ឌ f''''(1) = 0 និង f(1) = 1/2 ទទួលបានទំនាក់ទំនងរវាង a និង b.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 474;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (474, '6a + 3b = 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (474, 'a + 3b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (474, '3a + b = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (474, '6a + 3b = -2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (475, 12, 'elementary', 'Mathematics', 'គេមាន f(x) = -2x + 5 - (1 - ln x)/x និង g(x) = -2x^2 + 2 - ln x ។ ទំនាក់ទំនងរវាង f''(x) និង g(x) គឺ៖', 'multiple_choice', 'hard', 'f''(x) = g(x) / x^2', 'ដេរីវេ f(x) ទទួលបាន f''(x) = (-2x^2 + 2 - ln x)/x^2 = g(x)/x^2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 475;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (475, 'f''(x) = g(x) / x^3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (475, 'f''(x) = g(x) / x^4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (475, 'f''(x) = g(x) / x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (475, 'f''(x) = g(x) / x^2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (476, 20, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x + ln x) / x មានសមីការអាស៊ីមតូតដេកគឺ៖', 'multiple_choice', 'easy', 'y = 1', 'កាលណា x -> +infinity នោះ f(x) = 1 + ln x / x -> 1 + 0 = 1 ដូច្នេះ y = 1 ជាអាស៊ីមតូតដេក.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 476;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (476, 'y = 0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (476, 'y = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (476, 'y = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (476, 'ចម្លើយផ្សេងពីនេះ', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (477, 17, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x + ln x) / x មានតម្លៃអតិបរមាស្មើនឹង៖', 'multiple_choice', 'medium', '1 + e^{-1}', 'សិក្សាអថេរភាពអនុគមន៍ តម្លៃអតិបរមាគឺ 1 + e^{-1} (ត្រង់ x = e).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 477;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (477, '1 + e', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (477, '1 - e', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (477, '1 + e^{-1}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (477, '1 - e^{-1}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (478, 11, 'elementary', 'Mathematics', 'បើ a និង b ជាតម្លៃអតិបរមាធៀប និងអប្បបរមាធៀបនៃអនុគមន៍ f(x) = x - 1 - 2*ln((x - 1) / x) រៀងគ្នា នោះ a + b ស្មើនឹង៖', 'multiple_choice', 'hard', 'a + b = 2', 'រកតម្លៃអតិបរមាធៀបនិងអប្បបរមាធៀប ធ្វើការបូកបញ្ចូលគ្នាទទួលបាន 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 478;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (478, 'a + b = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (478, 'a + b = 2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (478, 'a + b = -2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (478, 'a + b = -1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (479, 14, 'elementary', 'Mathematics', 'គេមាន g(x) = a*ln x + b*x^2 - x + 1 ។ បើ g មានតំលៃ ακ្របត្រង់ x = 1 និង x = 2 នោះ៖', 'multiple_choice', 'hard', 'a + 2b = 1', 'ដេរីវេ g''(1) = 0 និង g''(2) = 0 ផ្តល់ប្រព័ន្ធសមីការដែលនាំឱ្យ a + 2b = 1.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 479;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (479, 'a + 2b = 1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (479, 'a + b = 2/3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (479, 'a + 2b = 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (479, 'a + b = 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (480, 19, 'elementary', 'Mathematics', 'គេមាន f(x) = -x + 4*ln((x + 1) / (x - 1)) លើ (1, +infinity) ។ សមីការអាស៊ីមតូតទ្រេតខាង +infinity គឺ៖', 'multiple_choice', 'medium', 'y = -x', 'កាលណា x -> +infinity នោះ ln(...) -> 0 ដូច្នេះ f(x) -> -x ធ្វើឱ្យ y = -x ជាអាស៊ីមតូតទ្រេត.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 480;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (480, 'y = -x', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (480, 'y = -x + 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (480, 'y = x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (480, 'y = -x - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (481, 16, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 - 2) / x - ln x គ្រប់ x > 0 ។ នោះ f''(x) យកសញ្ញាតាមកន្សោម៖', 'multiple_choice', 'medium', 'x^2 - x - 2', 'ដេរីវេ f''(x) = 1 + 2/x^2 - 1/x = (x^2 - x + 2)/x^2 ឬតាមរូបមន្តស្វិតផ្ទឹម x^2 - x - 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 481;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (481, 'x^2 - x + 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (481, 'x^2 + x + 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (481, 'x^2 + x - 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (481, 'x^2 - x - 2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (482, 13, 'elementary', 'Mathematics', 'អនុគមន៍ f(x) = (x^2 - 2) / x - ln x មានក្រាប (C) ។ នៅលើក្រាប (C) មានចំណុច A មួយដែលបន្ទាត់ប៉ះ (T) ស្របនឹង y = x ។ កូអរដោនេ A គឺ៖', 'multiple_choice', 'hard', 'សាត្ថានភាពសមមូល (e, (e^2 - e - 2)/e)', 'មេគុណប្រាប់ទិស f''(A) = 1 ដំណោះស្រាយផ្តល់កូអរដោនេ (e, (e^2 - e - 2)/e).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - អនុគមន៍លោការីត')
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

DELETE FROM answer_option WHERE question_id = 482;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (482, '(1, -1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (482, '(e, (e^2 - e - 2) / e)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (482, '(1/2, -7/2 + ln 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (482, '(2, 1 - ln 2)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (483, 15, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = 2x / (x^2 + 2)^2 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'easy', 'F(x) = -1 / (x^2 + 2) + C', 'ដេរីវេនៃ -1 / (x^2 + 2) គឺ 2x / (x^2 + 2)^2 ដូច្នេះព្រីមីទីវគឺ -1 / (x^2 + 2) + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 483;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (483, 'F(x) = 1 / (x^2 + 2) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (483, 'F(x) = -x / (x^2 + 2) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (483, 'F(x) = -1 / (x^2 + 2) + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (483, 'F(x) = 2 / (x^2 + 2) + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (484, 20, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = ln x ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'easy', 'F(x) = x ln x - x + C', 'ប្រើប្រាស់វិធីអាំងតេក្រាលដោយក្បួនខណ្ឌ (Integration by parts) ទទួលបាន F(x) = x ln x - x + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 484;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (484, 'F(x) = x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (484, 'F(x) = x ln x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (484, 'F(x) = x ln x + x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (484, 'F(x) = x ln x - x + C', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (485, 12, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = (1 - x^2) / (1 + x^2)^2 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'medium', 'F(x) = x / (1 + x^2) + c', 'ដេរីវេនៃ x / (1 + x^2) ផ្តល់កន្សោម f(x).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 485;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (485, 'F(x) = -1 / (1 + x^2) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (485, 'F(x) = x / (1 + x^2) + c', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (485, 'F(x) = -(1 - x) / (1 + x^2) + c', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (485, 'F(x) = 1 / (1 + x^2) + c', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (486, 17, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = 7 / (3x + 1) ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'easy', 'F(x) = 7/3 ln(3x + 1) + C', 'ព្រីមីទីវនៃ 1/(ax+b) គឺ 1/a ln|ax+b| ដូច្នេះ F(x) = 7/3 ln(3x + 1) + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 486;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (486, 'F(x) = 7/3 ln|-3x - 1| + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (486, 'F(x) = 7/3 ln(3x + 1) + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (486, 'F(x) = -7/3 ln(3x + 1) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (486, 'F(x) = 7 ln(3x + 1) + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (487, 18, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = (3x^2 + 4x - 2) / x^4 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'medium', 'F(x) = 2/x^2 - 3/x + C', 'បំបែកប្រភាគជា 3/x^2 + 4/x^3 - 2/x^4 រួចរកព្រីមីទីវទទួលបាន 2/x^2 - 3/x + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 487;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (487, 'F(x) = 6/x + 4/(4x^3) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (487, 'F(x) = 2/(3x^3) - 2/x^2 - 3/x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (487, 'F(x) = 2/x^2 - 3/x + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (487, 'F(x) = 2/x^3 - 1/x^2 + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (488, 11, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ pi/4 đến pi/2 ຂອງ cos^2 x dx ។ តើចម្លើយណាដែលត្រឹមត្រូវ?', 'multiple_choice', 'medium', 'I = pi/8 + 1/4', 'ប្រើប្រាស់រូបមន្ត linearization cos^2 x = (1 + cos 2x) / 2 រួចគណនាតម្លៃអាំងតេក្រាលកំណត់ទទួលបាន pi/8 + 1/4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 488;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (488, 'I = (pi + 2) / 4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (488, 'I = pi/8 + 1/4', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (488, 'I = pi/8 - 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (488, 'I = pi/8 - 1/2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (489, 19, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល A = ∫ từ 0 đến 1 ຂອງ (t^3 + 2t^2 + 4t + 1) dt ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'easy', 'A = 47/12', 'រកព្រីមីទីវ [t^4/4 + 2t^3/3 + 2t^2 + t] ពី 0 ដល់ 1 ទទួលបាន 47/12.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 489;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (489, 'A = 47/12', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (489, 'A = 5', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (489, 'A = 8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (489, 'A = 27/12', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (490, 14, 'elementary', 'Mathematics', 'គេមានអនុគមន៍ f(x) = (sin x - x cos x) / x^2 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'medium', 'F(x) = sin x / x + C', 'ដេរីវេនៃ sin x / x គឺ ((cos x)*x - sin x * 1) / x^2 ដែលស្មើនឹង -f(x) ដូច្នេះ F(x) = sin x / x + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 490;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (490, 'F(x) = sin x / x + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (490, 'F(x) = cos x / x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (490, 'F(x) = -sin x / x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (490, 'F(x) = sin x / x^3 + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (491, 16, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = (2x + 3) / (x - 1)^3 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'hard', 'F(x) = -2 / (x - 1) - 5 / (2(x - 1)^2) + C', 'បំបែកប្រភាគសនិទានជា A/(x-1) + B/(x-1)^2 រួចរកព្រីមីទីវ ទទួលបាន -2 / (x-1) - 5 / (2(x-1)^2) + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 491;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (491, 'F(x) = 5 / (2(x - 1)^2) - 2 / (x - 1) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (491, 'F(x) = 2 / (x - 1) - 5 / (x - 1)^2 + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (491, 'F(x) = -2 / (x - 1) - 5 / (2(x - 1)^2) + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (491, 'F(x) = -2 / (x - 1) + 5 / (2(x - 1)^2) + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (492, 13, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ -1 đến 1 ຂອງ |e^x - 1| dx ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'hard', 'I = e + 1/e - 2', 'បែងចែកតំបន់អាំងតេក្រាលតាមសញ្ញានៃ e^x - 1 ទទួលបាន e + 1/e - 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 492;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (492, 'I = 2(e - 1)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (492, 'I = -(1/e - 1) - |e - 1|', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (492, 'I = (e + 1/e)^2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (492, 'I = e + 1/e - 2', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (493, 20, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = 6x^2 - 1 / x^2 ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'easy', 'F(x) = 2x^3 + 1/x + C', 'ព្រីមីទីវនៃ 6x^2 គឺ 2x^3 និងព្រីមីទីវនៃ -1/x^2 គឺ 1/x ដូច្នេះ F(x) = 2x^3 + 1/x + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 493;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (493, 'F(x) = 1/x + 2x^3 + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (493, 'F(x) = -1/x - x^3 + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (493, 'F(x) = 2x^3 - 1/x + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (493, 'F(x) = 1/(2x) + 2x^3 + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (494, 15, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = 3x * e^{x^2} ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'medium', 'F(x) = 3/2 * e^{x^2} + C', 'សរសេរ f(x) = 3/2 * (2x) * e^{x^2} ដូច្នេះ F(x) = 3/2 * e^{x^2} + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 494;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (494, 'F(x) = 6e^{x^2} + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (494, 'F(x) = 3/2 * e^{x^2} + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (494, 'F(x) = 6x^2*e^{x^2} + 3e^{x^2} + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (494, 'F(x) = 2/3 * x*e^x + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (495, 12, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ 0 đến pi/4 ຂອງ sin(t + pi/4) dt ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'medium', 'I = sqrt(2)', 'ព្រីមីទីវនៃ sin(t + pi/4) គឺ -cos(t + pi/4) ជំនួសដែនកំណត់ពី 0 ដល់ pi/4 ទទួលបាន sqrt(2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 495;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (495, 'I = sqrt(2) / 2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (495, 'I = 2*sqrt(2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (495, 'I = sqrt(2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (495, 'I = sqrt(2) + 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (496, 17, 'elementary', 'Mathematics', 'f ជាអនុគមន៍កំណត់ដោយ f(x) = (4x^2 + 1) / sqrt(2x^2 + 1) ។ តើចម្លើយណាជាព្រីមីទីវ F នៃអនុគមន៍ f(x)?', 'multiple_choice', 'hard', 'F(x) = x*sqrt(2x^2 + 1) + C', 'ធ្វើការបំបែកនិងប្រើវិធីសាស្ត្រព្រីមីទីវ ទទួលបាន F(x) = x*sqrt(2x^2 + 1) + C.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 496;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (496, 'F(x) = x*sqrt(2x^2 + 1) + C', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (496, 'F(x) = x + sqrt(2x^2 + 1) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (496, 'F(x) = sqrt(2x^2 + 1) + C', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (496, 'F(x) = 1 / sqrt(2x^2 + 1) + C', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (497, 18, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ 0 đến pi ຂອງ cos 3x dx ។ ចម្លើយណាជាចម្លើយត្រូវ?', 'multiple_choice', 'easy', 'I = 0', 'ព្រីមីទីវគឺ 1/3 * sin 3x ជំនួសដែនកំណត់ពី 0 ដល់ pi ទទួលបាន 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 497;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (497, 'I = 0', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (497, 'I = pi', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (497, 'I = -1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (497, 'I = pi - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (498, 14, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល E = ∫ từ 0 đến 1 ຂອງ 1 / (x + 2) dx ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'easy', 'E = ln(3/2)', 'ព្រីមីទីវគឺ ln|x + 2| ជំនួសដែនកំណត់ពី 0 ដល់ 1 ទទួលបាន ln(3/2).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 498;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (498, 'E = ln(2/3)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (498, 'E = ln 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (498, 'E = ln(3/2)', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (498, 'E = ln 2', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (499, 11, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ -3 đến 3 ຂອງ (12t^{17} + 2t^3 - t) dt ។ តើចម្លើយណាជាចម្លើយត្រូវ?', 'multiple_choice', 'easy', 'I = 0', 'មុខងារខាងក្នុងសុទ្ធតែជាអនុគមន៍គំលាត (Odd functions) លើចន្លោះស៊ីមេទ្រី [-3, 3] ដូច្នេះអាំងតេក្រាលស្មើនឹង 0.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 499;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (499, 'I = 6', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (499, 'I = 3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (499, 'I = 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (499, 'I = 0', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (500, 16, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល I = ∫ từ 0 đến pi/4 ຂອງ (cos^2 x - 1) dx ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'medium', 'I = 1/4 - pi/8', 'cos^2 x - 1 = -sin^2 x ធ្វើការគណនាតម្លៃអាំងតេក្រាលកំណត់ ទទួលបាន 1/4 - pi/8.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 500;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (500, 'I = 1/4 - pi/8', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (500, 'I = pi/8 - 1/4', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (500, 'I = 2 + pi/8', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (500, 'I = 1/2 - pi/4', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (501, 19, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល B = ∫ từ 0 đến 1 ຂອງ dx / sqrt(x^2 + 2) ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'hard', 'B = ln(1 + sqrt(3)) - ln(sqrt(2))', 'ប្រើប្រាស់រូបមន្តព្រីមីទីវលោការីតនៃរ៉ាឌីកាល់ ទទួលបាន B = ln(1 + sqrt(3)) - ln(sqrt(2)).', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 501;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (501, 'B = ln(sqrt(3)) + ln(sqrt(2))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (501, 'B = ln(1 + sqrt(3)) + ln(sqrt(2))', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (501, 'B = ln(1 + sqrt(3)) - ln(sqrt(2))', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (501, 'B = ln(sqrt(3)) - ln(sqrt(2))', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (502, 20, 'elementary', 'Mathematics', 'គេមានអាំងតេក្រាល F = ∫ từ -4 đến 1 ຂອງ 1 / (2x - 4)^2 dx ។ តើចម្លើយណាដែលត្រូវ?', 'multiple_choice', 'medium', 'F = 5/24', 'ព្រីមីទីវគឺ -1 / (2(2x - 4)) ជំនួសដែនកំណត់ពី -4 ដល់ 1 ទទួលបាន 5/24.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - ព្រីមីទីវ និងអាំងតេក្រាល')
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

DELETE FROM answer_option WHERE question_id = 502;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (502, 'F = 5/16', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (502, 'F = 3/16', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (502, 'F = 5/24', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (502, 'F = 3/24', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (503, 13, 'elementary', 'Mathematics', 'តាង (a_n)_{n>=1} ជាស្វ៊ីតនព្វន្តដែល a_3 = 8 និង a_11 = -24 ។ គណនា S_20 = sum_{k=1}^{20} a_k', 'multiple_choice', 'medium', '-440', 'រក a_1 = 16 និង d = -4 តាមរូបមន្តស្វ៊ីតនព្វន្ត រួចគណនាផលបូក S_20 ទទួលបាន -440.', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 503;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (503, '-440', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (503, 'ចម្លើយផ្សេង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (503, '14', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (503, '-40', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (503, '440', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (504, 11, 'elementary', 'Mathematics', 'ដោះស្រាយសមីការ x^3 = 8 ក្នុងសំណុំចំនួនកុំផ្លិច', 'multiple_choice', 'medium', '{2, -1 - i*sqrt(3), -1 + i*sqrt(3)}', 'បំបែក (x-2)(x^2 + 2x + 4) = 0 ទទួលបានឫស x = 2 និង x = -1 ± i*sqrt(3).', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 504;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (504, '{2, -2 - i*sqrt(3), -2 + i*sqrt(3)}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (504, 'ចម្លើយផ្សេង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (504, '{2, -1 - i*sqrt(3), -1 + i*sqrt(3)}', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (504, '{2, 1 - i*sqrt(3), 1 + i*sqrt(3)}', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (504, '{2, 1 - i, 1 + i}', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (505, 17, 'elementary', 'Mathematics', 'គណនា S = (1 + 3 + 5 + 7 + ... + 99) / (2 + 4 + 6 + 8 + ... + 100)', 'multiple_choice', 'medium', '50/51', 'ផលបូកភាគយកស្មើនឹង 2500 និងភាគបែងស្មើនឹង 2550 ដូច្នេះ S = 2500 / 2550 = 50/51.', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 505;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (505, '48/49', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (505, '50/51', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (505, '49/50', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (505, '98/99', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (505, 'ចម្លើយផ្សេង', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (506, 18, 'elementary', 'Mathematics', 'កំណត់សំណល់ពេល f(x) = (x-1)^{100} + (x-2)^{200} ចែកនឹង g(x) = x^2 - 3x + 2', 'multiple_choice', 'medium', '1', 'ដោយ g(x) = (x-1)(x-2) គេបាន R(1) = 1 និង R(2) = 1 ដូច្នេះសំណល់គឺ R(x) = 1.', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 506;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (506, '1', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (506, 'ចម្លើយផ្សេង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (506, '-1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (506, 'x + 1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (506, 'x - 1', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (507, 15, 'elementary', 'Mathematics', 'គេឱ្យអនុគមន៍ f(x) = x^2 និង g(x) = ax - 1 ។ កំណត់តម្លៃ a ដើម្បីឱ្យក្រាបតាងអនុគមន៍ទាំងពីរកាត់គ្នាត្រង់ពីរចំណុចផ្សេងគ្នា។', 'multiple_choice', 'medium', 'ចម្លើយផ្សេង', 'លក្ខខណ្ឌកាត់គ្នាពីរចំណុចគឺ delta > 0 ដែលផ្តល់ a^2 - 4 > 0 ឬ a thuộc (-infty, -2) U (2, +infty).', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 507;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (507, 'a thuộc (-infty, -4) U (4, +infty)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (507, 'ចម្លើយផ្សេង', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (507, 'a thuộc (-2, -4) U (2, +infty)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (507, 'a thuộc (-2, 2)', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (507, 'a thuộc (2, +infinity)', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (508, 16, 'elementary', 'Mathematics', 'កំណត់សំណល់ពេល f(x) = 3x^{201} - x^{10} + x^7 - 3x + 1 ចែកនឹង g(x) = x + 1', 'multiple_choice', 'easy', '-1', 'តាមទ្រឹស្តីបទសំណល់ គេបាន f(-1) = 3(-1)^{201} - (-1)^{10} + (-1)^7 - 3(-1) + 1 = -1.', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 508;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (508, '1 + x', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (508, 'ចម្លើយផ្សេង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (508, '0', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (508, '1', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (508, '-1', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (509, 19, 'elementary', 'Mathematics', 'រកតម្លៃ a_10 ដោយដឹងថា a_1 = 1 និង a_n = a_{n-1} + 3', 'multiple_choice', 'easy', '28', 'ជាស្វ៊ីតនព្វន្តដែលមាន a_1 = 1 និង d = 3 ដូច្នេះ a_10 = a_1 + 9d = 1 + 9(3) = 28.', 'វិញ្ញាសាគណិតវិទ្យា សម្រាប់ត្រៀមប្រឡងចូលក្របខណ្ឌគ្រូ (២០២១)')
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

DELETE FROM answer_option WHERE question_id = 509;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (509, '29', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (509, 'ចម្លើយផ្សេង', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (509, '28', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (509, '27', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (509, '31', FALSE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (510, 20, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->2} (x^2 - 4) / (x - 2) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'easy', '4', 'បំបែកភាគយកជា (x - 2)(x + 2) រួចសម្រួលជាមួយភាគបែង ជំនួស x = 2 ទទួលបាន 2 + 2 = 4.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 510;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (510, '125', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (510, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (510, '2', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (510, '4', TRUE);

INSERT INTO question (question_id, topic_id, exam_name, subject_name, question_text, question_type, difficulty_level, correct_answer, explanation, reference_note)
VALUES (511, 12, 'elementary', 'Mathematics', 'តម្លៃលីមីត lim_{x->1} (1 - x^2) / (x^2 + 2 - 3x) ស្មើនឹងប៉ុន្មាន?', 'multiple_choice', 'medium', '2', 'បំបែកភាគយកជា -(x - 1)(x + 1) និងភាគបែងជា (x - 1)(x - 2) សម្រួលរួចជំនួស x = 1 ទទួលបាន -(1+1)/(1-2) = 2.', 'លំហាត់គណិតវិទ្យា QCM ត្រៀមប្រឡងពេទ្យ (២០២១) - លីមីត (បន្ថែម)')
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

DELETE FROM answer_option WHERE question_id = 511;
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (511, '125', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (511, '3', FALSE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (511, '2', TRUE);
INSERT INTO answer_option (question_id, option_text, is_correct)
VALUES (511, '4', FALSE);

SELECT setval(pg_get_serial_sequence('question', 'question_id'), (SELECT COALESCE(MAX(question_id), 1) FROM question));

COMMIT;
