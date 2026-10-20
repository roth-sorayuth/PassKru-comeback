import { api } from './api';

/**
 * File uploads go through the API: it checks the admin session, file type and
 * size, picks the storage path and returns a one-time signed upload URL. The
 * dashboard never holds a Supabase key, so the buckets can refuse anon writes.
 */
type UploadKind = 'paper' | 'announcement-doc' | 'mentor-image';

interface SignedUpload {
  uploadUrl: string;
  publicUrl: string;
  fileSize: string;
  contentType: string;
}

async function uploadFile(kind: UploadKind, file: File): Promise<{ publicUrl: string; fileSize: string }> {
  const { upload } = await api.post<{ upload: SignedUpload }>('/uploads/sign', {
    kind,
    contentType: file.type,
    size: file.size,
  });

  const res = await fetch(upload.uploadUrl, {
    method: 'PUT',
    headers: {
      'Content-Type': upload.contentType,
      'Cache-Control': 'max-age=3600',
      'x-upsert': 'false',
    },
    body: file,
  });

  if (!res.ok) {
    let detail = '';
    try {
      const body = await res.json();
      detail = body?.message || body?.error || '';
    } catch {
      // Non-JSON error body; the status is enough.
    }
    throw new Error(`Upload failed (${res.status})${detail ? `: ${detail}` : ''}`);
  }

  return { publicUrl: upload.publicUrl, fileSize: upload.fileSize };
}

/** Upload a past-paper PDF. Returns the link to save on the paper. */
export const uploadPaperToStorage = (file: File) => uploadFile('paper', file);

/** Upload an announcement PDF attachment. */
export const uploadAnnouncementToStorage = (file: File) => uploadFile('announcement-doc', file);

/** Upload a mentor avatar image. */
export async function uploadMentorImageToStorage(file: File): Promise<{ publicUrl: string }> {
  if (!file.type.startsWith('image/')) {
    throw new Error('រូបភាពត្រូវតែជាប្រភេទ File រូបភាព (JPG, PNG, WebP, GIF)');
  }
  if (file.size > 5 * 1024 * 1024) {
    throw new Error(`ទំហំរូបភាពគឺ ${(file.size / (1024 * 1024)).toFixed(1)} MB — សូមជ្រើសរើសរូបភាពក្រោម 5 MB។`);
  }
  const { publicUrl } = await uploadFile('mentor-image', file);
  return { publicUrl };
}
