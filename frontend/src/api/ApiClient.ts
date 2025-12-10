// Eventually split out into other files
import type { LoginRequest } from '../types/auth/LoginRequest.type.ts';
import type { User } from '../types/auth/User.type.ts';
import HttpError from '../types/utility/HttpError.type.ts';
import { logoutPublisher } from '../context/coordinator/logoutPublisher.ts';

// TODO: Make header builder
const headers: Record<string, string> = {
    'content-type': 'application/json',
};

export const ApiClient = {
    login: async function (request: LoginRequest): Promise<User> {
        return callHandler('/auth/login', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(request),
        });
    },
    logout: async function (): Promise<void> {
        return await emptyResponseCallHandler('/auth/logout', {
            method: 'GET',
        });
    },
};

async function callHandler<ResponseType>(
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

async function emptyResponseCallHandler(
    input: RequestInfo | URL,
    init?: RequestInit
): Promise<void> {
    try {
        return await callHandler(input, init);
    } catch (error: HttpError | unknown) {
        if (error instanceof HttpError && error.statusCode == 204) {
            return;
        }
        throw error;
    }
}

function checkResponse(response: Response) {
    if (!response.ok || response.status === 204) {
        throw new HttpError(response.statusText, response.status);
    }
}
