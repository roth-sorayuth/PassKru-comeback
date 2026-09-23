import axios, { AxiosRequestConfig } from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000/api';

export const axiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to attach Bearer token (for mobile browsers where 3rd-party cookies are blocked)
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

// Response interceptor for consistent error extraction
axiosInstance.interceptors.response.use(
  (response) => response,
  (error) => {
    const message = error.response?.data?.message || error.message || 'Something went wrong';
    const customError = new Error(message);
    (customError as any).statusCode = error.response?.status;
    (customError as any).data = error.response?.data;
    return Promise.reject(customError);
  }
);

export interface RequestOptions extends AxiosRequestConfig {
  body?: any;
}

export const api = async (endpoint: string, options: RequestOptions = {}) => {
  const { body, method = 'GET', headers, ...rest } = options;
  const response = await axiosInstance({
    url: endpoint,
    method,
    data: body !== undefined ? body : rest.data,
    headers,
    ...rest,
  });

  return response.data;
};