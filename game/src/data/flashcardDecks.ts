// Questions for the flashcard game. Bundled with the arcade so it works without
// login or the API. `answer` is the index of the correct option; options are
// shuffled when a card is shown.
import { CCNA_CARDS } from './ccnaCards';
import { CODING_EXTRA_CARDS } from './codingCards';
import { CULTURE_EXTRA_CARDS } from './cultureCards';
import { DATA_SCIENCE_CARDS } from './dataScienceCards';

export type BoothDeckId = 'coding' | 'culture' | 'datascience' | 'ccna';

export interface BoothCard {
  question: string;
  code?: string;
  options: string[];
  answer: number;
  explain: string;
}

export interface BoothDeck {
  id: BoothDeckId;
  titleKm: string;
  titleEn: string;
  subtitleKm: string;
  cards: BoothCard[];
}

const CODING_CARDS: BoothCard[] = [
  {
    question: 'តើ HTML មកពីពាក្យអ្វី?',
    options: ['HyperText Markup Language', 'High Tech Modern Language', 'Home Tool Markup Language', 'Hyper Transfer Main Link'],
    answer: 0,
    explain: 'HTML ជាភាសាសម្រាប់កំណត់រចនាសម្ព័ន្ធគេហទំព័រ។',
  },
  {
    question: 'តើ CSS ប្រើសម្រាប់ធ្វើអ្វី?',
    options: ['រចនាពណ៌ និងទម្រង់គេហទំព័រ', 'រក្សាទុកទិន្នន័យ', 'ភ្ជាប់អ៊ីនធឺណិត', 'សរសេរ Database'],
    answer: 0,
    explain: 'CSS (Cascading Style Sheets) កំណត់ពណ៌ ពុម្ពអក្សរ និងប្លង់។',
  },
  {
    question: 'តើ Tag មួយណាបង្កើតចំណងជើងធំជាងគេ?',
    options: ['<h1>', '<h6>', '<head>', '<title>'],
    answer: 0,
    explain: '<h1> ធំជាងគេ ហើយ <h6> តូចជាងគេ។',
  },
  {
    question: 'តើ Tag មួយណាបង្កើតតំណភ្ជាប់ (Link)?',
    options: ['<a>', '<link>', '<p>', '<href>'],
    answer: 0,
    explain: 'ឧទាហរណ៍៖ <a href="https://passkru.com">PassKru</a>',
  },
  {
    question: 'តើកូដ JavaScript ខាងក្រោមបង្ហាញអ្វី?',
    code: 'console.log(2 + "2");',
    options: ['"22"', '4', 'Error', 'NaN'],
    answer: 0,
    explain: 'លេខ + String ត្រូវបានភ្ជាប់ជា String "22"។',
  },
  {
    question: 'តើកូដ Python ខាងក្រោមបង្ហាញអ្វី?',
    code: 'print(3 * "ab")',
    options: ['ababab', 'ab3', '6', 'Error'],
    answer: 0,
    explain: 'គុណ String នឹងលេខ គឺដដែល String នោះ ៣ដង។',
  },
  {
    question: 'តើកូដ Python ខាងក្រោមបង្ហាញអ្វី?',
    code: 'print(len([1, 2, 3]))',
    options: ['3', '2', '6', '[1, 2, 3]'],
    answer: 0,
    explain: 'len() រាប់ចំនួនធាតុក្នុង List។',
  },
  {
    question: 'តើលេខ 5 សរសេរជាគោលពីរ (Binary) យ៉ាងដូចម្តេច?',
    options: ['101', '110', '111', '100'],
    answer: 0,
    explain: '5 = 4 + 1 = 1×2² + 0×2¹ + 1×2⁰ = 101',
  },
  {
    question: 'តើ 1 Byte ស្មើនឹងប៉ុន្មាន Bit?',
    options: ['8', '4', '10', '16'],
    answer: 0,
    explain: '1 Byte = 8 Bits',
  },
  {
    question: 'តើធាតុទីមួយក្នុង Array/List មាន Index ប៉ុន្មាន?',
    code: 'fruits = ["apple", "mango", "banana"]',
    options: ['0', '1', '-1', 'A'],
    answer: 0,
    explain: 'ភាសាភាគច្រើនចាប់ផ្ដើមរាប់ Index ពី 0 ដូច្នេះ fruits[0] គឺ "apple"។',
  },
  {
    question: 'តើសញ្ញាមួយណាប្រើសម្រាប់សរសេរ Comment ក្នុង Python?',
    options: ['#', '//', '<!-- -->', '%%'],
    answer: 0,
    explain: 'ឧទាហរណ៍៖ # នេះជា comment',
  },
  {
    question: 'ក្នុងកម្មវិធី តើពាក្យ "Bug" មានន័យថាអ្វី?',
    options: ['កំហុសក្នុងកម្មវិធី', 'សត្វល្អិតក្នុងកុំព្យូទ័រ', 'កម្មវិធីថ្មី', 'មេរោគកុំព្យូទ័រ'],
    answer: 0,
    explain: 'ការស្វែងរក និងកែ Bug ហៅថា Debugging។',
  },
  {
    question: 'តើ Git ជាអ្វី?',
    options: ['ប្រព័ន្ធគ្រប់គ្រងកំណែកូដ', 'ភាសាសរសេរកម្មវិធី', 'កម្មវិធីរុករកអ៊ីនធឺណិត', 'ប្រព័ន្ធប្រតិបត្តិការ'],
    answer: 0,
    explain: 'Git កត់ត្រារាល់ការផ្លាស់ប្ដូរកូដ ហើយជួយឱ្យក្រុមធ្វើការរួមគ្នា។',
  },
  {
    question: 'តើភាសាមួយណាដំណើរការផ្ទាល់ក្នុង Web Browser?',
    options: ['JavaScript', 'Python', 'C++', 'Java'],
    answer: 0,
    explain: 'Browser គ្រប់មួយមាន JavaScript Engine ស្រាប់។',
  },
  {
    question: 'តើកូដ Python ខាងក្រោមបង្ហាញអ្វី?',
    code: 'print(10 // 3)',
    options: ['3', '3.33', '1', '4'],
    answer: 0,
    explain: '// ជាការចែកយកតែផលចែកគត់។',
  },
  {
    question: 'តើកូដ Python ខាងក្រោមបង្ហាញអ្វី?',
    code: 'print(10 % 3)',
    options: ['1', '3', '0', '3.33'],
    answer: 0,
    explain: '% ផ្ដល់សំណល់នៃការចែក៖ 10 = 3×3 + 1',
  },
  {
    question: 'តើ HTTP Status Code 404 មានន័យថាអ្វី?',
    options: ['រកទំព័រមិនឃើញ', 'ជោគជ័យ', 'Server មានបញ្ហា', 'មិនមានសិទ្ធិចូល'],
    answer: 0,
    explain: '404 Not Found, 200 OK, 500 Server Error, 403 Forbidden',
  },
  {
    question: 'តើលទ្ធផលនៃកន្សោម Logic ខាងក្រោមជាអ្វី?',
    code: 'True and False',
    options: ['False', 'True', 'None', 'Error'],
    answer: 0,
    explain: 'and ផ្ដល់ True លុះត្រាតែទាំងពីរជា True។',
  },
  {
    question: 'តើតម្លៃ "123" ក្នុង Python ជាប្រភេទទិន្នន័យអ្វី?',
    code: 'x = "123"',
    options: ['str', 'int', 'float', 'bool'],
    answer: 0,
    explain: 'អ្វីក្នុងសញ្ញា " " គឺជា String (str)។',
  },
  {
    question: 'តើ CSS Property មួយណាប្ដូរពណ៌អក្សរ?',
    options: ['color', 'background', 'font-color', 'text-style'],
    answer: 0,
    explain: 'ឧទាហរណ៍៖ p { color: red; }',
  },
  {
    question: 'តើពាក្យបញ្ជា SQL មួយណាប្រើទាញយកទិន្នន័យ?',
    options: ['SELECT', 'GET', 'FETCH', 'OPEN'],
    answer: 0,
    explain: 'ឧទាហរណ៍៖ SELECT * FROM students;',
  },
  {
    question: 'តើ AI មកពីពាក្យអ្វី?',
    options: ['Artificial Intelligence', 'Automatic Internet', 'Advanced Input', 'Apple Intelligence'],
    answer: 0,
    explain: 'AI គឺបញ្ញាសិប្បនិម្មិត។',
  },
  {
    question: 'តើ x មានតម្លៃប៉ុន្មាន?',
    code: 'let x = 5;\nx += 2;',
    options: ['7', '5', '52', '10'],
    answer: 0,
    explain: 'x += 2 ដូចគ្នានឹង x = x + 2',
  },
  {
    question: 'តើកូដ Python ខាងក្រោមបង្ហាញអ្វី?',
    code: 'nums = [1, 2, 3]\nprint(nums[-1])',
    options: ['3', '1', '-1', 'Error'],
    answer: 0,
    explain: 'Index -1 គឺធាតុចុងក្រោយនៃ List។',
  },
  {
    question: 'តើ Loop នេះបង្ហាញលេខប៉ុន្មានដង?',
    code: 'for i in range(5):\n    print(i)',
    options: ['5 ដង', '4 ដង', '6 ដង', '1 ដង'],
    answer: 0,
    explain: 'range(5) ផ្ដល់ 0, 1, 2, 3, 4 គឺ ៥ លេខ។',
  },
  {
    question: 'តើនរណាជាអ្នកបង្កើតភាសា Python?',
    options: ['Guido van Rossum', 'Bill Gates', 'Mark Zuckerberg', 'Elon Musk'],
    answer: 0,
    explain: 'Python ចេញផ្សាយដំបូងក្នុងឆ្នាំ ១៩៩១។',
  },
];

