import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { CoordinatorProvider } from './context/coordinator/CoordinatorProvider.tsx';
import { PageRoute } from './components/navigation/PageRoute.tsx';
import AuthenticatedLayout from './components/navigation/AuthenticatedLayout.tsx';
import Home from './components/home/Home.tsx';
import Login from './components/login/Login.tsx';
import NotFound from './components/not-found/NotFound.tsx';
import Unauthorized from './components/unauthorized/Unauthorized.tsx';
import RootLayout from './components/navigation/RootLayout.tsx';

export default function App() {
    return (
        <RootLayout>
            <BrowserRouter>
                <CoordinatorProvider>
                    <Routes>
                        {/* Unprotected */}
                        <Route
                            path={PageRoute.NotFound}
                            element={<NotFound />}
                        />
                        <Route
                            path={PageRoute.Unauthorized}
                            element={<Unauthorized />}
                        />

                        {/* Protected */}
                        {/* Authenticated - Only */}
                        <Route
                            path={PageRoute.Home}
                            element={<AuthenticatedLayout />}
                        >
                            <Route path={PageRoute.Home} element={<Home />} />
                        </Route>
                        {/* Unauthenticated - Only */}
                        <Route path={PageRoute.Login} element={<Login />} />
                    </Routes>
                </CoordinatorProvider>
            </BrowserRouter>
        </RootLayout>
    );
}
