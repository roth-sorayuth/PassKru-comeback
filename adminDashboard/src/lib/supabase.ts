import { createClient } from '@supabase/supabase-js';

const rawSupabaseUrl = (import.meta.env.VITE_SUPABASE_URL || '').trim();
// Strip accidental PostgREST path suffix (/rest/v1) and trailing slashes
const supabaseUrl = rawSupabaseUrl.replace(/\/rest\/v1\/?$/i, '').replace(/\/+$/, '');
const supabaseAnonKey = (import.meta.env.VITE_SUPABASE_ANON_KEY || '').trim();

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn(
    '[adminDashboard] Supabase env vars are missing. Set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in .env'
  );
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

/**
 * Upload a file to the "papers" Supabase Storage bucket.
 * Returns the public URL on success.
 */
export async function uploadPaperToStorage(file: File): Promise<{ publicUrl: string; fileSize: string }> {
  const ext = file.name.split('.').pop() ?? 'pdf';
  const fileName = `${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;
  const filePath = `past-papers/${fileName}`;

  const { error } = await supabase.storage.from('papers').upload(filePath, file, {
    cacheControl: '3600',
    upsert: false,
    contentType: file.type || 'application/pdf',
  });

  if (error) {
    throw new Error(`Supabase upload failed: ${error.message}`);
  }

  const { data } = supabase.storage.from('papers').getPublicUrl(filePath);
  const fileSize = `${(file.size / (1024 * 1024)).toFixed(2)} MB`;

  return { publicUrl: data.publicUrl, fileSize };
}

/**
 * Upload a file to the "announcement" Supabase Storage bucket.
 * Returns the public URL on success.
 */
export async function uploadAnnouncementToStorage(file: File): Promise<{ publicUrl: string; fileSize: string }> {
  const ext = file.name.split('.').pop() ?? 'pdf';
  const fileName = `${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;
  const filePath = `documents/${fileName}`;

  let bucketName = 'announcement';
  let res = await supabase.storage.from(bucketName).upload(filePath, file, {
    cacheControl: '3600',
    upsert: false,
    contentType: file.type || 'application/pdf',
  });

  if (res.error && res.error.message.includes('Bucket not found')) {
    bucketName = 'Announcement';
    res = await supabase.storage.from(bucketName).upload(filePath, file, {
      cacheControl: '3600',
      upsert: false,
      contentType: file.type || 'application/pdf',
    });
  }

  if (res.error) {
    throw new Error(`Supabase announcement upload failed: ${res.error.message}`);
  }

  const { data } = supabase.storage.from(bucketName).getPublicUrl(filePath);
  const fileSize = `${(file.size / (1024 * 1024)).toFixed(2)} MB`;

  return { publicUrl: data.publicUrl, fileSize };
}

/** Images an announcement is displayed with, kept apart from its documents. */
const MAX_IMAGE_BYTES = 5 * 1024 * 1024;

export async function uploadAnnouncementImageToStorage(file: File): Promise<{ publicUrl: string }> {
  if (!file.type.startsWith('image/')) {
    throw new Error('Thumbnail must be an image file (JPG, PNG, WebP, or GIF).');
  }
  if (file.size > MAX_IMAGE_BYTES) {
    throw new Error(`Image is ${(file.size / (1024 * 1024)).toFixed(1)} MB — please use one under 5 MB.`);
  }

  const ext = file.name.split('.').pop() ?? 'jpg';
  const fileName = `${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;
  const filePath = `thumbnails/${fileName}`;

  let bucketName = 'announcement';
  let res = await supabase.storage.from(bucketName).upload(filePath, file, {
    cacheControl: '3600',
    upsert: false,
    contentType: file.type,
  });

  if (res.error && res.error.message.includes('Bucket not found')) {
    bucketName = 'Announcement';
    res = await supabase.storage.from(bucketName).upload(filePath, file, {
      cacheControl: '3600',
      upsert: false,
      contentType: file.type,
    });
  }

  if (res.error) {
    throw new Error(`Supabase image upload failed: ${res.error.message}`);
  }

  const { data } = supabase.storage.from(bucketName).getPublicUrl(filePath);
  return { publicUrl: data.publicUrl };
}

/**
 * Upload a mentor avatar image to the "announcement" Supabase Storage bucket.
 * Returns the public URL on success.
 */
export async function uploadMentorImageToStorage(file: File): Promise<{ publicUrl: string }> {
  if (!file.type.startsWith('image/')) {
    throw new Error('រូបភាពត្រូវតែជាប្រភេទ File រូបភាព (JPG, PNG, WebP, GIF)');
  }
  if (file.size > 5 * 1024 * 1024) {
    throw new Error(`ទំហំរូបភាពគឺ ${(file.size / (1024 * 1024)).toFixed(1)} MB — សូមជ្រើសរើសរូបភាពក្រោម 5 MB។`);
  }

  const ext = file.name.split('.').pop() ?? 'jpg';
  const fileName = `${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;
  const filePath = `mentors/${fileName}`;

  let bucketName = 'announcement';
  let res = await supabase.storage.from(bucketName).upload(filePath, file, {
    cacheControl: '3600',
    upsert: false,
    contentType: file.type,
  });

  if (res.error && res.error.message.includes('Bucket not found')) {
    bucketName = 'Announcement';
    res = await supabase.storage.from(bucketName).upload(filePath, file, {
      cacheControl: '3600',
      upsert: false,
      contentType: file.type,
    });
  }

  if (res.error) {
    throw new Error(`Supabase mentor image upload failed: ${res.error.message}`);
  }

  const { data } = supabase.storage.from(bucketName).getPublicUrl(filePath);
  return { publicUrl: data.publicUrl };
}


