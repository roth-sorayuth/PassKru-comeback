/**
 * The same subject is stored under several names ("Math", "Mathematics",
 * "គណិតវិទ្យា"). This maps any of them to one canonical name so lists can merge
 * them. Keep in step with mapSubjectName in server/src/services/quizService.js and
 * client/src/utils/subjectNames.ts,
 * which the API uses to match papers to a canonical name.
 */
export function canonicalSubjectName(name?: string | null): string {
  if (!name) return '';
  const s = name.toLowerCase().trim();
  if (
    s.includes('general') || s.includes('culture') || s.includes('knowledge') ||
    s.includes('វប្បធម៌') || s.includes('ចំណេះដឹង') || s === 'gk'
  ) return 'General Knowledge';
  if (s.includes('english') || s.includes('អង់គ្លេស') || s === 'eng') return 'English';
  if (s.includes('math') || s.includes('គណិត')) return 'Mathematics';
  if (s.includes('phys') || s.includes('រូប')) return 'Physics';
  if (s.includes('chem') || s.includes('គីមី')) return 'Chemistry';
  if (s.includes('bio') || s.includes('ជីវ')) return 'Biology';
  if (s.includes('hist') || s.includes('ប្រវត្តិ')) return 'History';
  if (s.includes('geo') || s.includes('ភូមិ')) return 'Geography';
  if (s.includes('khmer') || s.includes('ខ្មែរ')) return 'Khmer Literature';
  if (s.includes('civic') || s.includes('moral') || s.includes('សីលធម៌') || s.includes('ពលរដ្ឋ')) return 'Civics & Ethics';
  return name.trim();
}
