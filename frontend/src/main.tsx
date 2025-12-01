import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.tsx';
import { SessionProvider } from './context/session/SessionProvider.tsx';
import { AuthenticationProvider } from './context/auth/AuthenticationProvider.tsx';
import { ApiClientProvider } from './context/api/ApiClientProvider.tsx';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <SessionProvider>
            <AuthenticationProvider>
                <ApiClientProvider>
                    <App />
                </ApiClientProvider>
            </AuthenticationProvider>
        </SessionProvider>
    </StrictMode>
);
