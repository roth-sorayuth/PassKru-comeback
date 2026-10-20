import { randomUUID } from "node:crypto";

/**
 * Turns stored Supabase Storage links into short-lived signed URLs.
 *
 * past_paper.file_url keeps whatever the admin dashboard saved — usually a
 * public link (/storage/v1/object/public/<bucket>/<path>), sometimes an old
 * long-lived signed one (/object/sign/...). Either way we re-sign the object on
 * every read, so the bucket can be private and no link outlives SIGNED_URL_TTL.
 *
 * Needs SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY (server-side only, never in a
 * frontend env). Without them URLs are returned unchanged, which keeps working
 * only while the bucket is still public.
 */

export const SIGNED_URL_TTL_SECONDS = 60 * 60;

const OBJECT_PATH = /^\/storage\/v1\/object\/(?:public|sign|authenticated)\/([^/]+)\/(.+)$/;

function config() {
  const url = process.env.SUPABASE_URL?.trim().replace(/\/+$/, "");
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
  return url && key ? { url, key } : null;
}

/** { bucket, path } for a link into our Supabase project, else null. */
function parseStorageUrl(fileUrl, supabaseUrl) {
  if (typeof fileUrl !== "string" || !fileUrl) return null;
  let parsed;
  try {
    parsed = new URL(fileUrl);
  } catch {
    return null;
  }
  if (parsed.origin !== new URL(supabaseUrl).origin) return null;
  const match = parsed.pathname.match(OBJECT_PATH);
  if (!match) return null;
  try {
    return { bucket: decodeURIComponent(match[1]), path: decodeURIComponent(match[2]) };
  } catch {
    return null;
  }
}

