import {createContext, useContext} from "react";
import type {User} from "../types/User.tsx";
import type {PageRoute} from "../navigation/PageRoute.tsx";


// Session
export const useSession = () => useContext(SessionContext);
export type SessionContextType = {
    model?: SessionModel;
    setUser: (user: User | undefined) => void;
}

export type SessionModel = {
    user?: User;
}


export const SessionContext = createContext<SessionContextType>(
    {
        model: undefined,
        setUser: () => {
            console.error("Session is unimplemented.")
        }
    }
)
// - End Session


// Coordinator
export const useCoordinator = () => useContext(CoordinatorContext);

type CoordinatorContextType = {
    navigateTo: (page: PageRoute) => void
    login: (user: User) => void
    logout: () => void
}

export const CoordinatorContext = createContext<CoordinatorContextType>(
    {
        navigateTo: () => {
            console.error("Coordinator is unimplemented.")
        },
        login: () => {
            console.error("Coordinator is unimplemented.")
        },
        logout: () => {
            console.error("Coordinator is unimplemented.")
        }
    }
)
// - End Coordinator
