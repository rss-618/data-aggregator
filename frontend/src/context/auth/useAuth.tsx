import { createContext, useContext } from 'react';

export const useAuth = () => useContext(AuthenticationContext);

type AuthContextType = {
    isAuthenticated: boolean;
};

export const AuthenticationContext = createContext<AuthContextType>({
    isAuthenticated: false,
});
