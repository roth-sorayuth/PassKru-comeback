-- =============================================================================
-- PassKru — Supabase Storage lockdown (SECURITY_FIX_PLAN.md, P0-1)
--
-- FOR A HUMAN TO REVIEW AND RUN BY HAND in the Supabase SQL editor.
-- Agents must not run this (AGENTS.md database policy).
--
-- Order:
--   1. Deploy the API + admin dashboard that use POST /api/uploads/sign, and
--      make sure SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY are set on the API.
--   2. Upload one paper and one mentor image from the admin dashboard — must work.
--   3. Run STEP 1 below and read the output.
--   4. Run STEP 2 (edit the policy names), then STEP 3.
--   5. Repeat the uploads from step 2, open a paper in the learner app, and
--      confirm an anon upload is refused (see STEP 4).
-- =============================================================================


-- STEP 1 — Review. Lists every policy on storage.objects. Look for rows whose
-- cmd is INSERT / UPDATE / DELETE / ALL and whose roles include anon,
-- authenticated or public, and whose qual / with_check mention the 'papers'
-- or 'announcement' bucket (or no bucket at all = every bucket).
select policyname, cmd, roles, qual, with_check
from pg_policies
where schemaname = 'storage' and tablename = 'objects'
order by policyname;


-- STEP 2 — Drop the write policies found in STEP 1. The API signs uploads with
-- the service role key, which bypasses RLS, so no write policy is needed for
-- these buckets. Replace the names below with the real ones; keep any policy
-- that serves a bucket other than these two.
--
-- drop policy "Allow anon uploads to papers"        on storage.objects;
-- drop policy "Allow anon uploads to announcement"  on storage.objects;
-- drop policy "<other write policy name>"           on storage.objects;


-- STEP 3 — Bucket settings.
--  * papers becomes private: learners only get files through the API's
--    short-lived signed links (already in place, see storageService.js).
--  * The size / type limits are enforced by Storage itself, so a client that
--    lies to /api/uploads/sign about its file still can't store anything else.
--    Keep them in step with UPLOAD_KINDS in server/src/services/storageService.js.
--  * announcement stays public (thumbnails, mentor photos, announcement PDFs).
--    SVG and HTML are not allowed: they would run script on the Storage domain.
update storage.buckets
set public = false,
    file_size_limit = 52428800,                      -- 50 MB
    allowed_mime_types = array['application/pdf']
where id = 'papers';

update storage.buckets
set file_size_limit = 20971520,                      -- 20 MB
    allowed_mime_types = array['application/pdf', 'image/png', 'image/jpeg', 'image/webp', 'image/gif']
where id in ('announcement', 'Announcement');

select id, public, file_size_limit, allowed_mime_types from storage.buckets;


-- STEP 4 — Check from a terminal (anon key from the old frontend env). Both
-- must now fail with 400/403 instead of creating a file:
--
--   curl -X POST "https://<project>.supabase.co/storage/v1/object/papers/test.pdf" \
--     -H "apikey: <anon key>" -H "Authorization: Bearer <anon key>" \
--     -H "Content-Type: application/pdf" --data-binary "test"
--
--   curl -X POST "https://<project>.supabase.co/storage/v1/object/announcement/test.html" \
--     -H "apikey: <anon key>" -H "Authorization: Bearer <anon key>" \
--     -H "Content-Type: text/html" --data-binary "<script>alert(1)</script>"
--
-- Optional afterwards: rotate the anon key (Project Settings → API) — it was in
-- both frontend bundles while the buckets accepted anon writes. Nothing in the
-- frontends uses it any more.
