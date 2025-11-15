import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { CoordinatorProvider } from './context/coordinator/CoordinatorProvider.tsx';
import { PageRoute } from './components/navigation/PageRoute.tsx';
import DashboardLayout from './components/navigation/DashboardLayout.tsx';
import Home from './components/home/Home.tsx';
import Login from './components/login/Login.tsx';
import NotFound from './components/not-found/NotFound.tsx';
import Unauthorized from './components/unauthorized/Unauthorized.tsx';
import RootLayout from './components/navigation/RootLayout.tsx';
import ProtectedRoute from './components/navigation/ProtectedRoute.tsx';
import { useAuth } from './context/auth/useAuth.tsx';

export default function App() {
    const auth = useAuth();

    return (
        <BrowserRouter>
            <CoordinatorProvider>
                <Routes>
                    {/* Protected */}
                    {/* Authenticated - Only */}
                    <Route
                        path={PageRoute.Home}
                        element={
                            <ProtectedRoute
                                isAllowed={() => auth.isAuthenticated}
                                redirectPath={PageRoute.Login}
                                children={<DashboardLayout />}
                            />
                        }
                    >
                        <Route path={PageRoute.Home} element={<Home />} />
                        <Route
                            path={PageRoute.NotFound}
                            element={<NotFound />}
                        />
                        <Route
                            path={PageRoute.Unauthorized}
                            element={<Unauthorized />}
                        />
                    </Route>
                    {/* Unauthenticated - Only */}
                    <Route
                        path={PageRoute.Login}
                        element={
                            <ProtectedRoute
                                redirectPath={PageRoute.Home}
                                isAllowed={() => !auth.isAuthenticated}
                            >
                                <RootLayout>
                                    <Login />
                                </RootLayout>
                            </ProtectedRoute>
                        }
                    />
                </Routes>
            </CoordinatorProvider>
        </BrowserRouter>
    );
}
