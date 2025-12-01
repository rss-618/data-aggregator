import { type ReactNode, useState } from 'react';
import type { UserType } from '../../types/User.type.tsx';
import { SessionContext, type SessionModel } from './useSession.tsx';

const cacheKey = 'SessionModel';

function loadSessionModel(): SessionModel | undefined {
    const loadedModel = sessionStorage.getItem(cacheKey);
    if (loadedModel) {
        return JSON.parse(loadedModel);
    } else {
        return undefined;
    }
}

function cacheSessionModel(type: SessionModel) {
    sessionStorage.setItem(cacheKey, JSON.stringify(type));
}

type AuthProviderProps = {
    children?: ReactNode;
};

export function SessionProvider({ children }: AuthProviderProps) {
    const [modelState, setModelState] = useState<SessionModel | undefined>(
        loadSessionModel()
    );

    const updateModel = (newModel: SessionModel) => {
        const updatedModel = {
            ...modelState,
            ...newModel,
        };
        setModelState(updatedModel);
        cacheSessionModel(updatedModel);
    };
    const value = {
        model: modelState,
        setUser: (user: UserType | undefined) => {
            updateModel({
                ...modelState,
                user: user,
            });
        },
    };

    return (
        <SessionContext.Provider value={value}>
            {children}
        </SessionContext.Provider>
    );
}
