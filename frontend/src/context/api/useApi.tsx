import { createContext, useContext } from 'react';
import type { UserType } from '../../types/User.type.tsx';
import type { TokenResponse } from '../../types/TokenResponse.type.tsx';
import type { RefreshRequest } from '../../types/RefreshRequest.type.tsx';
import type { LoginRequest } from '../../types/LoginRequest.type.tsx';

export const useApi = () => useContext(ApiContext);

type ApiContextType = {
    login: (request: LoginRequest) => Promise<UserType>;
    refresh: (request: RefreshRequest) => Promise<TokenResponse>;
};

export const ApiContext = createContext<ApiContextType>({
    login: () => {
        return Promise.reject('Login Unimplemented');
    },
    refresh: () => {
        return Promise.reject('Refresh Unimplemented');
    },
});
