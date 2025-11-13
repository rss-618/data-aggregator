import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.tsx';
import { SessionProvider } from './context/session/SessionProvider.tsx';
import { AuthenticationProvider } from './context/auth/AuthenticationProvider.tsx';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <SessionProvider>
            <AuthenticationProvider>
                <App />
            </AuthenticationProvider>
        </SessionProvider>
    </StrictMode>
);
