import {type ReactNode, useState} from "react";
import type {User} from "../types/User.tsx";
import {SessionContext, type SessionModel} from "./contexts.tsx";
import {ContextKeys} from "./ContextKeys.tsx";

function loadSessionModel(): SessionModel | undefined {
    const loadedModel = sessionStorage.getItem(ContextKeys.Auth)
    if (loadedModel) {
        return JSON.parse(loadedModel)
    } else {
        return undefined
    }
}

function cacheSessionModel(type: SessionModel) {
    sessionStorage.setItem(ContextKeys.Auth, JSON.stringify(type))
}

type AuthProviderProps = {
    children?: ReactNode;
}

export function SessionProvider({children}: AuthProviderProps) {

    const [modelState, setModelState] = useState<SessionModel | undefined>(loadSessionModel())

    const updateModel= (newModel: SessionModel) => {
        const updatedModel = {
            ...modelState,
            ...newModel
        }
        setModelState(updatedModel)
        cacheSessionModel(updatedModel)
    }
    const value = {
        model: modelState,
        setUser: (user: User | undefined) => {
            updateModel(
                {
                    ...modelState,
                    user: user
                }
            )
        }
    }

    return (
        <SessionContext.Provider value={value}>
            {children}
        </SessionContext.Provider>
    );
}
