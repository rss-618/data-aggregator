// Eventually split out into other files
import type { LoginRequest } from '../types/auth/LoginRequest.type.ts';
import type { User } from '../types/auth/User.type.ts';
import HttpError from '../types/utility/HttpError.type.ts';
import { logoutPublisher } from '../context/coordinator/logoutPublisher.ts';

const headers: Record<string, string> = {
    'content-type': 'application/json',
};

export const ApiClient = {
    login: async function (request: LoginRequest): Promise<User> {
        return apiFetch('/auth/login', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(request),
        });
    },
    logout: async function (): Promise<void> {
        return await apiFetch('/auth/logout', {
            method: 'GET',
            headers: headers,
        });
    },
};

async function apiFetch<ResponseType>(
    input: RequestInfo | URL,
    init?: RequestInit
): Promise<ResponseType> {
    try {
        const response = await fetch(`http://localhost:8080${input}`, init);
        // Check if response is an error or not.
        checkResponse(response);
        return response.json();
    } catch (error: HttpError | unknown) {
        if (error instanceof HttpError && error.statusCode == 401) {
            // Log the user out
            logoutPublisher.emit();
        }
        throw error;
    }
}

function checkResponse(response: Response) {
    if (!response.ok) {
        throw new HttpError(response.statusText, response.status);
    }
}
