import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { CoordinatorProvider } from './context/coordinator/CoordinatorProvider.tsx';
import { PageRoute } from './features/navigation/PageRoute.tsx';
import AuthenticatedLayout from './features/navigation/AuthenticatedLayout.tsx';
import Home from './features/home/Home.tsx';
import Login from './features/login/Login.tsx';
import NotFound from './features/notFound/NotFound.tsx';
import Unauthorized from './features/unauthorized/Unauthorized.tsx';
import RootLayout from './features/navigation/RootLayout.tsx';

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
