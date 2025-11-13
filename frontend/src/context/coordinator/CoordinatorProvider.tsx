import { type ReactNode } from 'react';
import { useNavigate } from 'react-router-dom';
import { PageRoute } from '../../features/navigation/PageRoute.tsx';
import type { User } from '../../types/User.tsx';
import { useSession } from '../session/useSession.tsx';
import { CoordinatorContext } from './useCoordinator.tsx';

type CoordinatorProviderProps = {
    children?: ReactNode;
};

export function CoordinatorProvider({ children }: CoordinatorProviderProps) {
    const session = useSession();
    const navigate = useNavigate();

    const values = {
        navigateTo: (page: PageRoute) => {
            navigate(page);
        },
        login: (user: User) => {
            session.setUser(user);
            navigate(PageRoute.Home);
            console.log('login');
        },
        logout: () => {
            session.setUser(undefined);
            navigate(PageRoute.Login);
        },
    };

    return (
        <CoordinatorContext.Provider value={values}>
            {children}
        </CoordinatorContext.Provider>
    );
}