async function signBatch({ url, key }, bucket, paths) {
  const res = await fetch(`${url}/storage/v1/object/sign/${encodeURIComponent(bucket)}`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${key}`,
      apikey: key,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ expiresIn: SIGNED_URL_TTL_SECONDS, paths }),
  });
  if (!res.ok) {
    throw new Error(`Supabase sign failed (${res.status}): ${await res.text()}`);
  }
  const results = await res.json();
  const signed = new Map();
  for (const item of results) {
    if (item?.signedURL && !item.error) signed.set(item.path, `${url}/storage/v1${item.signedURL}`);
  }
  return signed;
}

/**
 * Returns copies of `records` with `field` replaced by a fresh signed URL.
 * Records whose URL can't be signed keep their stored value.
 */
export async function withSignedUrls(records, field = "fileUrl") {
  const cfg = config();
  if (!cfg || !records?.length) return records;

  const byBucket = new Map();
  const targets = records.map((record) => {
    const target = parseStorageUrl(record?.[field], cfg.url);
    if (target) {
      if (!byBucket.has(target.bucket)) byBucket.set(target.bucket, new Set());
      byBucket.get(target.bucket).add(target.path);
    }
    return target;
  });
  if (!byBucket.size) return records;

  const signedByBucket = new Map();
  await Promise.all(
    [...byBucket].map(async ([bucket, paths]) => {
      try {
        signedByBucket.set(bucket, await signBatch(cfg, bucket, [...paths]));
      } catch (error) {
        console.error(`[storage] Could not sign URLs in bucket "${bucket}":`, error?.message || error);
      }
    })
  );

  return records.map((record, i) => {
    const target = targets[i];
    const signed = target && signedByBucket.get(target.bucket)?.get(target.path);
    return signed ? { ...record, [field]: signed } : record;
  });
}

export async function withSignedUrl(record, field = "fileUrl") {
  const [signed] = await withSignedUrls([record], field);
  return signed;
}

/**
 * Signs every `fileUrl` found anywhere in a JSON payload. Study plans and
 * activity history keep their own copy of a paper's fileUrl inside plan JSON,
 * so those responses need this rather than the flat paper-list signing.
 */
export async function signFileUrlsDeep(payload) {
  if (!config() || payload == null) return payload;
  // Same shape res.json would produce anyway (Decimals/Dates serialised).
  const copy = JSON.parse(JSON.stringify(payload));
  const holders = [];
  const walk = (node) => {
    if (Array.isArray(node)) return node.forEach(walk);
    if (node && typeof node === "object") {
      if (typeof node.fileUrl === "string") holders.push(node);
      Object.values(node).forEach(walk);
    }
  };
  walk(copy);
  if (!holders.length) return copy;
  const signed = await withSignedUrls(holders);
  holders.forEach((holder, i) => {
    holder.fileUrl = signed[i].fileUrl;
  });
  return copy;
}

// ---------------------------------------------------------------------------
// Uploads
//
// The admin dashboard used to upload straight to Storage with the anon key,
// which only worked because the buckets let *anyone* write. Now the API (admin
// only) hands out a one-time signed upload URL for a path it picks itself, so
// the buckets can refuse anon writes entirely.
// ---------------------------------------------------------------------------

const MB = 1024 * 1024;
const IMAGE_TYPES = { "image/png": "png", "image/jpeg": "jpg", "image/webp": "webp", "image/gif": "gif" };

/** What each upload kind may contain and where it lands. No SVG/HTML: they'd run script on the Storage origin. */
export const UPLOAD_KINDS = {
  paper: {
    bucket: () => process.env.SUPABASE_PAPERS_BUCKET || "papers",
    prefix: "past-papers",
    types: { "application/pdf": "pdf" },
    maxBytes: 50 * MB,
  },
  "announcement-doc": {
    bucket: () => process.env.SUPABASE_ANNOUNCEMENT_BUCKET || "announcement",
    prefix: "documents",
    types: { "application/pdf": "pdf" },
    maxBytes: 20 * MB,
  },
  "mentor-image": {
    bucket: () => process.env.SUPABASE_ANNOUNCEMENT_BUCKET || "announcement",
    prefix: "mentors",
    types: IMAGE_TYPES,
    maxBytes: 5 * MB,
  },
};

function uploadError(message, statusCode = 400) {
  const error = new Error(message);
  error.statusCode = statusCode;
  return error;
}

async function requestUploadSign({ url, key }, bucket, objectPath) {
  const res = await fetch(`${url}/storage/v1/object/upload/sign/${encodeURIComponent(bucket)}/${objectPath}`, {
    method: "POST",
    headers: { Authorization: `Bearer ${key}`, apikey: key, "Content-Type": "application/json" },
    body: "{}",
  });
  const text = await res.text();
  return { ok: res.ok, status: res.status, text };
}

/**
 * Validates an upload request and returns a signed URL the browser can PUT the
 * file to once, plus the public-style link to save in the database (papers are
 * re-signed on every read, see withSignedUrls).
 */
export async function createSignedUpload({ kind, contentType, size } = {}) {
  const cfg = config();
  if (!cfg) throw uploadError("File storage is not configured on the server", 503);

  const spec = Object.hasOwn(UPLOAD_KINDS, kind) ? UPLOAD_KINDS[kind] : null;
  if (!spec) throw uploadError(`kind must be one of: ${Object.keys(UPLOAD_KINDS).join(", ")}`);

  const ext = typeof contentType === "string" ? spec.types[contentType.toLowerCase()] : undefined;
  if (!ext) throw uploadError(`File type not allowed. Allowed: ${Object.keys(spec.types).join(", ")}`);

  const bytes = Number(size);
  if (!Number.isInteger(bytes) || bytes <= 0) throw uploadError("size must be the file size in bytes");
  if (bytes > spec.maxBytes) throw uploadError(`File is too large (max ${spec.maxBytes / MB} MB)`);

  const objectPath = `${spec.prefix}/${Date.now()}-${randomUUID()}.${ext}`;

  // Some projects created the announcement bucket as "Announcement".
  const candidates = [spec.bucket()];
  if (candidates[0] === "announcement") candidates.push("Announcement");

  for (const bucket of candidates) {
    const result = await requestUploadSign(cfg, bucket, objectPath);
    if (result.ok) {
      const { url: signedPath } = JSON.parse(result.text);
      const token = new URL(`${cfg.url}/storage/v1${signedPath}`).searchParams.get("token");
      if (!token) break;
      return {
        bucket,
        path: objectPath,
        contentType: contentType.toLowerCase(),
        uploadUrl: `${cfg.url}/storage/v1/object/upload/sign/${encodeURIComponent(bucket)}/${objectPath}?token=${encodeURIComponent(token)}`,
        publicUrl: `${cfg.url}/storage/v1/object/public/${encodeURIComponent(bucket)}/${objectPath}`,
        fileSize: `${(bytes / MB).toFixed(2)} MB`,
      };
    }
    const bucketMissing = /bucket not found/i.test(result.text);
    if (!bucketMissing) {
      console.error(`[storage] Upload sign failed for "${bucket}" (${result.status}):`, result.text);
      break;
    }
  }
  throw uploadError("Could not prepare the upload. Please try again.", 502);
}

/** Express middleware: sign fileUrls in every JSON response of a router. */
export function signFileUrlsInResponses(req, res, next) {
  const send = res.json.bind(res);
  res.json = (body) => {
    signFileUrlsDeep(body)
      .then(send)
      .catch((error) => {
        console.error("[storage] Signing response URLs failed:", error?.message || error);
        send(body);
      });
    return res;
  };
  next();
}
