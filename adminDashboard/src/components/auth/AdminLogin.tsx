import React, { useState } from 'react';
import { Loader2 } from 'lucide-react';
import { api } from '../../lib/api';

interface AdminUser {
  role: string;
  [key: string]: unknown;
}

interface Props {
  /** Called with the signed-in admin once the emailed code is accepted. */
  onSuccess: (user: AdminUser) => void;
}

const inputClass =
  'w-full px-3 py-2.5 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]';

/**
 * Admin sign-in: password, then the 6-digit code emailed to the account.
 * Admins can't use Google sign-in (the server refuses it, because it has no
 * second step), so this is the only way into the dashboard.
 */
export const AdminLogin: React.FC<Props> = ({ onSuccess }) => {
  const [step, setStep] = useState<'password' | 'code'>('password');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [code, setCode] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const submitPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    if (busy) return;
    setBusy(true);
    setError(null);
    try {
      const res = await api.post<{ requiresLoginOtp?: boolean; message?: string; token?: string; user?: AdminUser }>('/auth/login', {
        email: email.trim(),
        password,
      });
      if (res?.requiresLoginOtp) {
        setNotice(res.message || null);
        setStep('code');
      } else {
        // Sign-in codes switched off for this account: a session was already issued.
        await finish(res);
      }
    } catch (err: any) {
      setError(err?.message || 'មិនអាចចូលប្រើបានទេ');
    } finally {
      setBusy(false);
    }
  };

  const submitCode = async (e: React.FormEvent) => {
    e.preventDefault();
    if (busy) return;
    if (!/^\d{6}$/.test(code.trim())) {
      setError('សូមបញ្ចូលលេខកូដ ៦ តួអក្សរឲ្យគ្រប់');
      return;
    }
    setBusy(true);
    setError(null);
    try {
      const res = await api.post<{ token?: string; user?: AdminUser }>('/auth/login/verify-otp', {
        email: email.trim(),
        otp: code.trim(),
      });
      await finish(res);
    } catch (err: any) {
      setError(err?.message || 'លេខកូដមិនត្រឹមត្រូវ');
    } finally {
      setBusy(false);
    }
  };

  const finish = async (res: { token?: string; user?: AdminUser }) => {
    if (res?.token) localStorage.setItem('token', res.token);
    if (res?.user?.role === 'admin') {
      onSuccess(res.user);
      return;
    }
    // A valid account that isn't an admin: end the session just created.
    await api.post('/auth/logout').catch(() => {});
    localStorage.removeItem('token');
    setStep('password');
    setPassword('');
    setCode('');
    setError('គណនីរបស់អ្នកមិនមានសិទ្ធិជាអ្នកគ្រប់គ្រងប្រព័ន្ធ PassKru ឡើយ។');
  };

  return (
    <div className="min-h-screen bg-[#f8fafc] flex flex-col items-center justify-center p-6">
      <div className="max-w-md w-full bg-white border border-slate-200 rounded-3xl p-8 shadow-sm space-y-6">
        <div className="text-center space-y-3">
          <div className="w-16 h-16 rounded-2xl bg-[#eef4fc] border border-[#dbe6f5] flex items-center justify-center mx-auto shadow-xs">
            <img src="/PassKru-logo.svg" alt="PassKru Logo" className="w-10 h-10 object-contain" />
          </div>
          <div className="space-y-1">
            <h1 className="text-2xl font-black text-[#0f3360]">PassKru Admin</h1>
            <p className="text-xs text-slate-500">
              សូមចូលប្រើប្រាស់ដោយប្រើគណនីអ្នកគ្រប់គ្រងដែលមានការអនុញ្ញាតដើម្បីគ្រប់គ្រងការប្រឡង និងវិញ្ញាសា
            </p>
          </div>
        </div>

        {error && (
          <div role="alert" className="text-xs text-rose-700 bg-rose-50 border border-rose-200 rounded-xl px-3 py-2">
            {error}
          </div>
        )}

        {step === 'password' ? (
          <form onSubmit={submitPassword} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1" htmlFor="admin-email">
                អាសយដ្ឋានអ៊ីមែល
              </label>
              <input
                id="admin-email"
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className={inputClass}
              />
            </div>
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1" htmlFor="admin-password">
                ពាក្យសម្ងាត់
              </label>
              <input
                id="admin-password"
                type="password"
                required
                autoComplete="current-password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className={inputClass}
              />
            </div>
            <button
              type="submit"
              disabled={busy}
              className="inline-flex items-center justify-center gap-2 w-full py-3 bg-[#0a3263] hover:bg-[#0f3360] disabled:opacity-60 text-white font-bold text-sm rounded-xl shadow-md transition cursor-pointer"
            >
              {busy && <Loader2 className="w-4 h-4 animate-spin" />}
              <span>ចូលប្រើប្រាស់</span>
            </button>
          </form>
        ) : (
          <form onSubmit={submitCode} className="space-y-4">
            <p className="text-xs text-slate-600 leading-relaxed">
              {notice || 'លេខកូដផ្ទៀងផ្ទាត់ត្រូវបានផ្ញើទៅកាន់អ៊ីមែលរបស់អ្នក!'}
            </p>
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1" htmlFor="admin-code">
                លេខកូដ ៦ តួអក្សរ
              </label>
              <input
                id="admin-code"
                inputMode="numeric"
                autoComplete="one-time-code"
                maxLength={6}
                required
                value={code}
                onChange={(e) => setCode(e.target.value.replace(/\D/g, ''))}
                className={`${inputClass} tracking-[0.5em] text-center text-lg font-bold`}
              />
            </div>
            <button
              type="submit"
              disabled={busy}
              className="inline-flex items-center justify-center gap-2 w-full py-3 bg-[#0a3263] hover:bg-[#0f3360] disabled:opacity-60 text-white font-bold text-sm rounded-xl shadow-md transition cursor-pointer"
            >
              {busy && <Loader2 className="w-4 h-4 animate-spin" />}
              <span>ចូលប្រើប្រាស់</span>
            </button>
            <button
              type="button"
              onClick={() => {
                setStep('password');
                setCode('');
                setError(null);
              }}
              className="w-full text-xs text-slate-500 hover:text-slate-700 cursor-pointer"
            >
              ថយក្រោយ
            </button>
          </form>
        )}
      </div>
    </div>
  );
};
