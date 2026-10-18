export const englishQuestions = [
  // ==========================================
  // SECTION 1: 12 TENSES (Questions 1 - 52)
  // ==========================================

  // --- Simple Present (1-5) ---
  {
    questionID: 1,
    questionText: "Water ________ at 100 degrees Celsius under standard atmospheric pressure.",
    difficultyLevel: "easy",
    correctAnswer: "boils",
    explanation: "We use the Simple Present tense for scientific facts and general truths. With the singular uncountable subject 'Water', the verb takes -s ('boils').",
    referenceNote: "English Grammar - Simple Present: General Truths",
    options: [
      { text: "boils", isCorrect: true },
      { text: "is boiling", isCorrect: false },
      { text: "boiled", isCorrect: false },
      { text: "has boiled", isCorrect: false }
    ]
  },
  {
    questionID: 2,
    questionText: "My brother ________ tennis every Sunday morning with his friends.",
    difficultyLevel: "easy",
    correctAnswer: "plays",
    explanation: "Habitual actions indicated by 'every Sunday morning' require the Simple Present tense. For third-person singular ('My brother'), we add -s: 'plays'.",
    referenceNote: "English Grammar - Simple Present: Habits & Routines",
    options: [
      { text: "play", isCorrect: false },
      { text: "plays", isCorrect: true },
      { text: "is playing", isCorrect: false },
      { text: "has played", isCorrect: false }
    ]
  },
  {
    questionID: 3,
    questionText: "The train to Battambang ________ at exactly 8:30 AM tomorrow.",
    difficultyLevel: "medium",
    correctAnswer: "departs",
    explanation: "The Simple Present is used to express future events that are part of a fixed timetable or schedule.",
    referenceNote: "English Grammar - Simple Present: Scheduled Future Events",
    options: [
      { text: "departs", isCorrect: true },
      { text: "is departing", isCorrect: false },
      { text: "will have departed", isCorrect: false },
      { text: "departed", isCorrect: false }
    ]
  },
  {
    questionID: 4,
    questionText: "She ________ believe in superstitions, no matter what others say.",
    difficultyLevel: "easy",
    correctAnswer: "does not",
    explanation: "Negative sentences in the Simple Present with a third-person singular subject ('She') use 'does not' followed by the base form of the verb ('believe').",
    referenceNote: "English Grammar - Simple Present: Negative Form",
    options: [
      { text: "does not", isCorrect: true },
      { text: "do not", isCorrect: false },
      { text: "is not", isCorrect: false },
      { text: "has not", isCorrect: false }
    ]
  },
  {
    questionID: 5,
    questionText: "This soup ________ delicious; what herbs did you add?",
    difficultyLevel: "medium",
    correctAnswer: "tastes",
    explanation: "'Taste' is a stative verb referring to a sensory perception, which is not normally used in the continuous form in this context.",
    referenceNote: "English Grammar - Simple Present: Stative Verbs",
    options: [
      { text: "is tasting", isCorrect: false },
      { text: "tastes", isCorrect: true },
      { text: "taste", isCorrect: false },
      { text: "has been tasting", isCorrect: false }
    ]
  },

  // --- Present Continuous (6-10) ---
  {
    questionID: 6,
    questionText: "Please be quiet! The baby ________ in the next room.",
    difficultyLevel: "easy",
    correctAnswer: "is sleeping",
    explanation: "The Present Continuous tense ('is sleeping') is used for actions currently happening at the moment of speaking, prompted by 'Please be quiet!'.",
    referenceNote: "English Grammar - Present Continuous: Actions Happening Now",
    options: [
      { text: "sleeps", isCorrect: false },
      { text: "is sleeping", isCorrect: true },
      { text: "slept", isCorrect: false },
      { text: "has slept", isCorrect: false }
    ]
  },
  {
    questionID: 7,
    questionText: "We ________ to Siem Reap this weekend; our hotel is already booked.",
    difficultyLevel: "medium",
    correctAnswer: "are traveling",
    explanation: "The Present Continuous is used for definite personal arrangements planned for the near future.",
    referenceNote: "English Grammar - Present Continuous: Future Arrangements",
    options: [
      { text: "are traveling", isCorrect: true },
      { text: "travel", isCorrect: false },
      { text: "traveled", isCorrect: false },
      { text: "have traveled", isCorrect: false }
    ]
  },
  {
    questionID: 8,
    questionText: "Why ________ you always ________ my car keys without asking?",
    difficultyLevel: "hard",
    correctAnswer: "are / taking",
    explanation: "Present Continuous with 'always' conveys irritation or annoyance regarding a frequent habit: 'Why are you always taking...'.",
    referenceNote: "English Grammar - Present Continuous: Annoying Habits with 'Always'",
    options: [
      { text: "do / take", isCorrect: false },
      { text: "are / taking", isCorrect: true },
      { text: "did / take", isCorrect: false },
      { text: "have / taken", isCorrect: false }
    ]
  },
  {
    questionID: 9,
    questionText: "Global temperatures ________ steadily over the past few decades.",
    difficultyLevel: "medium",
    correctAnswer: "are rising",
    explanation: "Present Continuous describes gradual changes or developing situations ('are rising').",
    referenceNote: "English Grammar - Present Continuous: Changing Situations",
    options: [
      { text: "are rising", isCorrect: true },
      { text: "rises", isCorrect: false },
      { text: "rose", isCorrect: false },
      { text: "rise", isCorrect: false }
    ]
  },
  {
    questionID: 10,
    questionText: "John is temporarily living with his uncle while his apartment ________.",
    difficultyLevel: "medium",
    correctAnswer: "is being renovated",
    explanation: "This requires the present continuous passive ('is being renovated') to describe an ongoing temporary process occurring at present.",
    referenceNote: "English Grammar - Present Continuous: Passive Voice",
    options: [
      { text: "is renovating", isCorrect: false },
      { text: "is being renovated", isCorrect: true },
      { "text": "renovates", isCorrect: false },
      { text: "has renovated", isCorrect: false }
    ]
  },

  // --- Present Perfect (11-15) ---
  {
    questionID: 11,
    questionText: "I ________ this museum three times, and I still find it fascinating.",
    difficultyLevel: "easy",
    correctAnswer: "have visited",
    explanation: "Present Perfect ('have visited') describes life experiences occurring at an unspecified time in the past up to now.",
    referenceNote: "English Grammar - Present Perfect: Life Experiences",
    options: [
      { text: "visit", isCorrect: false },
      { text: "visited", isCorrect: false },
      { text: "have visited", isCorrect: true },
      { text: "had visited", isCorrect: false }
    ]
  },
  {
    questionID: 12,
    questionText: "Sophea has lived in Phnom Penh ________ 2015.",
    difficultyLevel: "easy",
    correctAnswer: "since",
    explanation: "We use 'since' with a specific starting point in time (2015) in Present Perfect sentences.",
    referenceNote: "English Grammar - Present Perfect: 'Since' vs 'For'",
    options: [
      { text: "for", isCorrect: false },
      { text: "since", isCorrect: true },
      { text: "during", isCorrect: false },
      { text: "in", isCorrect: false }
    ]
  },
  {
    questionID: 13,
    questionText: "Have you submitted your assignment ________?",
    difficultyLevel: "easy",
    correctAnswer: "yet",
    explanation: "'Yet' is used in questions and negative statements in the Present Perfect to talk about things expected to happen.",
    referenceNote: "English Grammar - Present Perfect: Use of 'Yet'",
    options: [
      { text: "already", isCorrect: false },
      { text: "yet", isCorrect: true },
      { text: "still", isCorrect: false },
      { text: "just", isCorrect: false }
    ]
  },
  {
    questionID: 14,
    questionText: "Look at the mess! Someone ________ the window.",
    difficultyLevel: "medium",
    correctAnswer: "has broken",
    explanation: "Present Perfect ('has broken') is used when a past action has an obvious result in the present.",
    referenceNote: "English Grammar - Present Perfect: Present Result",
    options: [
      { text: "breaks", isCorrect: false },
      { text: "has broken", isCorrect: true },
      { text: "was breaking", isCorrect: false },
      { text: "had broken", isCorrect: false }
    ]
  },
  {
    questionID: 15,
    questionText: "This is the most impressive historical temple I ________.",
    difficultyLevel: "medium",
    correctAnswer: "have ever seen",
    explanation: "Sentences with superlative constructions ('the most impressive...') are typically followed by the Present Perfect with 'ever'.",
    referenceNote: "English Grammar - Present Perfect: Superlatives with 'Ever'",
    options: [
      { text: "saw", isCorrect: false },
      { text: "have ever seen", isCorrect: true },
      { text: "had ever seen", isCorrect: false },
      { text: "was seeing", isCorrect: false }
    ]
  },

  // --- Present Perfect Continuous (16-19) ---
  {
    questionID: 16,
    questionText: "They are tired because they ________ soccer for two hours.",
    difficultyLevel: "easy",
    correctAnswer: "have been playing",
    explanation: "Present Perfect Continuous ('have been playing') emphasizes the continuous duration of an action that just stopped or is still going on.",
    referenceNote: "English Grammar - Present Perfect Continuous: Duration",
    options: [
      { text: "have been playing", isCorrect: true },
      { text: "are playing", isCorrect: false },
      { text: "played", isCorrect: false },
      { text: "had played", isCorrect: false }
    ]
  },
  {
    questionID: 17,
    questionText: "It ________ since early morning, and the streets are flooded.",
    difficultyLevel: "easy",
    correctAnswer: "has been raining",
    explanation: "The action began in the past and continues into the present with an emphasis on uninterrupted duration: 'has been raining'.",
    referenceNote: "English Grammar - Present Perfect Continuous: Unfinished Actions",
    options: [
      { text: "is raining", isCorrect: false },
      { text: "has rained", isCorrect: false },
      { text: "has been raining", isCorrect: true },
      { text: "rained", isCorrect: false }
    ]
  },
  {
    questionID: 18,
    questionText: "How long ________ English at this institute?",
    difficultyLevel: "medium",
    correctAnswer: "have you been studying",
    explanation: "'How long' inquiries about continuous duration up to the present moment use the Present Perfect Continuous.",
    referenceNote: "English Grammar - Present Perfect Continuous: Questions with 'How Long'",
    options: [
      { text: "do you study", isCorrect: false },
      { text: "are you studying", isCorrect: false },
      { text: "have you been studying", isCorrect: true },
      { text: "had you studied", isCorrect: false }
    ]
  },
  {
    questionID: 19,
    questionText: "She smells of paint because she ________ the living room walls.",
    difficultyLevel: "medium",
    correctAnswer: "has been painting",
    explanation: "Present Perfect Continuous is chosen to explain a present physical evidence resulting from a recent continuous activity.",
    referenceNote: "English Grammar - Present Perfect Continuous: Recent Activity with Evidence",
    options: [
      { text: "has been painting", isCorrect: true },
      { text: "paints", isCorrect: false },
      { text: "painted", isCorrect: false },
      { text: "had been painting", isCorrect: false }
    ]
  },

  // --- Simple Past (20-24) ---
  {
    questionID: 20,
    questionText: "Cambodia ________ its independence from France on November 9, 1953.",
    difficultyLevel: "easy",
    correctAnswer: "gained",
    explanation: "A specific completed date in the past ('November 9, 1953') requires the Simple Past tense ('gained').",
    referenceNote: "English Grammar - Simple Past: Definite Past Time",
    options: [
      { text: "gains", isCorrect: false },
      { text: "gained", isCorrect: true },
      { text: "has gained", isCorrect: false },
      { text: "had gained", isCorrect: false }
    ]
  },
  {
    questionID: 21,
    questionText: "Where ________ you go for your summer vacation last year?",
    difficultyLevel: "easy",
    correctAnswer: "did",
    explanation: "Questions in the Simple Past use the auxiliary 'did' + subject + base verb ('did you go').",
    referenceNote: "English Grammar - Simple Past: Question Form",
    options: [
      { text: "do", isCorrect: false },
      { text: "did", isCorrect: true },
      { text: "have", isCorrect: false },
      { text: "were", isCorrect: false }
    ]
  },
  {
    questionID: 22,
    questionText: "He ________ a letter to his parents yesterday afternoon.",
    difficultyLevel: "easy",
    correctAnswer: "wrote",
    explanation: "'Wrote' is the irregular past form of the verb 'write', required by the time adverbial 'yesterday afternoon'.",
    referenceNote: "English Grammar - Simple Past: Irregular Verbs",
    options: [
      { text: "writed", isCorrect: false },
      { text: "wrote", isCorrect: true },
      { text: "written", isCorrect: false },
      { text: "has written", isCorrect: false }
    ]
  },
  {
    questionID: 23,
    questionText: "When I was a child, we ________ in a quiet village near the river.",
    difficultyLevel: "easy",
    correctAnswer: "lived",
    explanation: "Past states or finished habits in childhood are described using the Simple Past: 'lived'.",
    referenceNote: "English Grammar - Simple Past: Past States",
    options: [
      { text: "live", isCorrect: false },
      { text: "have lived", isCorrect: false },
      { text: "lived", isCorrect: true },
      { text: "are living", isCorrect: false }
    ]
  },
  {
    questionID: 24,
    questionText: "The company ________ its first overseas branch five years ago.",
    difficultyLevel: "medium",
    correctAnswer: "opened",
    explanation: "The expression 'five years ago' marks a completed past event, requiring the Simple Past tense ('opened').",
    referenceNote: "English Grammar - Simple Past: Time Markers with 'Ago'",
    options: [
      { text: "opened", isCorrect: true },
      { text: "has opened", isCorrect: false },
      { text: "opens", isCorrect: false },
      { text: "was opening", isCorrect: false }
    ]
  },

  // --- Past Continuous (25-28) ---
  {
    questionID: 25,
    questionText: "While I ________ down the street, I ran into my old high school teacher.",
    difficultyLevel: "easy",
    correctAnswer: "was walking",
    explanation: "An ongoing background action in the past introduced by 'while' requires the Past Continuous ('was walking').",
    referenceNote: "English Grammar - Past Continuous: Interrupted Actions",
    options: [
      { text: "walked", isCorrect: false },
      { text: "was walking", isCorrect: true },
      { text: "am walking", isCorrect: false },
      { text: "had walked", isCorrect: false }
    ]
  },
  {
    questionID: 26,
    questionText: "At 8:00 PM last night, we ________ dinner together as a family.",
    difficultyLevel: "easy",
    correctAnswer: "were having",
    explanation: "An action in progress at a precise point in the past ('At 8:00 PM last night') uses the Past Continuous ('were having').",
    referenceNote: "English Grammar - Past Continuous: Specific Past Time",
    options: [
      { text: "had", isCorrect: false },
      { text: "were having", isCorrect: true },
      { text: "have had", isCorrect: false },
      { text: "would have", isCorrect: false }
    ]
  },
  {
    questionID: 27,
    questionText: "While Dara was studying in his room, his sister ________ to music.",
    difficultyLevel: "medium",
    correctAnswer: "was listening",
    explanation: "When two actions were occurring simultaneously in the past, both clauses can take the Past Continuous ('was studying... was listening').",
    referenceNote: "English Grammar - Past Continuous: Simultaneous Actions",
    options: [
      { text: "listened", isCorrect: false },
      { text: "was listening", isCorrect: true },
      { text: "is listening", isCorrect: false },
      { text: "had listened", isCorrect: false }
    ]
  },
  {
    questionID: 28,
    questionText: "The lights suddenly went out while they ________ the important contract.",
    difficultyLevel: "medium",
    correctAnswer: "were discussing",
    explanation: "The short event ('lights went out' - simple past) interrupted the longer ongoing background activity ('were discussing' - past continuous).",
    referenceNote: "English Grammar - Past Continuous: Past Interruption",
    options: [
      { text: "discussed", isCorrect: false },
      { text: "were discussing", isCorrect: true },
      { text: "have discussed", isCorrect: false },
      { text: "had discussed", isCorrect: false }
    ]
  },

  // --- Past Perfect (29-32) ---
  {
    questionID: 29,
    questionText: "By the time the fire brigade arrived, the neighbors ________ the fire.",
    difficultyLevel: "medium",
    correctAnswer: "had already extinguished",
    explanation: "The Past Perfect ('had already extinguished') is used for an action completed before another past event ('the fire brigade arrived').",
    referenceNote: "English Grammar - Past Perfect: Earlier Past Action",
    options: [
      { text: "already extinguished", isCorrect: false },
      { text: "have already extinguished", isCorrect: false },
      { text: "had already extinguished", isCorrect: true },
      { text: "were already extinguishing", isCorrect: false }
    ]
  },
  {
    questionID: 30,
    questionText: "She could not enter her house because she ________ her keys at the office.",
    difficultyLevel: "easy",
    correctAnswer: "had left",
    explanation: "Leaving the keys occurred prior to being unable to enter the house, requiring the Past Perfect: 'had left'.",
    referenceNote: "English Grammar - Past Perfect: Cause in the Past",
    options: [
      { text: "left", isCorrect: false },
      { text: "has left", isCorrect: false },
      { text: "had left", isCorrect: true },
      { text: "was leaving", isCorrect: false }
    ]
  },
  {
    questionID: 31,
    questionText: "Hardly ________ entered the room when the telephone rang.",
    difficultyLevel: "hard",
    correctAnswer: "had he",
    explanation: "Negative inversion with 'Hardly' requires auxiliary inversion with the Past Perfect: 'Hardly had he entered... when...'.",
    referenceNote: "English Grammar - Past Perfect: Inversion with 'Hardly'",
    options: [
      { text: "he had", isCorrect: false },
      { text: "had he", isCorrect: true },
      { text: "did he", isCorrect: false },
      { text: "was he", isCorrect: false }
    ]
  },
  {
    questionID: 32,
    questionText: "He told me that he ________ never ________ abroad before that conference.",
    difficultyLevel: "medium",
    correctAnswer: "had / traveled",
    explanation: "Reported speech conveying an experience prior to a past reference point requires the Past Perfect: 'had never traveled'.",
    referenceNote: "English Grammar - Past Perfect: Reported Speech",
    options: [
      { text: "has / traveled", isCorrect: false },
      { text: "had / traveled", isCorrect: true },
      { text: "was / traveling", isCorrect: false },
      { text: "did / travel", isCorrect: false }
    ]
  },

  // --- Past Perfect Continuous (33-36) ---
  {
    questionID: 33,
    questionText: "He was out of breath when he arrived because he ________ for over an hour.",
    difficultyLevel: "medium",
    correctAnswer: "had been running",
    explanation: "Past Perfect Continuous ('had been running') emphasizes the ongoing duration of an action up to a past reference point.",
    referenceNote: "English Grammar - Past Perfect Continuous: Ongoing Cause in Past",
    options: [
      { text: "was running", isCorrect: false },
      { text: "has been running", isCorrect: false },
      { text: "had been running", isCorrect: true },
      { text: "ran", isCorrect: false }
    ]
  },
  {
    questionID: 34,
    questionText: "Before she finally quit her job, she ________ with the company for ten years.",
    difficultyLevel: "medium",
    correctAnswer: "had been working",
    explanation: "The ongoing duration leading up to the past action ('quit') requires the Past Perfect Continuous: 'had been working'.",
    referenceNote: "English Grammar - Past Perfect Continuous: Duration before Past Action",
    options: [
      { text: "has been working", isCorrect: false },
      { text: "was working", isCorrect: false },
      { text: "had been working", isCorrect: true },
      { text: "worked", isCorrect: false }
    ]
  },
  {
    questionID: 35,
    questionText: "The ground was soaking wet because it ________ all night.",
    difficultyLevel: "easy",
    correctAnswer: "had been raining",
    explanation: "The continuous action ('had been raining') took place over an extended period before the morning observation.",
    referenceNote: "English Grammar - Past Perfect Continuous: Continuous Past Event",
    options: [
      { text: "had been raining", isCorrect: true },
      { text: "has been raining", isCorrect: false },
      { text: "was raining", isCorrect: false },
      { text: "rained", isCorrect: false }
    ]
  },
  {
    questionID: 36,
    questionText: "How long ________ waiting before the bus finally arrived?",
    difficultyLevel: "medium",
    correctAnswer: "had you been",
    explanation: "'How long had you been waiting' asks about the duration of continuous waiting prior to the bus arriving.",
    referenceNote: "English Grammar - Past Perfect Continuous: Question Form",
    options: [
      { text: "were you", isCorrect: false },
      { text: "have you been", isCorrect: false },
      { text: "had you been", isCorrect: true },
      { text: "did you", isCorrect: false }
    ]
  },

  // --- Simple Future (37-40) ---
  {
    questionID: 37,
    questionText: "\"The phone is ringing.\" — \"Don't worry, I ________ it.\"",
    difficultyLevel: "easy",
    correctAnswer: "will answer",
    explanation: "'Will' is used for spontaneous, on-the-spot decisions made at the moment of speaking.",
    referenceNote: "English Grammar - Simple Future: Spontaneous Decisions",
    options: [
      { text: "am answering", isCorrect: false },
      { text: "will answer", isCorrect: true },
      { text: "am going to answer", isCorrect: false },
      { text: "answer", isCorrect: false }
    ]
  },
  {
    questionID: 38,
    questionText: "Look at those dark, ominous clouds! It ________.",
    difficultyLevel: "easy",
    correctAnswer: "is going to rain",
    explanation: "'Be going to' is used when making predictions based on clear present evidence (dark clouds).",
    referenceNote: "English Grammar - Future: 'Be Going To' with Present Evidence",
    options: [
      { text: "will rain", isCorrect: false },
      { text: "is going to rain", isCorrect: true },
      { text: "rains", isCorrect: false },
      { text: "shall rain", isCorrect: false }
    ]
  },
  {
    questionID: 39,
    questionText: "I promise that I ________ your secret to anyone.",
    difficultyLevel: "easy",
    correctAnswer: "will not reveal",
    explanation: "Promises and commitments are expressed using 'will' / 'will not': 'I will not reveal...'.",
    referenceNote: "English Grammar - Simple Future: Promises",
    options: [
      { text: "am not revealing", isCorrect: false },
      { text: "will not reveal", isCorrect: true },
      { text: "do not reveal", isCorrect: false },
      { text: "am not going to reveal", isCorrect: false }
    ]
  },
  {
    questionID: 40,
    questionText: "Scientists believe that artificial intelligence ________ everyday life significantly by 2040.",
    difficultyLevel: "medium",
    correctAnswer: "will change",
    explanation: "Opinions and predictions based on belief (introduced by 'believe', 'think', 'expect') typically use 'will'.",
    referenceNote: "English Grammar - Simple Future: Predictions with 'Believe'",
    options: [
      { text: "will change", isCorrect: true },
      { text: "changes", isCorrect: false },
      { text: "is changing", isCorrect: false },
      { text: "has changed", isCorrect: false }
    ]
  },

  // --- Future Continuous (41-44) ---
  {
    questionID: 41,
    questionText: "This time next week, we ________ on a sunny beach in Koh Rong.",
    difficultyLevel: "medium",
    correctAnswer: "will be relaxing",
    explanation: "Future Continuous ('will be relaxing') refers to an action that will be in progress at a specific time in the future.",
    referenceNote: "English Grammar - Future Continuous: Action in Progress at Future Time",
    options: [
      { text: "will relax", isCorrect: false },
      { text: "will be relaxing", isCorrect: true },
      { text: "are relaxing", isCorrect: false },
      { text: "will have relaxed", isCorrect: false }
    ]
  },
  {
    questionID: 42,
    questionText: "Don't call him between 2 PM and 4 PM because he ________ an important exam.",
    difficultyLevel: "medium",
    correctAnswer: "will be taking",
    explanation: "Future Continuous ('will be taking') is used to express an activity that will be in progress during a future time interval.",
    referenceNote: "English Grammar - Future Continuous: Future Time Interval",
    options: [
      { text: "will take", isCorrect: false },
      { text: "takes", isCorrect: false },
      { text: "will be taking", isCorrect: true },
      { text: "will have taken", isCorrect: false }
    ]
  },
  {
    questionID: 43,
    questionText: "________ you ________ the computer tonight, or may I borrow it?",
    difficultyLevel: "hard",
    correctAnswer: "Will / be using",
    explanation: "The Future Continuous ('Will you be using...?') is commonly used as a polite question to ask about someone's future plans without imposing.",
    referenceNote: "English Grammar - Future Continuous: Polite Inquiry about Plans",
    options: [
      { text: "Will / use", isCorrect: false },
      { text: "Will / be using", isCorrect: true },
      { text: "Do / use", isCorrect: false },
      { text: "Are / used", isCorrect: false }
    ]
  },
  {
    questionID: 44,
    questionText: "Professor Kim ________ lectures at the university as usual next semester.",
    difficultyLevel: "medium",
    correctAnswer: "will be delivering",
    explanation: "Future Continuous can represent routine events that will take place as a matter of regular course: 'will be delivering'.",
    referenceNote: "English Grammar - Future Continuous: Routine Events in the Future",
    options: [
      { text: "will be delivering", isCorrect: true },
      { text: "delivered", isCorrect: false },
      { text: "has delivered", isCorrect: false },
      { text: "delivers", isCorrect: false }
    ]
  },

  // --- Future Perfect (45-48) ---
  {
    questionID: 45,
    questionText: "By the end of this year, they ________ the construction of the new highway.",
    difficultyLevel: "medium",
    correctAnswer: "will have completed",
    explanation: "'By + future time' ('By the end of this year') indicates a deadline, requiring the Future Perfect ('will have completed').",
    referenceNote: "English Grammar - Future Perfect: Action Completed before Future Time",
    options: [
      { text: "will complete", isCorrect: false },
      { text: "will have completed", isCorrect: true },
      { text: "complete", isCorrect: false },
      { text: "will be completing", isCorrect: false }
    ]
  },
  {
    questionID: 46,
    questionText: "Before you arrive tomorrow, I ________ all the preparation work.",
    difficultyLevel: "medium",
    correctAnswer: "will have finished",
    explanation: "An action that will be completed prior to another future moment requires Future Perfect: 'will have finished'.",
    referenceNote: "English Grammar - Future Perfect: Sequence in the Future",
    options: [
      { text: "will finish", isCorrect: false },
      { text: "will have finished", isCorrect: true },
      { text: "finished", isCorrect: false },
      { text: "have finished", isCorrect: false }
    ]
  },
  {
    questionID: 47,
    questionText: "By next month, she ________ at this international school for five years.",
    difficultyLevel: "easy",
    correctAnswer: "will have taught",
    explanation: "Future Perfect ('will have taught') expresses that an action will reach a specific milestone by a future point in time.",
    referenceNote: "English Grammar - Future Perfect: Future Milestones",
    options: [
      { text: "will have taught", isCorrect: true },
      { text: "will teach", isCorrect: false },
      { text: "is teaching", isCorrect: false },
      { text: "teaches", isCorrect: false }
    ]
  },
  {
    questionID: 48,
    questionText: "Will scientists ________ a cure for the disease by the year 2035?",
    difficultyLevel: "medium",
    correctAnswer: "have found",
    explanation: "In an interrogative Future Perfect clause ('Will scientists have found... by...?'), 'have' + past participle is used after the subject.",
    referenceNote: "English Grammar - Future Perfect: Interrogative Form",
    options: [
      { text: "found", isCorrect: false },
      { text: "have found", isCorrect: true },
      { text: "be finding", isCorrect: false },
      { text: "find", isCorrect: false }
    ]
  },

  // --- Future Perfect Continuous (49-52) ---
  {
    questionID: 49,
    questionText: "By 6 PM, Dara ________ for eight hours without a break.",
    difficultyLevel: "hard",
    correctAnswer: "will have been coding",
    explanation: "Future Perfect Continuous ('will have been coding') emphasizes how long an ongoing activity will have lasted up to a specific future deadline.",
    referenceNote: "English Grammar - Future Perfect Continuous: Duration until Future Time",
    options: [
      { text: "will code", isCorrect: false },
      { text: "will be coding", isCorrect: false },
      { text: "will have been coding", isCorrect: true },
      { text: "has been coding", isCorrect: false }
    ]
  },
  {
    questionID: 50,
    questionText: "In December, we ________ in this house for exactly two decades.",
    difficultyLevel: "hard",
    correctAnswer: "will have been living",
    explanation: "Expressing the ongoing duration of residency up to next December requires Future Perfect Continuous: 'will have been living'.",
    referenceNote: "English Grammar - Future Perfect Continuous: Ongoing State to Future Point",
    options: [
      { text: "will live", isCorrect: false },
      { text: "will have been living", isCorrect: true },
      { text: "are living", isCorrect: false },
      { text: "have lived", isCorrect: false }
    ]
  },
  {
    questionID: 51,
    questionText: "By the time he graduates, he ________ medicine for seven years.",
    difficultyLevel: "hard",
    correctAnswer: "will have been studying",
    explanation: "'By the time + simple present' paired with duration ('for seven years') calls for Future Perfect Continuous.",
    referenceNote: "English Grammar - Future Perfect Continuous: Clause Combinations",
    options: [
      { text: "will study", isCorrect: false },
      { text: "will have studied", isCorrect: false },
      { text: "will have been studying", isCorrect: true },
      { text: "is studying", isCorrect: false }
    ]
  },
  {
    questionID: 52,
    questionText: "Next month, the marathon runner ________ with her coach for two full years.",
    difficultyLevel: "hard",
    correctAnswer: "will have been training",
    explanation: "Emphasizing the unbroken continuation of training leading up to next month requires Future Perfect Continuous: 'will have been training'.",
    referenceNote: "English Grammar - Future Perfect Continuous: Emphasizing Continuity",
    options: [
      { text: "will have been training", isCorrect: true },
      { text: "will train", isCorrect: false },
      { text: "is training", isCorrect: false },
      { text: "trains", isCorrect: false }
    ]
  },

  // ==========================================
  // SECTION 2: PARTS OF SPEECH (Questions 53 - 100)
  // ==========================================

  // --- Nouns (53-58) ---
  {
    questionID: 53,
    questionText: "The doctor gave me some valuable ________ on how to stay healthy.",
    difficultyLevel: "easy",
    correctAnswer: "advice",
    explanation: "'Advice' is an uncountable noun and cannot be pluralized (*advices) nor preceded by 'an'.",
    referenceNote: "English Grammar - Parts of Speech: Uncountable Nouns",
    options: [
      { text: "advices", isCorrect: false },
      { text: "advice", isCorrect: true },
      { text: "an advice", isCorrect: false },
      { text: "advise", isCorrect: false }
    ]
  },
  {
    questionID: 54,
    questionText: "Several ________ were grazing peacefully in the green pasture.",
    difficultyLevel: "medium",
    correctAnswer: "sheep",
    explanation: "The noun 'sheep' has the same form in both singular and plural. 'Sheeps' does not exist in standard English.",
    referenceNote: "English Grammar - Parts of Speech: Irregular Plural Nouns",
    options: [
      { text: "sheeps", isCorrect: false },
      { text: "sheep", isCorrect: true },
      { text: "sheepes", isCorrect: false },
      { text: "shoop", isCorrect: false }
    ]
  },
  {
    questionID: 55,
    questionText: "The committee ________ made its final decision regarding the budget.",
    difficultyLevel: "medium",
    correctAnswer: "has",
    explanation: "When a collective noun like 'committee' acts as a single unified entity, it takes a singular verb ('has').",
    referenceNote: "English Grammar - Parts of Speech: Collective Nouns",
    options: [
      { text: "have", isCorrect: false },
      { text: "has", isCorrect: true },
      { text: "are", isCorrect: false },
      { text: "were", isCorrect: false }
    ]
  },
  {
    questionID: 56,
    questionText: "Identify the abstract noun in the sentence: \"Her honesty earned her the respect of all her colleagues.\"",
    difficultyLevel: "easy",
    correctAnswer: "honesty",
    explanation: "'Honesty' is an abstract noun denoting a quality or moral trait that cannot be physically touched or seen.",
    referenceNote: "English Grammar - Parts of Speech: Abstract Nouns",
    options: [
      { text: "earned", isCorrect: false },
      { text: "colleagues", isCorrect: false },
      { text: "honesty", isCorrect: true },
      { text: "all", isCorrect: false }
    ]
  },
  {
    questionID: 57,
    questionText: "Both of my ________ are practicing lawyers in the capital city.",
    difficultyLevel: "hard",
    correctAnswer: "brothers-in-law",
    explanation: "In compound nouns composed of a noun + preposition + noun, the plural suffix -s is added to the principal noun: 'brothers-in-law'.",
    referenceNote: "English Grammar - Parts of Speech: Compound Noun Plurals",
    options: [
      { text: "brother-in-laws", isCorrect: false },
      { text: "brothers-in-law", isCorrect: true },
      { text: "brothers-in-laws", isCorrect: false },
      { text: "brother-in-law", isCorrect: false }
    ]
  },
  {
    questionID: 58,
    questionText: "The ________ of the experiment confirmed our original hypothesis.",
    difficultyLevel: "medium",
    correctAnswer: "criterion",
    explanation: "'Hypothesis' is singular; when referring to a single rule or test, 'criterion' is the singular form (plural: 'criteria'). Wait, in this sentence: 'The criterion of the experiment...'.",
    referenceNote: "English Grammar - Parts of Speech: Greek/Latin Noun Forms",
    options: [
      { text: "criteria", isCorrect: false },
      { text: "criterions", isCorrect: false },
      { text: "criterion", isCorrect: true },
      { text: "criterium", isCorrect: false }
    ]
  },

  // --- Pronouns (59-64) ---
  {
    questionID: 59,
    questionText: "The woman ________ car was stolen reported the incident to the police immediately.",
    difficultyLevel: "easy",
    correctAnswer: "whose",
    explanation: "'Whose' is the relative possessive pronoun showing ownership connecting 'The woman' to 'car'.",
    referenceNote: "English Grammar - Parts of Speech: Relative Pronouns (Possessive)",
    options: [
      { text: "who", isCorrect: false },
      { text: "whom", isCorrect: false },
      { text: "whose", isCorrect: true },
      { text: "which", isCorrect: false }
    ]
  },
  {
    questionID: 60,
    questionText: "Between you and ________, I don't think their new plan will succeed.",
    difficultyLevel: "medium",
    correctAnswer: "me",
    explanation: "'Between' is a preposition, so pronouns governed by it must be in the objective case: 'between you and me'.",
    referenceNote: "English Grammar - Parts of Speech: Objective Pronouns with Prepositions",
    options: [
      { text: "I", isCorrect: false },
      { text: "me", isCorrect: true },
      { text: "myself", isCorrect: false },
      { text: "mine", isCorrect: false }
    ]
  },
  {
    questionID: 61,
    questionText: "The young boy made this beautiful wooden model all by ________.",
    difficultyLevel: "easy",
    correctAnswer: "himself",
    explanation: "'By himself' is an idiomatic reflexive phrase meaning 'alone' or 'without assistance'.",
    referenceNote: "English Grammar - Parts of Speech: Reflexive Pronouns",
    options: [
      { text: "him", isCorrect: false },
      { text: "his", isCorrect: false },
      { text: "himself", isCorrect: true },
      { text: "oneself", isCorrect: false }
    ]
  },
  {
    questionID: 62,
    questionText: "This notebook is mine, but that one over there is ________.",
    difficultyLevel: "easy",
    correctAnswer: "hers",
    explanation: "'Hers' is an absolute possessive pronoun standing alone without a following noun.",
    referenceNote: "English Grammar - Parts of Speech: Possessive Pronouns",
    options: [
      { text: "her", isCorrect: false },
      { text: "hers", isCorrect: true },
      { text: "her's", isCorrect: false },
      { text: "she", isCorrect: false }
    ]
  },
  {
    questionID: 63,
    questionText: "The candidate ________ the committee selected has extensive management experience.",
    difficultyLevel: "hard",
    correctAnswer: "whom",
    explanation: "'Whom' is the formal relative pronoun used when referring to a person as the grammatical object of the relative clause ('the committee selected whom').",
    referenceNote: "English Grammar - Parts of Speech: Relative Pronoun 'Whom'",
    options: [
      { text: "whose", isCorrect: false },
      { text: "which", isCorrect: false },
      { text: "whom", isCorrect: true },
      { text: "where", isCorrect: false }
    ]
  },
  {
    questionID: 64,
    questionText: "Neither of the two candidates ________ qualified for the specialized position.",
    difficultyLevel: "medium",
    correctAnswer: "is",
    explanation: "'Neither' is an indefinite pronoun that takes a singular verb in formal standard English ('is').",
    referenceNote: "English Grammar - Parts of Speech: Indefinite Pronouns Agreement",
    options: [
      { text: "is", isCorrect: true },
      { text: "are", isCorrect: false },
      { text: "were", isCorrect: false },
      { text: "being", isCorrect: false }
    ]
  },

  // --- Verbs (65-70) ---
  {
    questionID: 65,
    questionText: "You ________ smoke inside the hospital; it is strictly prohibited by law.",
    difficultyLevel: "easy",
    correctAnswer: "must not",
    explanation: "'Must not' expresses strong prohibition forbidden by law or rule.",
    referenceNote: "English Grammar - Parts of Speech: Modal Verbs of Prohibition",
    options: [
      { text: "don't have to", isCorrect: false },
      { text: "must not", isCorrect: true },
      { text: "might not", isCorrect: false },
      { text: "need not", isCorrect: false }
    ]
  },
  {
    questionID: 66,
    questionText: "She decided ________ to the conference in Singapore to improve her network.",
    difficultyLevel: "easy",
    correctAnswer: "to go",
    explanation: "The verb 'decide' is followed by a to-infinitive ('decided to go').",
    referenceNote: "English Grammar - Parts of Speech: Verbs Followed by Infinitive",
    options: [
      { text: "going", isCorrect: false },
      { text: "to go", isCorrect: true },
      { text: "go", isCorrect: false },
      { text: "gone", isCorrect: false }
    ]
  },
  {
    questionID: 67,
    questionText: "He avoids ________ sugary snacks because he wants to lose weight.",
    difficultyLevel: "easy",
    correctAnswer: "eating",
    explanation: "The verb 'avoid' must be followed by a gerund (-ing form): 'avoids eating'.",
    referenceNote: "English Grammar - Parts of Speech: Verbs Followed by Gerund",
    options: [
      { text: "to eat", isCorrect: false },
      { text: "eating", isCorrect: true },
      { text: "eat", isCorrect: false },
      { text: "eaten", isCorrect: false }
    ]
  },
  {
    questionID: 68,
    questionText: "Identify whether the underlined verb is transitive or intransitive: \"The baby *slept* soundly all night.\"",
    difficultyLevel: "medium",
    correctAnswer: "Intransitive verb",
    explanation: "'Sleep' does not take a direct object; therefore, it functions as an intransitive verb.",
    referenceNote: "English Grammar - Parts of Speech: Transitive vs Intransitive Verbs",
    options: [
      { text: "Transitive verb", isCorrect: false },
      { text: "Intransitive verb", isCorrect: true },
      { text: "Linking verb", isCorrect: false },
      { text: "Auxiliary verb", isCorrect: false }
    ]
  },
  {
    questionID: 69,
    questionText: "If you had informed us earlier, we ________ our schedule accordingly.",
    difficultyLevel: "hard",
    correctAnswer: "would have adjusted",
    explanation: "Third conditional (unreal past) structure: 'If + past perfect..., would have + past participle'.",
    referenceNote: "English Grammar - Parts of Speech: Conditional Modal Verbs",
    options: [
      { text: "will adjust", isCorrect: false },
      { text: "would adjust", isCorrect: false },
      { text: "would have adjusted", isCorrect: true },
      { text: "had adjusted", isCorrect: false }
    ]
  },
  {
    questionID: 70,
    questionText: "The teacher made all the students ________ their essays twice.",
    difficultyLevel: "medium",
    correctAnswer: "rewrite",
    explanation: "Causative verb 'make' + object takes a bare infinitive without 'to': 'made all the students rewrite'.",
    referenceNote: "English Grammar - Parts of Speech: Causative Verbs",
    options: [
      { text: "to rewrite", isCorrect: false },
      { text: "rewriting", isCorrect: false },
      { text: "rewrite", isCorrect: true },
      { text: "rewrote", isCorrect: false }
    ]
  },

  // --- Adjectives (71-76) ---
  {
    questionID: 71,
    questionText: "This math problem is ________ more difficult than the one we solved earlier.",
    difficultyLevel: "medium",
    correctAnswer: "much",
    explanation: "We use 'much' (or 'far', 'significantly') as an intensifier before comparative adjectives: 'much more difficult'.",
    referenceNote: "English Grammar - Parts of Speech: Modifiers of Comparatives",
    options: [
      { text: "very", isCorrect: false },
      { text: "much", isCorrect: true },
      { text: "more", isCorrect: false },
      { text: "too", isCorrect: false }
    ]
  },
  {
    questionID: 72,
    questionText: "What is the correct royal order of adjectives? \"She bought a ________ bag.\"",
    difficultyLevel: "hard",
    correctAnswer: "beautiful small black leather",
    explanation: "The standard adjective order is: Opinion (beautiful) -> Size (small) -> Color (black) -> Material (leather).",
    referenceNote: "English Grammar - Parts of Speech: Order of Adjectives",
    options: [
      { text: "small beautiful leather black", isCorrect: false },
      { text: "leather black small beautiful", isCorrect: false },
      { text: "beautiful small black leather", isCorrect: true },
      { text: "black beautiful small leather", isCorrect: false }
    ]
  },
  {
    questionID: 73,
    questionText: "The documentary on marine ecosystems was utterly ________.",
    difficultyLevel: "easy",
    correctAnswer: "fascinating",
    explanation: "We use participle adjectives ending in -ing ('fascinating') to describe the thing or situation that causes the feeling.",
    referenceNote: "English Grammar - Parts of Speech: Participle Adjectives (-ed vs -ing)",
    options: [
      { text: "fascinated", isCorrect: false },
      { text: "fascinating", isCorrect: true },
      { text: "fascination", isCorrect: false },
      { text: "fascinate", isCorrect: false }
    ]
  },
  {
    questionID: 74,
    questionText: "All the students felt ________ when they heard the test was postponed.",
    difficultyLevel: "easy",
    correctAnswer: "relieved",
    explanation: "Participle adjectives ending in -ed ('relieved') describe the person experiencing the emotion.",
    referenceNote: "English Grammar - Parts of Speech: Emotional Adjectives",
    options: [
      { text: "relieving", isCorrect: false },
      { text: "relieved", isCorrect: true },
      { text: "relief", isCorrect: false },
      { text: "relieve", isCorrect: false }
    ]
  },
  {
    questionID: 75,
    questionText: "Of the three brothers, Piseth is by far the ________.",
    difficultyLevel: "easy",
    correctAnswer: "tallest",
    explanation: "When comparing three or more entities, the superlative degree ('the tallest') must be used.",
    referenceNote: "English Grammar - Parts of Speech: Superlative Degree",
    options: [
      { text: "taller", isCorrect: false },
      { text: "tallest", isCorrect: true },
      { text: "more tall", isCorrect: false },
      { text: "most tall", isCorrect: false }
    ]
  },
  {
    questionID: 76,
    questionText: "In the phrase \"the injured passengers\", what type of word is 'injured'?",
    difficultyLevel: "medium",
    correctAnswer: "Participial adjective",
    explanation: "'Injured' is a past participle used adjectivally to modify the noun 'passengers'.",
    referenceNote: "English Grammar - Parts of Speech: Participial Adjectives",
    options: [
      { text: "Main verb", isCorrect: false },
      { text: "Participial adjective", isCorrect: true },
      { text: "Adverb", isCorrect: false },
      { text: "Collective noun", isCorrect: false }
    ]
  },

  // --- Adverbs (77-82) ---
  {
    questionID: 77,
    questionText: "She speaks English very ________, having lived in London for five years.",
    difficultyLevel: "easy",
    correctAnswer: "fluently",
    explanation: "An adverb of manner ('fluently') is needed to modify the verb 'speaks'. 'Fluent' is an adjective.",
    referenceNote: "English Grammar - Parts of Speech: Adverbs of Manner",
    options: [
      { text: "fluent", isCorrect: false },
      { text: "fluently", isCorrect: true },
      { text: "fluency", isCorrect: false },
      { text: "more fluent", isCorrect: false }
    ]
  },
  {
    questionID: 78,
    questionText: "He ________ arrives late for work; his punctuality is admired by everyone.",
    difficultyLevel: "easy",
    correctAnswer: "rarely",
    explanation: "'Rarely' is an adverb of frequency meaning almost never, which aligns with 'his punctuality is admired'.",
    referenceNote: "English Grammar - Parts of Speech: Adverbs of Frequency",
    options: [
      { text: "often", isCorrect: false },
      { text: "rarely", isCorrect: true },
      { text: "always", isCorrect: false },
      { text: "usually", isCorrect: false }
    ]
  },
  {
    questionID: 79,
    questionText: "The athlete ran ________ fast that no competitor could keep up with him.",
    difficultyLevel: "medium",
    correctAnswer: "so",
    explanation: "'So + adverb + that' is the standard correlative structure used to express cause and result.",
    referenceNote: "English Grammar - Parts of Speech: Adverbs of Degree with 'So...That'",
    options: [
      { text: "too", isCorrect: false },
      { text: "such", isCorrect: false },
      { text: "so", isCorrect: true },
      { text: "very", isCorrect: false }
    ]
  },
  {
    questionID: 80,
    questionText: "Although he tried ________, he could not open the rusty lock.",
    difficultyLevel: "medium",
    correctAnswer: "hard",
    explanation: "'Hard' functions as both an adjective and an adverb meaning 'with great effort'. 'Hardly' means 'scarcely/barely'.",
    referenceNote: "English Grammar - Parts of Speech: 'Hard' vs 'Hardly'",
    options: [
      { text: "hardly", isCorrect: false },
      { text: "hard", isCorrect: true },
      { text: "harderly", isCorrect: false },
      { text: "with hardness", isCorrect: false }
    ]
  },
  {
    questionID: 81,
    questionText: "Seldom ________ such a breathtaking view from a mountain peak.",
    difficultyLevel: "hard",
    correctAnswer: "have I witnessed",
    explanation: "When a negative adverb like 'Seldom' starts a sentence, subject-auxiliary inversion is mandatory: 'Seldom have I witnessed...'.",
    referenceNote: "English Grammar - Parts of Speech: Negative Adverbs and Inversion",
    options: [
      { text: "I have witnessed", isCorrect: false },
      { text: "have I witnessed", isCorrect: true },
      { text: "I witnessed", isCorrect: false },
      { text: "did I witnessed", isCorrect: false }
    ]
  },
  {
    questionID: 82,
    questionText: "Identify the adverb in the sentence: \"They walked quite slowly through the dark forest.\"",
    difficultyLevel: "medium",
    correctAnswer: "Both 'quite' and 'slowly'",
    explanation: "'Slowly' is an adverb of manner modifying 'walked', and 'quite' is an adverb of degree modifying 'slowly'.",
    referenceNote: "English Grammar - Parts of Speech: Identifying Multiple Adverbs",
    options: [
      { text: "dark", isCorrect: false },
      { text: "forest", isCorrect: false },
      { text: "Both 'quite' and 'slowly'", isCorrect: true },
      { text: "slowly only", isCorrect: false }
    ]
  },

  // --- Prepositions (83-88) ---
  {
    questionID: 83,
    questionText: "The international symposium will be held ________ Friday, October 24th.",
    difficultyLevel: "easy",
    correctAnswer: "on",
    explanation: "Preposition 'on' is used with specific days and calendar dates ('on Friday, October 24th').",
    referenceNote: "English Grammar - Parts of Speech: Prepositions of Time",
    options: [
      { text: "in", isCorrect: false },
      { text: "at", isCorrect: false },
      { text: "on", isCorrect: true },
      { text: "by", isCorrect: false }
    ]
  },
  {
    questionID: 84,
    questionText: "She has been interested ________ Southeast Asian history since childhood.",
    difficultyLevel: "easy",
    correctAnswer: "in",
    explanation: "The adjective 'interested' takes the dependent preposition 'in': 'interested in'.",
    referenceNote: "English Grammar - Parts of Speech: Dependent Prepositions",
    options: [
      { text: "at", isCorrect: false },
      { text: "with", isCorrect: false },
      { text: "in", isCorrect: true },
      { text: "for", isCorrect: false }
    ]
  },
  {
    questionID: 85,
    questionText: "The prize money was divided equally ________ the four winning team members.",
    difficultyLevel: "medium",
    correctAnswer: "among",
    explanation: "We use 'among' when referring to three or more people or items considered as a group. 'Between' is primarily used for two.",
    referenceNote: "English Grammar - Parts of Speech: 'Between' vs 'Among'",
    options: [
      { text: "between", isCorrect: false },
      { text: "among", isCorrect: true },
      { text: "with", isCorrect: false },
      { text: "through", isCorrect: false }
    ]
  },
  {
    questionID: 86,
    questionText: "He apologized ________ his supervisor ________ being late to the meeting.",
    difficultyLevel: "medium",
    correctAnswer: "to / for",
    explanation: "The correct prepositional pattern is: 'apologize to someone for something'.",
    referenceNote: "English Grammar - Parts of Speech: Verb + Preposition Combinations",
    options: [
      { text: "with / about", isCorrect: false },
      { text: "to / for", isCorrect: true },
      { text: "at / in", isCorrect: false },
      { text: "for / to", isCorrect: false }
    ]
  },
  {
    questionID: 87,
    questionText: "The meeting is scheduled to start promptly ________ 9:00 AM.",
    difficultyLevel: "easy",
    correctAnswer: "at",
    explanation: "Preposition 'at' is used for exact, precise times of day ('at 9:00 AM').",
    referenceNote: "English Grammar - Parts of Speech: Preposition 'At'",
    options: [
      { text: "in", isCorrect: false },
      { text: "on", isCorrect: false },
      { text: "at", isCorrect: true },
      { text: "to", isCorrect: false }
    ]
  },
  {
    questionID: 88,
    questionText: "Are you capable ________ managing a regional project independently?",
    difficultyLevel: "medium",
    correctAnswer: "of",
    explanation: "The adjective 'capable' takes the preposition 'of' followed by a gerund: 'capable of managing'.",
    referenceNote: "English Grammar - Parts of Speech: Adjective + Preposition 'Capable of'",
    options: [
      { text: "to", isCorrect: false },
      { text: "for", isCorrect: false },
      { text: "of", isCorrect: true },
      { text: "with", isCorrect: false }
    ]
  },

  // --- Conjunctions (89-94) ---
  {
    questionID: 89,
    questionText: "________ it was raining heavily, they decided to proceed with the soccer match.",
    difficultyLevel: "easy",
    correctAnswer: "Although",
    explanation: "'Although' is a subordinating conjunction used to introduce a clause of concession/contrast.",
    referenceNote: "English Grammar - Parts of Speech: Subordinating Conjunctions of Concession",
    options: [
      { text: "Despite", isCorrect: false },
      { text: "In spite of", isCorrect: false },
      { text: "Although", isCorrect: true },
      { text: "However", isCorrect: false }
    ]
  },
  {
    questionID: 90,
    questionText: "You will not pass the examination ________ you study consistently.",
    difficultyLevel: "easy",
    correctAnswer: "unless",
    explanation: "'Unless' means 'if not' and introduces a condition required for something to happen.",
    referenceNote: "English Grammar - Parts of Speech: Conditional Conjunction 'Unless'",
    options: [
      { text: "if", isCorrect: false },
      { text: "unless", isCorrect: true },
      { text: "provided that", isCorrect: false },
      { text: "as long as", isCorrect: false }
    ]
  },
  {
    questionID: 91,
    questionText: "He is not only intelligent ________ incredibly hardworking.",
    difficultyLevel: "easy",
    correctAnswer: "but also",
    explanation: "The correlative conjunction 'not only' pairs with 'but also'.",
    referenceNote: "English Grammar - Parts of Speech: Correlative Conjunctions",
    options: [
      { text: "and also", isCorrect: false },
      { text: "but also", isCorrect: true },
      { text: "or also", isCorrect: false },
      { text: "as well", isCorrect: false }
    ]
  },
  {
    questionID: 92,
    questionText: "Neither John ________ his sisters were able to attend the family gathering.",
    difficultyLevel: "medium",
    correctAnswer: "nor",
    explanation: "'Neither' correctly pairs with 'nor' as a correlative negative conjunction.",
    referenceNote: "English Grammar - Parts of Speech: Correlative 'Neither...Nor'",
    options: [
      { text: "or", isCorrect: false },
      { text: "nor", isCorrect: true },
      { text: "and", isCorrect: false },
      { text: "but", isCorrect: false }
    ]
  },
  {
    questionID: 93,
    questionText: "Take an umbrella with you in case it ________ later today.",
    difficultyLevel: "medium",
    correctAnswer: "rains",
    explanation: "'In case' is a conjunction used to talk about precautions against something that might happen, followed by present tense for future possibility.",
    referenceNote: "English Grammar - Parts of Speech: Conjunction 'In Case'",
    options: [
      { text: "rains", isCorrect: true },
      { text: "will rain", isCorrect: false },
      { text: "rained", isCorrect: false },
      { text: "shall rain", isCorrect: false }
    ]
  },
  {
    questionID: 94,
    questionText: "She studied diligently; ________, she achieved the highest score in the province.",
    difficultyLevel: "hard",
    correctAnswer: "consequently",
    explanation: "'Consequently' is a conjunctive adverb showing a logical result, correctly preceded by a semicolon and followed by a comma.",
    referenceNote: "English Grammar - Parts of Speech: Conjunctive Adverbs",
    options: [
      { text: "consequently", isCorrect: true },
      { text: "although", isCorrect: false },
      { text: "despite", isCorrect: false },
      { text: "whereas", isCorrect: false }
    ]
  },

  // --- Articles & Determiners (95-100) ---
  {
    questionID: 95,
    questionText: "Mount Everest is ________ highest mountain in the world.",
    difficultyLevel: "easy",
    correctAnswer: "the",
    explanation: "Superlative adjectives ('highest') take the definite article 'the'.",
    referenceNote: "English Grammar - Parts of Speech: Definite Article with Superlatives",
    options: [
      { text: "a", isCorrect: false },
      { text: "an", isCorrect: false },
      { text: "the", isCorrect: true },
      { text: "no article", isCorrect: false }
    ]
  },
  {
    questionID: 96,
    questionText: "It took us nearly ________ hour to reach the top of the hill.",
    difficultyLevel: "easy",
    correctAnswer: "an",
    explanation: "'Hour' begins with a silent 'h' and a vowel sound (/aʊər/), so the indefinite article 'an' is required.",
    referenceNote: "English Grammar - Parts of Speech: Indefinite Article with Silent 'h'",
    options: [
      { text: "a", isCorrect: false },
      { text: "an", isCorrect: true },
      { text: "the", isCorrect: false },
      { text: "no article", isCorrect: false }
    ]
  },
  {
    questionID: 97,
    questionText: "There is ________ hope of finding survivors after the devastating avalanche.",
    difficultyLevel: "medium",
    correctAnswer: "little",
    explanation: "'Little' is used with uncountable nouns ('hope') to express a negative or scarce meaning ('almost no hope').",
    referenceNote: "English Grammar - Parts of Speech: Determiners 'Little' vs 'Few'",
    options: [
      { text: "few", isCorrect: false },
      { text: "little", isCorrect: true },
      { text: "a few", isCorrect: false },
      { text: "many", isCorrect: false }
    ]
  },
  {
    questionID: 98,
    questionText: "________ Mekong River flows through six different Asian countries.",
    difficultyLevel: "medium",
    correctAnswer: "The",
    explanation: "Names of rivers (Mekong River, Nile, Amazon) always take the definite article 'The'.",
    referenceNote: "English Grammar - Parts of Speech: Definite Article with Geographical Names",
    options: [
      { text: "A", isCorrect: false },
      { text: "The", isCorrect: true },
      { text: "An", isCorrect: false },
      { text: "No article", isCorrect: false }
    ]
  },
  {
    questionID: 99,
    questionText: "We have ________ friends living in Siem Reap who can show us around.",
    difficultyLevel: "easy",
    correctAnswer: "a few",
    explanation: "'A few' is used with plural countable nouns ('friends') with a positive meaning ('some, a small number').",
    referenceNote: "English Grammar - Parts of Speech: Determiners 'A Few' vs 'A Little'",
    options: [
      { text: "a little", isCorrect: false },
      { text: "a few", isCorrect: true },
      { text: "much", isCorrect: false },
      { text: "little", isCorrect: false }
    ]
  },
  {
    questionID: 100,
    questionText: "Identify the part of speech of the word 'alas' in: \"*Alas*, the ancient temple was severely damaged by the storm.\"",
    difficultyLevel: "easy",
    correctAnswer: "Interjection",
    explanation: "'Alas' is an interjection used to express grief, regret, sorrow, or pity.",
    referenceNote: "English Grammar - Parts of Speech: Interjections",
    options: [
      { text: "Conjunction", isCorrect: false },
      { text: "Preposition", isCorrect: false },
      { text: "Interjection", isCorrect: true },
      { text: "Adverb", isCorrect: false }
    ]
  }
];

