import { createContext, useContext } from 'react';

export const useAuth = () => useContext(AuthenticationContext);

type AuthContextType = {
    isAuthenticated: boolean;
    accessToken?: string;
    refreshToken?: string; // do i want this? go session based?
};

export const AuthenticationContext = createContext<AuthContextType>({
    isAuthenticated: false,
});
