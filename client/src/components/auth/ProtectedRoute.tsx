import React, { ReactNode } from 'react';
import { Navigate } from 'react-router-dom';
import { useAuthContext } from '../../context/AuthContext';

interface ProtectedRouteProps {
  children: ReactNode;
  redirectTo?: string;
}

export const ProtectedRoute: React.FC<ProtectedRouteProps> = ({
  children,
  redirectTo = '/login',
}) => {
  const { user, loading } = useAuthContext();

  if (loading) {
    return (
      <div className="min-h-screen bg-white flex flex-col items-center justify-center p-6 select-none font-sans">
        <div className="relative flex flex-col items-center justify-center space-y-4">
          <img
            src="/PassKru.svg"
            alt="PassKru"
            className="w-28 sm:w-32 h-28 sm:h-32 object-contain animate-pulse"
            onError={(e) => {
              const target = e.currentTarget;
              if (target.src !== window.location.origin + '/PassKru-logo.svg') {
                target.src = '/PassKru-logo.svg';
              }
            }}
          />
          <div className="w-7 h-7 border-3 border-black/10 border-t-black rounded-full animate-spin" />
        </div>
      </div>
    );
  }

  if (!user) {
    return <Navigate to={redirectTo} replace />;
  }

  return <>{children}</>;
};

export default ProtectedRoute;
