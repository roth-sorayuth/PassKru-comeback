import React, { useState, useRef, useEffect } from 'react';
import { useApp } from '../../context/AppContext';
import { useLanguage } from '../../context/LanguageContext';
import { useAuthContext } from '../../context/AuthContext';
import { ArrowLeft, Mail, Lock, User, Phone, AlertCircle, CheckCircle2, Loader2, ShieldCheck, RefreshCw } from 'lucide-react';
import { LoginButton } from '../auth/LoginButton';

const getApiBaseUrl = () => {
  if (import.meta.env.VITE_API_URL) return import.meta.env.VITE_API_URL;
  if (typeof window !== 'undefined' && window.location.hostname && window.location.hostname !== 'localhost') {
    return `http://${window.location.hostname}:5000/api`;
  }
  return 'http://localhost:5000/api';
};

const API_BASE_URL = getApiBaseUrl();

const fetchWithTimeout = async (url: string, options: RequestInit = {}, timeoutMs = 15000) => {
  const controller = new AbortController();
  const id = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const response = await fetch(url, {
      ...options,
      signal: controller.signal,
    });
    return response;
  } finally {
    clearTimeout(id);
  }
};

export const AuthPage: React.FC<{ initialMode?: 'login' | 'register' }> = ({
  initialMode = 'login',
}) => {
  const { setCurrentPage } = useApp();
  const { lang } = useLanguage();
  const { refetchUser } = useAuthContext();

  const [mode, setMode] = useState<'login' | 'register'>(initialMode);
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');

  // OTP Verification state
  const [showOtpStep, setShowOtpStep] = useState(false);
  const [pendingEmail, setPendingEmail] = useState('');
  const [otpDigits, setOtpDigits] = useState<string[]>(['', '', '', '', '', '']);
  const otpInputRefs = useRef<(HTMLInputElement | null)[]>([]);
  const [resendCooldown, setResendCooldown] = useState(0);

  const [loading, setLoading] = useState(false);
  const [resending, setResending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  // Resend cooldown timer
  useEffect(() => {
    let timer: ReturnType<typeof setInterval>;
    if (resendCooldown > 0) {
      timer = setInterval(() => {
        setResendCooldown((prev) => prev - 1);
      }, 1000);
    }
    return () => clearInterval(timer);
  }, [resendCooldown]);

  const handleModeSwitch = (newMode: 'login' | 'register') => {
    setMode(newMode);
    setShowOtpStep(false);
    setError(null);
    setSuccess(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);

    if (mode === 'register') {
      if (!firstName.trim() || !lastName.trim()) {
        setError(lang === 'km' ? 'សូមបញ្ចូលឈ្មោះ និងនាមត្រកូល' : 'Please enter your first and last name.');
        return;
      }
      if (password !== confirmPassword) {
        setError(lang === 'km' ? 'ពាក្យសម្ងាត់ទាំងពីរមិនផ្ទៀងផ្ទាត់គ្នាទេ' : 'Passwords do not match.');
        return;
      }
    }

    if (!email.trim() || !password) {
      setError(lang === 'km' ? 'សូមបញ្ចូលអ៊ីមែល និងពាក្យសម្ងាត់' : 'Please enter email and password.');
      return;
    }

    if (password.length < 6) {
      setError(lang === 'km' ? 'ពាក្យសម្ងាត់ត្រូវមានយ៉ាងហោចណាស់ ៦ តួអក្សរ' : 'Password must be at least 6 characters.');
      return;
    }

    setLoading(true);

    try {
      const endpoint = mode === 'register' ? `${API_BASE_URL}/auth/register` : `${API_BASE_URL}/auth/login`;
      const payload = mode === 'register'
        ? { firstName, lastName, email, password, phoneNumber }
        : { email, password };

      const res = await fetchWithTimeout(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify(payload),
      }, 15000);

      const data = await res.json();

      if (data.requiresVerification && data.email) {
        setPendingEmail(data.email);
        setShowOtpStep(true);
        setOtpDigits(['', '', '', '', '', '']);
        setResendCooldown(60);
        setSuccess(
          mode === 'register'
            ? (lang === 'km' ? 'សូមពិនិត្យអ៊ីមែលរបស់អ្នក' : 'Check your email inbox')
            : (lang === 'km' ? 'លេខកូដផ្ទៀងផ្ទាត់បានផ្ញើទៅអ៊ីមែលរបស់អ្នក!' : 'Verification code sent to your email!')
        );
        setLoading(false);
        return;
      }

      if (!res.ok || !data.success) {
        setError(data.message || (lang === 'km' ? 'បរាជ័យក្នុងការចូលប្រើប្រាស់' : 'Authentication failed.'));
        setLoading(false);
        return;
      }

      if (data.token) {
        localStorage.setItem('token', data.token);
      }

      setSuccess(lang === 'km' ? 'ចូលប្រព័ន្ធជោគជ័យ!' : 'Logged in successfully!');
      await refetchUser();
      setCurrentPage('dashboard');
    } catch (err: any) {
      console.error('Auth submit error:', err);
      if (err.name === 'AbortError') {
        setError(lang === 'km' ? 'ការភ្ជាប់ទៅកាន់ម៉ាស៊ីនត្រូវបានផុតកំណត់ សូមព្យាយាមម្តងទៀត' : 'Request timed out. Please check your network connection and try again.');
      } else {
        setError(lang === 'km' ? 'មានបញ្ហាតភ្ជាប់ទៅកាន់ម៉ាស៊ីនបម្រើ' : 'Connection error. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  // OTP Handling
  const handleOtpDigitChange = (index: number, value: string) => {
    const digit = value.replace(/[^0-9]/g, '').slice(-1);
    const newOtp = [...otpDigits];
    newOtp[index] = digit;
    setOtpDigits(newOtp);

    // Auto-advance to next box
    if (digit && index < 5) {
      otpInputRefs.current[index + 1]?.focus();
    }
  };

  const handleOtpKeyDown = (index: number, e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Backspace' && !otpDigits[index] && index > 0) {
      otpInputRefs.current[index - 1]?.focus();
    }
  };

  const handleOtpPaste = (e: React.ClipboardEvent<HTMLInputElement>) => {
    e.preventDefault();
    const pasted = e.clipboardData.getData('text').replace(/[^0-9]/g, '').slice(0, 6);
    if (pasted) {
      const digits = pasted.split('');
      const newOtp = ['', '', '', '', '', ''];
      digits.forEach((d, i) => {
        if (i < 6) newOtp[i] = d;
      });
      setOtpDigits(newOtp);
      const nextFocus = Math.min(digits.length, 5);
      otpInputRefs.current[nextFocus]?.focus();
    }
  };

  const handleVerifyOtpSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const fullOtp = otpDigits.join('');
    if (fullOtp.length < 6) {
      setError(lang === 'km' ? 'សូមបញ្ចូលលេខកូដ ៦ តួអក្សរឲ្យគ្រប់' : 'Please enter all 6 digits of the code.');
      return;
    }

    setLoading(true);
    setError(null);
    setSuccess(null);

    try {
      const res = await fetchWithTimeout(`${API_BASE_URL}/auth/verify-otp`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ email: pendingEmail, otp: fullOtp }),
      }, 15000);

      const data = await res.json();

      if (!res.ok || !data.success) {
        setError(data.message || (lang === 'km' ? 'លេខកូដមិនត្រឹមត្រូវ' : 'Invalid verification code.'));
        setLoading(false);
        return;
      }

      if (data.token) {
        localStorage.setItem('token', data.token);
      }

      setSuccess(lang === 'km' ? 'ផ្ទៀងផ្ទាត់ជោគជ័យ! កំពុងចូលប្រព័ន្ធ...' : 'Verification successful! Logging in...');
      await refetchUser();
      setCurrentPage('dashboard');
    } catch (err: any) {
      console.error('Verify OTP error:', err);
      if (err.name === 'AbortError') {
        setError(lang === 'km' ? 'ការភ្ជាប់បានផុតកំណត់' : 'Request timed out. Please try again.');
      } else {
        setError(lang === 'km' ? 'មានបញ្ហាតភ្ជាប់ទៅកាន់ម៉ាស៊ីនបម្រើ' : 'Connection error. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleResendOtp = async () => {
    if (resendCooldown > 0 || resending) return;

    setResending(true);
    setError(null);
    setSuccess(null);

    try {
      const res = await fetchWithTimeout(`${API_BASE_URL}/auth/resend-otp`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ email: pendingEmail }),
      }, 15000);

      const data = await res.json();

      if (!res.ok || !data.success) {
        setError(data.message || (lang === 'km' ? 'បរាជ័យក្នុងការផ្ញើសារថ្មី' : 'Failed to resend code.'));
      } else {
        setSuccess(lang === 'km' ? 'លេខកូដថ្មីត្រូវបានផ្ញើទៅកាន់អ៊ីមែលរបស់អ្នក!' : 'A new code has been sent to your email!');
        setResendCooldown(60);
      }
    } catch (err: any) {
      console.error('Resend OTP error:', err);
      if (err.name === 'AbortError') {
        setError(lang === 'km' ? 'ការភ្ជាប់បានផុតកំណត់' : 'Request timed out.');
      } else {
        setError(lang === 'km' ? 'មានបញ្ហាតភ្ជាប់ទៅកាន់ម៉ាស៊ីនបម្រើ' : 'Connection error.');
      }
    } finally {
      setResending(false);
    }
  };

  return (
    <div className="h-screen max-h-screen overflow-hidden flex w-full bg-white font-sans relative">
      {/* Desktop Left Side Banner */}
      <div className="hidden lg:flex w-1/2 relative bg-[#133363] overflow-hidden flex-col justify-center items-center">
        {/* Back to landing button on Desktop Left Banner */}
        <button
          type="button"
          onClick={() => setCurrentPage('landing')}
          className="absolute top-6 left-8 z-20 flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs sm:text-sm font-bold text-blue-100 hover:text-white bg-white/10 hover:bg-white/20 backdrop-blur-md border border-white/15 transition-all duration-200 cursor-pointer group shadow-xs"
        >
          <ArrowLeft className="w-4 h-4 transition-transform group-hover:-translate-x-1" />
          <span>{lang === 'km' ? 'ត្រឡប់ទៅទំព័រដើម' : 'Back to Home'}</span>
        </button>

        <div className="relative z-10 w-full max-w-[80%] mx-auto p-8 lg:p-12">
          <h1 className="text-4xl lg:text-[3.25rem] leading-[1.15] font-black text-white tracking-tight mb-3">
            សូមស្វាគមន៍មកកាន់
            <br />
            PASSKRU
          </h1>
          <p className="text-blue-100/90 text-base lg:text-lg max-w-md font-medium">
            ត្រៀមប្រឡងគ្រូបង្រៀនក្របខណ្ឌរដ្ឋប្រកបដោយទំនុកចិត្តជាមួយ
          </p>
        </div>
        <div className="absolute bottom-0 left-0 w-3/4 h-[70%]">
          <img
            src="/landing.jpeg"
            alt="Students"
            className="w-full h-full object-cover object-top opacity-50 mix-blend-overlay"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#133363] via-[#133363]/40 to-transparent" />
        </div>
      </div>

      {/* Right Side Form Container */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-4 sm:p-6 lg:p-8 relative h-full overflow-y-auto">
        {/* Mobile Back Arrow Button */}
        <button
          type="button"
          onClick={() => {
            if (showOtpStep) {
              setShowOtpStep(false);
            } else {
              setCurrentPage('landing');
            }
          }}
          className="lg:hidden absolute top-4 left-4 z-30 p-2.5 rounded-full bg-slate-100 hover:bg-slate-200 text-slate-700 hover:text-[#0f3360] transition cursor-pointer shadow-xs flex items-center justify-center active:scale-95"
          aria-label="Back"
        >
          <ArrowLeft className="w-5 h-5" />
        </button>

        <div className="w-full max-w-[420px] my-auto py-4 text-center">
          <div
            className="flex flex-col items-center cursor-pointer mb-5"
            onClick={() => setCurrentPage('landing')}
          >
            <img
              src="/PassKru.svg"
              alt="PassKru Logo"
              className="h-12 w-auto shrink-0 object-contain"
              onError={(e) => {
                const target = e.currentTarget;
                if (target.src !== window.location.origin + '/PassKru-logo.svg') {
                  target.src = '/PassKru-logo.svg';
                }
              }}
            />
          </div>

          {/* OTP Verification Step View */}
          {showOtpStep ? (
            <div className="bg-slate-50 border border-slate-200/80 rounded-2xl p-6 shadow-xs text-center space-y-4">
              <div className="w-12 h-12 bg-blue-100 text-[#133363] rounded-2xl flex items-center justify-center mx-auto shadow-2xs">
                <ShieldCheck className="w-6 h-6" />
              </div>

              <div>
                <h2 className="text-xl font-bold text-slate-800">
                  {lang === 'km' ? 'ផ្ទៀងផ្ទាត់អាសយដ្ឋានអ៊ីមែល' : 'Verify Your Email'}
                </h2>
                <p className="text-xs text-slate-500 mt-1 font-medium">
                  {lang === 'km'
                    ? `យើងបានផ្ញើលេខកូដ ៦ តួអក្សរទៅកាន់ ${pendingEmail}`
                    : `We sent a 6-digit verification code to ${pendingEmail}`}
                </p>
              </div>

              {error && (
                <div className="flex items-start gap-2.5 p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 text-xs font-medium text-left">
                  <AlertCircle className="w-4 h-4 text-red-500 shrink-0 mt-0.5" />
                  <span>{error}</span>
                </div>
              )}

              {success && (
                <div className="flex items-center gap-2.5 p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs font-medium text-left">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 shrink-0" />
                  <span>{success}</span>
                </div>
              )}

              <form onSubmit={handleVerifyOtpSubmit} className="space-y-4">
                {/* 6 Digit Input Boxes */}
                <div className="flex justify-center gap-2 my-3">
                  {otpDigits.map((digit, idx) => (
                    <input
                      key={idx}
                      ref={(el) => { otpInputRefs.current[idx] = el; }}
                      type="text"
                      inputMode="numeric"
                      maxLength={1}
                      value={digit}
                      onChange={(e) => handleOtpDigitChange(idx, e.target.value)}
                      onKeyDown={(e) => handleOtpKeyDown(idx, e)}
                      onPaste={handleOtpPaste}
                      className="w-10 h-12 sm:w-11 sm:h-13 text-center text-xl font-black bg-white border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363] focus:border-[#133363] shadow-2xs"
                    />
                  ))}
                </div>

                <button
                  type="submit"
                  disabled={loading || otpDigits.join('').length < 6}
                  className="w-full py-2.5 px-4 bg-[#133363] hover:bg-[#0f284e] text-white font-bold rounded-xl text-sm transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50 shadow-xs"
                >
                  {loading ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      <span>{lang === 'km' ? 'កំពុងផ្ទៀងផ្ទាត់...' : 'Verifying...'}</span>
                    </>
                  ) : (
                    <span>{lang === 'km' ? 'ផ្ទៀងផ្ទាត់លេខកូដ' : 'Verify Code'}</span>
                  )}
                </button>
              </form>

              {/* After sign-up the API answers the same whether or not the email
                  already has an account (so it can't be used to probe emails);
                  existing owners get a "sign in instead" email, not a code. */}
              {mode === 'register' && (
                <div className="flex items-start gap-2.5 p-3 rounded-xl bg-blue-50 border border-blue-100 text-slate-600 text-xs text-left">
                  <Mail className="w-4 h-4 text-[#133363] shrink-0 mt-0.5" />
                  <span>
                    {lang === 'km'
                      ? 'មិនឃើញលេខកូដទេ? សូមពិនិត្យថត Spam។ បើអ៊ីមែលនេះមានគណនីរួចហើយ យើងបានផ្ញើអ៊ីមែលប្រាប់អ្នកជំនួសលេខកូដ — សូម '
                      : "No code? Check your Spam folder. If this email already has an account, we sent you an email saying so instead of a code — please "}
                    <button
                      type="button"
                      onClick={() => handleModeSwitch('login')}
                      className="text-[#133363] font-semibold hover:underline cursor-pointer"
                    >
                      {lang === 'km' ? 'ចូលប្រព័ន្ធជំនួសវិញ' : 'sign in instead'}
                    </button>
                    {lang === 'km' ? ' ឬប្រើ Google។' : ' or use Google.'}
                  </span>
                </div>
              )}

              <div className="pt-2 border-t border-slate-200/60 flex items-center justify-between text-xs">
                <button
                  type="button"
                  onClick={() => setShowOtpStep(false)}
                  className="text-slate-500 hover:text-slate-800 font-medium cursor-pointer"
                >
                  ← {lang === 'km' ? 'ត្រឡប់ក្រោយ' : 'Back'}
                </button>

                <button
                  type="button"
                  disabled={resendCooldown > 0 || resending}
                  onClick={handleResendOtp}
                  className="text-[#133363] hover:underline font-semibold disabled:text-slate-400 cursor-pointer flex items-center gap-1"
                >
                  {resending && <Loader2 className="w-3 h-3 animate-spin" />}
                  {resendCooldown > 0
                    ? (lang === 'km' ? `ផ្ញើម្តងទៀត (${resendCooldown}s)` : `Resend code (${resendCooldown}s)`)
                    : (lang === 'km' ? 'ផ្ញើលេខកូដម្តងទៀត' : 'Resend Code')}
                </button>
              </div>
            </div>
          ) : (
            <>
              {/* Tab Switcher: Login / Register */}
              <div className="flex bg-slate-100 p-1 rounded-xl mb-5 border border-slate-200">
                <button
                  type="button"
                  onClick={() => handleModeSwitch('login')}
                  className={`flex-1 py-2 text-xs sm:text-sm font-semibold rounded-lg transition-all cursor-pointer ${mode === 'login'
                    ? 'bg-white text-[#133363] shadow-xs'
                    : 'text-slate-500 hover:text-slate-800'
                    }`}
                >
                  {lang === 'km' ? 'ចូលប្រើប្រាស់' : 'Sign In'}
                </button>
                <button
                  type="button"
                  onClick={() => handleModeSwitch('register')}
                  className={`flex-1 py-2 text-xs sm:text-sm font-semibold rounded-lg transition-all cursor-pointer ${mode === 'register'
                    ? 'bg-white text-[#133363] shadow-xs'
                    : 'text-slate-500 hover:text-slate-800'
                    }`}
                >
                  {lang === 'km' ? 'បង្កើតគណនី' : 'Create Account'}
                </button>
              </div>

              {/* Form */}
              <form onSubmit={handleSubmit} className="bg-slate-50 border border-slate-200/80 rounded-2xl p-5 sm:p-6 shadow-xs space-y-4 text-left">
                {error && (
                  <div className="flex items-start gap-2.5 p-3 rounded-xl bg-red-50 border border-red-200 text-red-700 text-xs font-medium">
                    <AlertCircle className="w-4 h-4 text-red-500 shrink-0 mt-0.5" />
                    <span>{error}</span>
                  </div>
                )}

                {success && (
                  <div className="flex items-center gap-2.5 p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs font-medium">
                    <CheckCircle2 className="w-4 h-4 text-emerald-500 shrink-0" />
                    <span>{success}</span>
                  </div>
                )}

                {mode === 'register' && (
                  <>
                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <label className="block text-xs font-semibold text-slate-700 mb-1">
                          {lang === 'km' ? 'គោត្តនាម' : 'First Name'}
                        </label>
                        <div className="relative">
                          <User className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                          <input
                            type="text"
                            required
                            autoComplete="given-name"
                            value={firstName}
                            onChange={(e) => setFirstName(e.target.value)}
                            placeholder={lang === 'km' ? 'សុខ' : 'Sok'}
                            className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                          />
                        </div>
                      </div>
                      <div>
                        <label className="block text-xs font-semibold text-slate-700 mb-1">
                          {lang === 'km' ? 'នាម' : 'Last Name'}
                        </label>
                        <div className="relative">
                          <User className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                          <input
                            type="text"
                            required
                            autoComplete="family-name"
                            value={lastName}
                            onChange={(e) => setLastName(e.target.value)}
                            placeholder={lang === 'km' ? 'ចាន់' : 'Chan'}
                            className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                          />
                        </div>
                      </div>
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        {lang === 'km' ? 'លេខទូរស័ព្ទ (ជម្រើស)' : 'Phone Number (Optional)'}
                      </label>
                      <div className="relative">
                        <Phone className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                        <input
                          type="tel"
                          autoComplete="tel"
                          value={phoneNumber}
                          onChange={(e) => setPhoneNumber(e.target.value)}
                          placeholder="012 345 678"
                          className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                        />
                      </div>
                    </div>
                  </>
                )}

                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">
                    {lang === 'km' ? 'អាសយដ្ឋានអ៊ីមែល' : 'Email Address'}
                  </label>
                  <div className="relative">
                    <Mail className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                    <input
                      type="email"
                      required
                      autoComplete="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="name@example.com"
                      className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                    />
                  </div>
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">
                    {lang === 'km' ? 'ពាក្យសម្ងាត់' : 'Password'}
                  </label>
                  <div className="relative">
                    <Lock className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                    <input
                      type="password"
                      required
                      minLength={6}
                      autoComplete={mode === 'register' ? 'new-password' : 'current-password'}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      placeholder="••••••••"
                      className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                    />
                  </div>
                </div>

                {mode === 'register' && (
                  <div>
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      {lang === 'km' ? 'ផ្ទៀងផ្ទាត់ពាក្យសម្ងាត់' : 'Confirm Password'}
                    </label>
                    <div className="relative">
                      <Lock className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                      <input
                        type="password"
                        required
                        minLength={6}
                        autoComplete="new-password"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        placeholder="••••••••"
                        className="w-full pl-9 pr-3 py-2 text-sm bg-white border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#133363]/20 focus:border-[#133363]"
                      />
                    </div>
                  </div>
                )}

                <button
                  type="submit"
                  disabled={loading}
                  className="w-full py-2.5 px-4 bg-[#133363] hover:bg-[#0f284e] text-white font-bold rounded-xl text-sm transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-60 shadow-xs"
                >
                  {loading ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      <span>{lang === 'km' ? 'កំពុងដំណើរកា...' : 'Processing...'}</span>
                    </>
                  ) : mode === 'register' ? (
                    <span>{lang === 'km' ? 'ចុះឈ្មោះបង្កើតគណនី' : 'Register Account'}</span>
                  ) : (
                    <span>{lang === 'km' ? 'ចូលប្រព័ន្ធ' : 'Sign In'}</span>
                  )}
                </button>

                {/* Divider */}
                <div className="relative my-4">
                  <div className="absolute inset-0 flex items-center">
                    <div className="w-full border-t border-slate-200" />
                  </div>
                  <div className="relative flex justify-center text-xs uppercase">
                    <span className="bg-slate-50 px-2 text-slate-400 font-semibold">
                      {lang === 'km' ? 'ឬ' : 'OR'}
                    </span>
                  </div>
                </div>

                {/* Google OAuth Option */}
                <LoginButton text={lang === 'km' ? 'បន្តជាមួយ Google' : 'Continue with Google'} />
              </form>
            </>
          )}

          <p className="text-xs text-slate-400 mt-4">
            {lang === 'km'
              ? 'ដោយការចុចចូលប្រើ អ្នកយល់ព្រមតាមលក្ខខណ្ឌប្រើប្រាស់របស់យើង'
              : 'By continuing, you agree to our Terms of Service & Privacy Policy'}
          </p>
        </div>
      </div>
    </div>
  );
};