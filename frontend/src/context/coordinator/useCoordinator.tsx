import { createContext, useContext } from 'react';
import type { PageRoute } from '../../components/navigation/PageRoute.tsx';
import type { UserType } from '../../types/User.type.tsx';

export const useCoordinator = () => useContext(CoordinatorContext);

type CoordinatorContextType = {
    navigateTo: (page: PageRoute) => void;
    login: (user: UserType) => void; // TODO: Pass JWT token instead
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
