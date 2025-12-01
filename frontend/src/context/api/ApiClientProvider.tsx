import { type ReactNode, useContext } from 'react';
import type { LoginRequest } from '../../types/LoginRequest.type.tsx';
import { useAuth } from '../auth/useAuth.tsx';
import type { TokenResponse } from '../../types/TokenResponse.type.tsx';
import type { RefreshRequest } from '../../types/RefreshRequest.type.tsx';
import type { User } from '../../types/User.type.tsx';
import { ApiContext } from './useApi.tsx';

type ApiClientProviderProps = {
    children?: ReactNode;
};

export function ApiClientProvider({ children }: ApiClientProviderProps) {
    const auth = useAuth();

    const headers: () => Record<string, string> = () => {
        return {
            'content-type': 'application/json',
            Authorization: `Bearer ${auth.token}`,
        };
    };

    async function login(request: LoginRequest): Promise<User> {
        return fetch('/api/login', {
            method: 'GET',
            headers: headers(),
            body: JSON.stringify(request),
        }).then((res) => res.json());
    }

    async function refresh(request: RefreshRequest): Promise<TokenResponse> {
        return fetch('/api/login', {
            method: 'GET',
            headers: headers(),
            body: JSON.stringify(request),
        }).then((res) => res.json());
    }

    const values = {
        login: login,
        refresh: refresh,
    };

    return <ApiContext.Provider value={values}>{children}</ApiContext.Provider>;
}
