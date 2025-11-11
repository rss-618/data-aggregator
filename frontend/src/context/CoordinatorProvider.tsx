import {type ReactNode} from "react";
import {useNavigate} from "react-router-dom";
import {PageRoute} from "../navigation/PageRoute.tsx";
import {useSession} from "./contexts.tsx";
import {CoordinatorContext} from "./contexts.tsx";
import type {User} from "../types/User.tsx";

type CoordinatorProviderProps = {
    children?: ReactNode;
}

export function CoordinatorProvider({children}: CoordinatorProviderProps) {
    const session = useSession();
    const navigate = useNavigate()

    const values = {
        navigateTo: (page: PageRoute) => {
            navigate(page)
        },
        login: (user: User) => {
            session.setUser(user)
            navigate(PageRoute.Home)
        },
        logout: () => {
            session.setUser(undefined)
            navigate(PageRoute.Login)
        }
    }

    return (
        <CoordinatorContext.Provider value={values}>
            {children}
        </CoordinatorContext.Provider>
    );
}
