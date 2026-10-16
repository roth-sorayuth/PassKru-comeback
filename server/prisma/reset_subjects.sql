-- ====================================================================
-- Script to Reset Subject Table
-- Description:
-- 1. Removes all existing records from the subject table (and cascading records).
-- 2. Resets the ID sequence to 1.
-- 3. Inserts the four standard subjects: Math, Khmer, General Knowledge, Physics.
-- ====================================================================

-- Step 1: Remove all existing subjects and reset sequence
TRUNCATE TABLE "subject" RESTART IDENTITY CASCADE;

-- Step 2: Insert the 4 initial subjects
-- Automatically associates them with your primary exam (or exam_id = 1)
INSERT INTO "subject" ("exam_id", "subject_name", "description")
SELECT 
    COALESCE((SELECT "exam_id" FROM "exam" ORDER BY "exam_id" ASC LIMIT 1), 1),
    s.subject_name,
    s.description
FROM (
    VALUES 
        ('Math', 'Mathematics core concepts and past questions'),
        ('Khmer', 'Khmer literature, grammar, and essay writing'),
        ('General Knowledge', 'General knowledge, civics, culture, and current affairs'),
        ('Physics', 'Physics fundamentals and experiments')
) AS s(subject_name, description);

-- Step 3: Verify the inserted subjects
SELECT "subject_id", "exam_id", "subject_name", "description" FROM "subject" ORDER BY "subject_id" ASC;
