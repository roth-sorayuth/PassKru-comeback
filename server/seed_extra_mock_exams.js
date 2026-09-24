import { prisma } from './src/config/prisma.js';

const EXTRA_QUESTIONS = [
  {
    topicName: "ចិត្តវិទ្យាសិក្សា",
    questions: [
      ["តើទ្រឹស្តីអភិវឌ្ឍន៍សតិបញ្ញារបស់លោក Jean Piaget មានប៉ុន្មានដំណាក់កាល?", ["២ ដំណាក់កាល", "៣ ដំណាក់កាល", "៤ ដំណាក់កាល", "៥ ដំណាក់កាល"], 2, "លោក Piaget បែងចែកការអភិវឌ្ឍជា ៤ ដំណាក់កាល៖ ញាណចលករ, មុនប្រតិបត្តិការ, ប្រតិបត្តិការជាក់ស្តែង និងប្រតិបត្តិការអរូបី។"],
      ["តើការរៀនសូត្រតាមទ្រឹស្តី Vygotsky សង្កត់ធ្ងន់ទៅលើអ្វីជាងគេ?", ["ហ្សែន និងតំណពូជ", "អន្តរកម្មសង្គម និងវប្បធម៌", "ការដាក់ទណ្ឌកម្ម", "ការរៀនដោយខ្លួនឯងគ្មានអ្នកជួយ"], 1, "Vygotsky ជឿថាការរៀនសូត្រកើតឡើងតាមរយៈអន្តរកម្មសង្គម ពិសេសតាមរយៈ ZPD (Zone of Proximal Development)។"],
      ["តើអ្វីទៅជាការលើកទឹកចិត្តខាងក្នុង (Intrinsic Motivation)?", ["ការរៀនដើម្បីបានរង្វាន់", "ការរៀនដើម្បីជៀសវាងការស្តីបន្ទោស", "ការរៀនដោយសារការចាប់អារម្មណ៍និងក្តីស្រឡាញ់ផ្ទាល់ខ្លួន", "ការរៀនដើម្បីបានពិន្ទុល្អ"], 2, "ការលើកទឹកចិត្តខាងក្នុង កើតចេញពីចំណូលចិត្ត និងសេចក្តីពេញចិត្តផ្ទាល់ខ្លួនរបស់សិស្ស។"],
    ]
  },
  {
    topicName: "វិធីសាស្ត្របង្រៀន",
    questions: [
      ["តើការបង្រៀនផ្តោតលើសិស្ស (Student-centered learning) មានលក្ខណៈដូចម្តេច?", ["គ្រូជាអ្នកនិយាយ សិស្សជាអ្នកស្តាប់", "សិស្សជាអ្នកចូលរួមសកម្មក្នុងការស្វែងរកចំណេះដឹង", "សិស្សត្រូវទន្ទេញមេរៀនឲ្យចាំ", "គ្រូជាអ្នកសម្រេចរាល់សកម្មភាពទាំងអស់"], 1, "ក្នុងការបង្រៀនផ្តោតលើសិស្ស សិស្សជាមជ្ឈមណ្ឌលនៃការរៀនសូត្រ ហើយគ្រូដើរតួជាអ្នកសម្របសម្រួល។"],
      ["តើការវាយតម្លៃអភិវឌ្ឍន៍ (Formative Assessment) ធ្វើឡើងនៅពេលណា?", ["នៅចុងឆ្នាំសិក្សា", "មុនពេលចូលរៀន", "ក្នុងអំឡុងពេលដំណើរការបង្រៀននិងរៀន", "ក្រោយពេលប្រឡងឆមាស"], 2, "ការវាយតម្លៃអភិវឌ្ឍន៍ ធ្វើឡើងជាបន្តបន្ទាប់ក្នុងពេលរៀន ដើម្បីជួយកែលម្អការរៀនរបស់សិស្ស។"],
    ]
  },
  {
    topicName: "ធរណីមាត្រមូលដ្ឋាន",
    questions: [
      ["តើផលបូកមុំក្នុងនៃត្រីកោណស្មើនឹងប៉ុន្មានដឺក្រេ?", ["៩០ ដឺក្រេ", "១៨០ ដឺក្រេ", "២៧០ ដឺក្រេ", "៣៦០ ដឺក្រេ"], 1, "តាមទ្រឹស្តីបទធរណីមាត្រ ផលបូកមុំក្នុងនៃត្រីកោណទូទៅគឺ ១៨០ ដឺក្រេជានិច្ច។"],
      ["តើផ្ទៃក្រឡារង្វង់ដែលមានកាំ r គណនាតាមរូបមន្តអ្វី?", ["2πr", "πr", "πr²", "2πr²"], 2, "ផ្ទៃក្រឡារង្វង់ = π × r² ចំណែកឯបរិមាត្រ = 2πr។"],
    ]
  }
];

async function seedExtraQuestionsAndMockExam() {
  console.log("Seeding extra realistic questions for Mock Exams...");

  let questionsAdded = 0;

  for (const { topicName, questions } of EXTRA_QUESTIONS) {
    const topic = await prisma.topic.findFirst({ where: { topicName } });
    if (!topic) continue;

    for (const [questionText, options, correctIndex, explanation] of questions) {
      const existing = await prisma.question.findFirst({ where: { topicId: topic.topicId, questionText } });
      if (!existing) {
        await prisma.question.create({
          data: {
            topicId: topic.topicId,
            questionText,
            questionType: "multiple-choice",
            difficultyLevel: "medium",
            correctAnswer: options[correctIndex],
            explanation,
            answerOptions: {
              create: options.map((optionText, idx) => ({ optionText, isCorrect: idx === correctIndex })),
            },
          }
        });
        questionsAdded++;
      }
    }
  }

  console.log(`✅ Added ${questionsAdded} new rich questions to the Question Bank.`);

  // Create a Special Advanced Mock Exam for Lower Secondary
  const rttcExam = await prisma.exam.findFirst({ where: { targetCode: 'rttc' } });
  if (rttcExam) {
    const title = `វិញ្ញាសាប្រឡងសាកល្បងគ្រូមូលដ្ឋាន (ពិសេស)`;
    let mockExam = await prisma.mockExam.findFirst({ where: { examId: rttcExam.examId, title } });
    
    if (!mockExam) {
      mockExam = await prisma.mockExam.create({
        data: {
          examId: rttcExam.examId,
          title,
          description: "វិញ្ញាសាពិសេសរួមមាន គរុកោសល្យ ចិត្តវិទ្យា និងគណិតវិទ្យា ស្របតាមស្តង់ដារប្រឡងក្រសួងអប់រំ។",
          year: 2026,
          durationMinutes: 120,
          totalMarks: 100,
          passingMarks: 50,
        },
      });
      console.log(`✅ Created new realistic Mock Exam: ${title}`);
    }
  }

  console.log("Done! You now have more realistic data in your Quizzes and Mock Exams.");
}

seedExtraQuestionsAndMockExam()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
