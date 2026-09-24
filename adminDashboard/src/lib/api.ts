import axios, { AxiosRequestConfig } from 'axios';

const getApiBaseUrl = () => {
  if (import.meta.env.VITE_API_URL) return import.meta.env.VITE_API_URL;
  if (typeof window !== 'undefined' && window.location.hostname && window.location.hostname !== 'localhost') {
    return `http://${window.location.hostname}:5000/api`;
  }
  return 'http://localhost:5000/api';
};

const BASE = getApiBaseUrl();

export const axiosInstance = axios.create({
  baseURL: BASE,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to attach Bearer token (for browsers where 3rd-party cookies are blocked)
axiosInstance.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token && config.headers) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

axiosInstance.interceptors.response.use(
  (response) => response,
  (error) => {
    const data = error.response?.data;
    const message = data?.message ?? data?.detail ?? error.message ?? `Request failed ${error.response?.status}`;
    const customError = new Error(message);
    (customError as any).statusCode = error.response?.status;
    (customError as any).data = data;
    return Promise.reject(customError);
  }
);

export const api = {
  get: async <T = unknown>(endpoint: string, config?: AxiosRequestConfig): Promise<T> => {
    const res = await axiosInstance.get<T>(endpoint, config);
    return res.data;
  },
  post: async <T = unknown>(endpoint: string, body?: unknown, config?: AxiosRequestConfig): Promise<T> => {
    const res = await axiosInstance.post<T>(endpoint, body, config);
    return res.data;
  },
  put: async <T = unknown>(endpoint: string, body?: unknown, config?: AxiosRequestConfig): Promise<T> => {
    const res = await axiosInstance.put<T>(endpoint, body, config);
    return res.data;
  },
  patch: async <T = unknown>(endpoint: string, body?: unknown, config?: AxiosRequestConfig): Promise<T> => {
    const res = await axiosInstance.patch<T>(endpoint, body, config);
    return res.data;
  },
  delete: async <T = unknown>(endpoint: string, config?: AxiosRequestConfig): Promise<T> => {
    const res = await axiosInstance.delete<T>(endpoint, config);
    return res.data;
  },
};
