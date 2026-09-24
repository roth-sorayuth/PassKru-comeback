/**
 * The only user fields that may leave the API. Allow-list, not deny-list, so a
 * column added to the User model later stays private until it is listed here.
 * Never send a Prisma user row to a client without passing it through this.
 */
const PUBLIC_USER_FIELDS = [
  "userId",
  "firstName",
  "lastName",
  "email",
  "phoneNumber",
  "role",
  "avatarUrl",
  "targetExamId",
  "targetSubject",
  "targetSubjects",
  "knowledgeLevel",
  "availableStudyHours",
  "dailyGoalMinutes",
  "streakDays",
  "completedQuestions",
  "averageScore",
  "studyHoursTotal",
  "createdAt",
  "updatedAt",
  "isEmailVerified",
  // Relations / derived fields added by services
  "targetExam",
  "_count",
  "examCategory",
  "selectedSubjects",
  "hasCompletedExamSelection",
];

export function toPublicUser(user) {
  if (!user) return null;
  const out = {};
  for (const key of PUBLIC_USER_FIELDS) {
    if (user[key] !== undefined) out[key] = user[key];
  }
  return out;
}
