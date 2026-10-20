/**
 * Catches common email-domain typos ("gmaili.com", "gmial.com", "yahooo.com")
 * so the sign-up form can offer the fix before a verification code is sent to
 * an address that doesn't exist.
 */
const COMMON_DOMAINS = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'icloud.com'];

/** Levenshtein distance, capped: we only care whether two short domains are 1-2 edits apart. */
function editDistance(a: string, b: string): number {
  const prev = Array.from({ length: b.length + 1 }, (_, i) => i);
  for (let i = 1; i <= a.length; i++) {
    let diag = prev[0];
    prev[0] = i;
    for (let j = 1; j <= b.length; j++) {
      const up = prev[j];
      prev[j] = Math.min(prev[j] + 1, prev[j - 1] + 1, diag + (a[i - 1] === b[j - 1] ? 0 : 1));
      diag = up;
    }
  }
  return prev[b.length];
}

/** The corrected address when the domain looks like a typo of a common one, else null. */
export function suggestEmail(email: string): string | null {
  const at = email.trim().lastIndexOf('@');
  if (at < 1) return null;
  const local = email.trim().slice(0, at);
  const domain = email.trim().slice(at + 1).toLowerCase();
  if (!domain || COMMON_DOMAINS.includes(domain)) return null;

  let best: string | null = null;
  let bestDistance = Infinity;
  for (const candidate of COMMON_DOMAINS) {
    const d = editDistance(domain, candidate);
    if (d < bestDistance) {
      bestDistance = d;
      best = candidate;
    }
  }
  // 1-2 edits covers gmaili / gmial / gmal / gnail / yahooo; anything further is
  // probably a real (e.g. school or company) domain.
  return best && bestDistance <= 2 ? `${local}@${best}` : null;
}