const CULTURE_CARDS: BoothCard[] = [
  {
    question: 'តើប្រាសាទអង្គរវត្តត្រូវបានកសាងក្នុងរជ្ជកាលព្រះមហាក្សត្រអង្គណា?',
    options: ['ព្រះបាទសូរ្យវរ្ម័នទី២', 'ព្រះបាទជ័យវរ្ម័នទី៧', 'ព្រះបាទជ័យវរ្ម័នទី២', 'ព្រះបាទយសោវរ្ម័នទី១'],
    answer: 0,
    explain: 'អង្គរវត្តកសាងក្នុងសតវត្សរ៍ទី១២។',
  },
  {
    question: 'តើប្រាសាទបាយ័នកសាងដោយព្រះមហាក្សត្រអង្គណា?',
    options: ['ព្រះបាទជ័យវរ្ម័នទី៧', 'ព្រះបាទសូរ្យវរ្ម័នទី២', 'ព្រះបាទឥន្ទ្រវរ្ម័នទី១', 'ព្រះបាទរាជេន្ទ្រវរ្ម័ន'],
    answer: 0,
    explain: 'បាយ័នស្ថិតនៅកណ្ដាលក្រុងអង្គរធំ។',
  },
  {
    question: 'តើកម្ពុជាទទួលបានឯករាជ្យពីបារាំងនៅថ្ងៃណា?',
    options: ['៩ វិច្ឆិកា ១៩៥៣', '៧ មករា ១៩៧៩', '២៣ តុលា ១៩៩១', '២៤ កញ្ញា ១៩៩៣'],
    answer: 0,
    explain: 'ថ្ងៃ៩ វិច្ឆិកា ជាទិវាបុណ្យឯករាជ្យជាតិ។',
  },
  {
    question: 'តើរដ្ឋធម្មនុញ្ញនៃព្រះរាជាណាចក្រកម្ពុជាបច្ចុប្បន្នត្រូវបានប្រកាសឱ្យប្រើនៅឆ្នាំណា?',
    options: ['១៩៩៣', '១៩៤៧', '១៩៥៣', '១៩៩៨'],
    answer: 0,
    explain: 'ថ្ងៃ២៤ កញ្ញា ជាទិវាប្រកាសរដ្ឋធម្មនុញ្ញ។',
  },
  {
    question: 'តើកិច្ចព្រមព្រៀងសន្តិភាពទីក្រុងប៉ារីសត្រូវបានចុះហត្ថលេខានៅឆ្នាំណា?',
    options: ['១៩៩១', '១៩៩៣', '១៩៧៩', '១៩៨៩'],
    answer: 0,
    explain: 'ចុះហត្ថលេខានៅថ្ងៃ២៣ តុលា ១៩៩១។',
  },
  {
    question: 'តើកម្ពុជាចូលជាសមាជិកអាស៊ាន (ASEAN) នៅឆ្នាំណា?',
    options: ['១៩៩៩', '១៩៩៥', '១៩៩៧', '២០០២'],
    answer: 0,
    explain: 'កម្ពុជាជាសមាជិកទី១០ នៃអាស៊ាន។',
  },
  {
    question: 'តើបឹងទឹកសាបធំជាងគេនៅអាស៊ីអាគ្នេយ៍មានឈ្មោះអ្វី?',
    options: ['បឹងទន្លេសាប', 'បឹងយក្សឡោម', 'បឹងកន្សែង', 'បឹងតាមោក'],
    answer: 0,
    explain: 'ទន្លេសាបហូរបញ្ច្រាសទិសក្នុងរដូវវស្សា។',
  },
  {
    question: 'តើភ្នំខ្ពស់ជាងគេនៅកម្ពុជាមានឈ្មោះអ្វី?',
    options: ['ភ្នំឱរ៉ាល់', 'ភ្នំគូលែន', 'ភ្នំបូកគោ', 'ភ្នំដងរែក'],
    answer: 0,
    explain: 'ភ្នំឱរ៉ាល់មានកម្ពស់ប្រមាណ ១៨១៣ ម៉ែត្រ។',
  },
  {
    question: 'តើកម្ពុជាមានរាជធានី និងខេត្តសរុបចំនួនប៉ុន្មាន?',
    options: ['២៥', '២៤', '២៣', '២០'],
    answer: 0,
    explain: 'រាជធានីភ្នំពេញ ១ និងខេត្ត ២៤។',
  },
  {
    question: 'តើខេត្តណាជាខេត្តបង្កើតថ្មីចុងក្រោយគេ (ឆ្នាំ២០១៣)?',
    options: ['ខេត្តត្បូងឃ្មុំ', 'ខេត្តប៉ៃលិន', 'ខេត្តកែប', 'ខេត្តឧត្តរមានជ័យ'],
    answer: 0,
    explain: 'ត្បូងឃ្មុំត្រូវបានកាត់ចេញពីខេត្តកំពង់ចាម។',
  },
  {
    question: 'តើរូបិយប័ណ្ណជាតិកម្ពុជាមានឈ្មោះអ្វី?',
    options: ['រៀល', 'បាត', 'គីប', 'ដុង'],
    answer: 0,
    explain: 'ចេញផ្សាយដោយធនាគារជាតិនៃកម្ពុជា។',
  },
  {
    question: 'តើភ្លេងជាតិកម្ពុជាមានឈ្មោះអ្វី?',
    options: ['នគររាជ', 'ដួងចិត្តខ្មែរ', 'មហាលាភ', 'សាធុការ'],
    answer: 0,
    explain: 'ភ្លេងជាតិ «នគររាជ»។',
  },
  {
    question: 'តើរូបអ្វីនៅកណ្ដាលទង់ជាតិកម្ពុជា?',
    options: ['ប្រាសាទអង្គរវត្ត', 'ប្រាសាទបាយ័ន', 'ដំរីស', 'ផ្កាឈូក'],
    answer: 0,
    explain: 'ទង់ជាតិមានពណ៌ខៀវ ក្រហម និងប្រាសាទពណ៌ស។',
  },
  {
    question: 'តើផ្កាជាតិរបស់កម្ពុជាគឺផ្កាអ្វី?',
    options: ['ផ្ការំដួល', 'ផ្កាឈូក', 'ផ្កាម្លិះ', 'ផ្កាចំប៉ា'],
    answer: 0,
    explain: 'ផ្ការំដួលមានក្លិនក្រអូបពេលល្ងាច។',
  },
  {
    question: 'តើដើមឈើជាតិរបស់កម្ពុជាគឺដើមអ្វី?',
    options: ['ដើមត្នោត', 'ដើមដូង', 'ដើមពោធិ៍', 'ដើមគគីរ'],
    answer: 0,
    explain: 'ត្នោតជានិមិត្តរូបនៃជនបទខ្មែរ។',
  },
  {
    question: 'តើសត្វជាតិរបស់កម្ពុជាគឺសត្វអ្វី?',
    options: ['គោព្រៃ', 'ដំរី', 'ខ្លាធំ', 'ក្របី'],
    answer: 0,
    explain: 'គោព្រៃ (Kouprey) ជាសត្វកម្រ។',
  },
  {
    question: 'តើរមណីយដ្ឋានអង្គរត្រូវបានចុះបញ្ជីបេតិកភណ្ឌពិភពលោក UNESCO នៅឆ្នាំណា?',
    options: ['១៩៩២', '២០០៨', '២០១៧', '២០២៣'],
    answer: 0,
    explain: 'ជាតំបន់បេតិកភណ្ឌពិភពលោកដំបូងគេរបស់កម្ពុជា។',
  },
  {
    question: 'តើប្រាសាទព្រះវិហារត្រូវបានចុះបញ្ជីបេតិកភណ្ឌពិភពលោកនៅឆ្នាំណា?',
    options: ['២០០៨', '១៩៩២', '២០១៧', '២០២៣'],
    answer: 0,
    explain: 'ប្រាសាទព្រះវិហារស្ថិតលើជួរភ្នំដងរែក។',
  },
  {
    question: 'តើប្រាសាទសំបូរព្រៃគុកស្ថិតនៅខេត្តណា?',
    options: ['ខេត្តកំពង់ធំ', 'ខេត្តសៀមរាប', 'ខេត្តព្រះវិហារ', 'ខេត្តតាកែវ'],
    answer: 0,
    explain: 'ចុះបញ្ជីបេតិកភណ្ឌពិភពលោកឆ្នាំ២០១៧ ជារាជធានីសម័យចេនឡា។',
  },
  {
    question: 'តើរបាំព្រះរាជទ្រព្យត្រូវបាន UNESCO ទទួលស្គាល់ជាបេតិកភណ្ឌអរូបីនៅឆ្នាំណា?',
    options: ['២០០៣', '២០០៥', '២០១៨', '១៩៩២'],
    answer: 0,
    explain: 'ល្ខោនស្បែកធំទទួលស្គាល់នៅឆ្នាំ២០០៥។',
  },
  {
    question: 'តើព្រះបាទជ័យវរ្ម័នទី២ ប្រកាសលទ្ធិទេវរាជនៅទីណា?',
    options: ['ភ្នំគូលែន', 'ភ្នំបាខែង', 'ភ្នំជីសូរ', 'ភ្នំដា'],
    answer: 0,
    explain: 'ក្នុងឆ្នាំ ៨០២ ជាការចាប់ផ្ដើមសម័យអង្គរ។',
  },
  {
    question: 'តើពិធីបុណ្យអុំទូក បណ្ដែតប្រទីប និងសំពះព្រះខែ ប្រារព្ធក្នុងខែណា?',
    options: ['ខែកត្តិក', 'ខែមេសា', 'ខែភទ្របទ', 'ខែពិសាខ'],
    answer: 0,
    explain: 'ប្រារព្ធនៅថ្ងៃពេញបូណ៌មីខែកត្តិក។',
  },
  {
    question: 'តើបុណ្យភ្ជុំបិណ្ឌប្រារព្ធក្នុងខែណានៃច័ន្ទគតិ?',
    options: ['ខែភទ្របទ', 'ខែកត្តិក', 'ខែចេត្រ', 'ខែមាឃ'],
    answer: 0,
    explain: 'រយៈពេល ១៥ថ្ងៃ ដើម្បីឧទ្ទិសកុសលដល់ដូនតា។',
  },
  {
    question: 'តើអក្សរខ្មែរមានព្យញ្ជនៈចំនួនប៉ុន្មានតួ?',
    options: ['៣៣', '៣២', '៣៥', '២៦'],
    answer: 0,
    explain: 'ចាប់ពី ក រហូតដល់ អ។',
  },
  {
    question: 'តើប្រទេសកម្ពុជាធ្វើជាម្ចាស់ផ្ទះស៊ីហ្គេមលើកទី៣២ នៅឆ្នាំណា?',
    options: ['២០២៣', '២០២១', '២០១៩', '២០២៥'],
    answer: 0,
    explain: 'ជាលើកដំបូងដែលកម្ពុជារៀបចំស៊ីហ្គេម។',
  },
];

