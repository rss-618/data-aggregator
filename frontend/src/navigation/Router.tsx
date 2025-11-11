import {BrowserRouter, Route, Routes} from "react-router-dom";
import NotFound from "../features/not-found/NotFound.tsx";
import Login from "../features/login/Login.tsx";
import ProtectedRoute from "./ProtectedRoute.tsx";
import Home from "../features/home/Home.tsx";
import {useSession} from "../context/contexts.tsx";
import Unauthorized from "../features/unauthorized/Unauthorized.tsx";
import {PageRoute} from "./PageRoute.tsx";
import {CoordinatorProvider} from "../context/CoordinatorProvider.tsx";

export default function Router() {

    const session = useSession()

    const isAuthenticated = () => {
        return session.model?.user !== undefined
    }

    return (
        <BrowserRouter>
            <CoordinatorProvider>
                <Routes>
                    {/* Unprotected */}
                    <Route path={PageRoute.NotFound} element={<NotFound/>}/>
                    <Route path={PageRoute.Unauthorized} element={<Unauthorized/>}/>

                    {/* Protected */}
                    <Route path={PageRoute.Home} element={
                        <ProtectedRoute redirectPath={PageRoute.Login} isAllowed={() => isAuthenticated()}/>
                    }>
                        <Route path={PageRoute.Home} element={<Home/>}/>
                    </Route>

                    <Route path={PageRoute.Login} element={
                        <ProtectedRoute redirectPath={PageRoute.Home} isAllowed={() => !isAuthenticated()}>
                            <Login/>
                        </ProtectedRoute>
                    }/>
                </Routes>
            </CoordinatorProvider>
        </BrowserRouter>
    )

}
