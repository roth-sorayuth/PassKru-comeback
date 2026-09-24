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
