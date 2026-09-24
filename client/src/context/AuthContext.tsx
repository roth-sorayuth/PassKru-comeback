import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

const getApiBaseUrl = () => {
  if (import.meta.env.VITE_API_URL) return import.meta.env.VITE_API_URL;
  if (typeof window !== 'undefined' && window.location.hostname && window.location.hostname !== 'localhost') {
    return `http://${window.location.hostname}:5000/api`;
  }
  return 'http://localhost:5000/api';
};

const API_BASE_URL = getApiBaseUrl();

export interface User {
  userId: number;
  firstName: string;
  lastName: string;
  email: string;
  role: string;
  avatarUrl?: string | null;
  googleId?: string | null;
  clerkId?: string | null;
  [key: string]: any;
}

interface AuthContextType {
  user: User | null;
  loading: boolean;
  logout: () => Promise<void>;
  refetchUser: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  const fetchUser = async () => {
    setLoading(true);
    try {
      // 1. Google OAuth redirect carries a single-use code (never the token
      //    itself); trade it for the session token, then clean the address bar.
      const urlParams = new URLSearchParams(window.location.search);
      const authCode = urlParams.get('authCode');
      if (authCode) {
        const cleanUrl = window.location.pathname + window.location.hash;
        window.history.replaceState({}, document.title, cleanUrl);
        try {
          const exchange = await fetch(`${API_BASE_URL}/auth/google/exchange`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify({ code: authCode }),
          });
          const data = await exchange.json();
          if (exchange.ok && data.token) {
            localStorage.setItem('token', data.token);
            if (data.user) {
              setUser(data.user);
              setLoading(false);
              return;
            }
          }
        } catch (err) {
          console.error('Google sign-in code exchange failed:', err);
        }
      }

      const token = localStorage.getItem('token');
      const headers: Record<string, string> = {
        'Content-Type': 'application/json',
      };
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      const response = await fetch(`${API_BASE_URL}/auth/me`, {
        method: 'GET',
        headers,
        credentials: 'include',
      });

      if (response.ok) {
        const data = await response.json();
        if (data.success && data.user) {
          setUser(data.user);
        } else {
          setUser(null);
        }
      } else {
        // Token might be invalid or expired
        if (token && response.status === 401) {
          localStorage.removeItem('token');
        }
        setUser(null);
      }
    } catch (error) {
      console.error('Failed to fetch authenticated user:', error);
      setUser(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUser();
  }, []);

  const logout = async () => {
    try {
      const token = localStorage.getItem('token');
      const headers: Record<string, string> = {
        'Content-Type': 'application/json',
      };
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      await fetch(`${API_BASE_URL}/auth/logout`, {
        method: 'POST',
        headers,
        credentials: 'include',
      });
    } catch (error) {
      console.error('Failed to logout:', error);
    } finally {
      localStorage.removeItem('token');
      setUser(null);
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, logout, refetchUser: fetchUser }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuthContext = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuthContext must be used within an AuthProvider');
  }
  return context;
};

export default AuthContext;
