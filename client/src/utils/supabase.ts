import { createClient } from '@supabase/supabase-js';

const rawSupabaseUrl = (import.meta.env.VITE_SUPABASE_URL || '').trim();
const supabaseUrl = rawSupabaseUrl.replace(/\/rest\/v1\/?$/i, '').replace(/\/+$/, '');
const supabaseAnonKey = (import.meta.env.VITE_SUPABASE_ANON_KEY || '').trim();

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
