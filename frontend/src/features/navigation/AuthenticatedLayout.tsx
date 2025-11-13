import { Outlet, useLocation } from 'react-router-dom';
import { PageRoute } from './PageRoute.tsx';
import ProtectedRoute from './ProtectedRoute.tsx';
import { useAuth } from '../../context/auth/useAuth.tsx';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';

export default function AuthenticatedLayout() {
    const auth = useAuth();

    return (
        <ProtectedRoute
            isAllowed={() => auth.isAuthenticated}
            redirectPath={PageRoute.Login}
        >
            <div className="grow flex">
                <div className="grow flex flex-row">
                    <div className="grow flex justify-center">
                        <Outlet />
                    </div>
                    <NavBar />
                </div>
            </div>
        </ProtectedRoute>
    );
}

type NavIconProps = {
    title: string;
    destination: PageRoute;
};

function NavBar() {
    return (
        <div className="flex flex-col space-y-2 px-3">
            <NavIcon title="Home" destination={PageRoute.Home} />
            <NavIcon title="Login*" destination={PageRoute.Login} />
        </div>
    );
}

function NavIcon({ title, destination }: NavIconProps) {
    const coordinator = useCoordinator();
    const location = useLocation();

    const navigate = () => {
        coordinator.navigateTo(destination);
    };

    const isCurrent = location.pathname === destination;

    return (
        <button
            className={isCurrent ? 'text-blue' : 'text-cullen'}
            onClick={navigate}
        >
            {title}
        </button>
    );
}
