import { createContext, useContext } from 'react';
import type { User } from '../../types/User.tsx';

export const useSession = () => useContext(SessionContext);
export type SessionContextType = {
    model?: SessionModel;
    setUser: (user: User | undefined) => void;
};

export type SessionModel = {
    user?: User;
};

export const SessionContext = createContext<SessionContextType>({
    model: undefined,
    setUser: () => {
        console.error('Session is unimplemented.');
    },
});