export const BOOTH_DECKS: BoothDeck[] = [
  {
    id: 'coding',
    titleKm: 'កូដ & បច្ចេកវិទ្យា',
    titleEn: 'Coding',
    subtitleKm: 'HTML, CSS, JavaScript, Python',
    cards: [...CODING_CARDS, ...CODING_EXTRA_CARDS],
  },
  {
    id: 'culture',
    titleKm: 'វប្បធម៌ទូទៅ',
    titleEn: 'General Culture',
    subtitleKm: 'ប្រវត្តិសាស្ត្រ ភូមិសាស្ត្រ និងបេតិកភណ្ឌខ្មែរ',
    cards: [...CULTURE_CARDS, ...CULTURE_EXTRA_CARDS],
  },
  {
    id: 'datascience',
    titleKm: 'Data Science',
    titleEn: 'Data Science',
    subtitleKm: 'ស្ថិតិ pandas NumPy និង Machine Learning',
    cards: DATA_SCIENCE_CARDS,
  },
  {
    id: 'ccna',
    titleKm: 'CCNA 1 បណ្ដាញ',
    titleEn: 'CCNA 1 Networking',
    subtitleKm: 'OSI, IP Address, Subnet និង Cisco IOS',
    cards: CCNA_CARDS,
  },
];
