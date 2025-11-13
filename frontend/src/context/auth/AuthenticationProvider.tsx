import { useSession } from '../session/useSession.tsx';
import { AuthenticationContext } from './useAuth.tsx';
import type { ReactNode } from 'react';

type AuthenticationProviderProps = {
    children?: ReactNode;
};

export function AuthenticationProvider({
    children,
}: AuthenticationProviderProps) {
    const session = useSession();

    const isAuthenticated = () => {
        return session.model?.user !== undefined;
    };

    const values = {
        isAuthenticated: isAuthenticated(),
    };

    return (
        <AuthenticationContext.Provider value={values}>
            {children}
        </AuthenticationContext.Provider>
    );
}
