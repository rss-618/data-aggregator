import { createContext, useContext } from 'react';
import type { UserType } from '../../types/User.type.tsx';

export const useSession = () => useContext(SessionContext);
export type SessionContextType = {
    model?: SessionModel;
    setUser: (user: UserType | undefined) => void;
};

export type SessionModel = {
    user?: UserType;
};

export const SessionContext = createContext<SessionContextType>({
    model: undefined,
    setUser: () => {
        console.error('Session is unimplemented.');
    },
});
