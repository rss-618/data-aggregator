import { createContext, useContext } from 'react';
import type { PageRoute } from '../../components/navigation/PageRoute.tsx';
import type { User } from '../../types/auth/User.type.ts';

export const useCoordinator = () => useContext(CoordinatorContext);

type CoordinatorContextType = {
    navigateTo: (page: PageRoute) => void;
    login: (user: User) => void;
    logout: () => void;
};

export const CoordinatorContext = createContext<CoordinatorContextType>({
    navigateTo: () => {
        console.error('coordinator is unimplemented.');
    },
    login: () => {
        console.error('coordinator is unimplemented.');
    },
    logout: () => {
        console.error('coordinator is unimplemented.');
    },
});
