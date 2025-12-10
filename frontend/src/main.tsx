import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.tsx';
import { SessionProvider } from './context/session/SessionProvider.tsx';
import { BrowserRouter } from 'react-router-dom';
import { CoordinatorProvider } from './context/coordinator/CoordinatorProvider.tsx';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <BrowserRouter>
            <SessionProvider>
                <CoordinatorProvider>
                    <App />
                </CoordinatorProvider>
            </SessionProvider>
        </BrowserRouter>
    </StrictMode>
);
