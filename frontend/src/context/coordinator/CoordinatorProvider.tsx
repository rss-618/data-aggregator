import { type ReactNode, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { PageRoute } from '../../components/navigation/PageRoute.tsx';
import type { User } from '../../types/auth/User.type.ts';
import { useSession } from '../session/useSession.tsx';
import { CoordinatorContext } from './useCoordinator.tsx';
import { logoutPublisher } from './logoutPublisher.ts';
import { ApiClient } from '../../api/ApiClient.ts';
import cookieUtility from '../../utilities/cookieUtility.ts';

type CoordinatorProviderProps = {
    children?: ReactNode;
};

export function CoordinatorProvider({ children }: CoordinatorProviderProps) {
    const session = useSession();
    const navigate = useNavigate();

    const onLogout = () => {
        values.logout();
    };

    useEffect(() => {
        logoutPublisher.subscribe(onLogout);
        return logoutPublisher.unsubscribe(onLogout);
    });

    const values = {
        navigateTo: (page: PageRoute) => {
            navigate(page);
        },
        login: (user: User) => {
            session.setUser(user);
            navigate(PageRoute.Home);
        },
        logout: () => {
            session.setUser(undefined);
            navigate(PageRoute.Login);
            // Ensure cookies are deleted no matter what.
            ApiClient.logout()
                .then((value) => value)
                .catch() // Do nothing
                .finally(() => {
                    cookieUtility.clearSessionId().then();
                });
        },
    };

    return (
        <CoordinatorContext.Provider value={values}>
            {children}
        </CoordinatorContext.Provider>
    );
}
