import type { ReactNode } from 'react';
import { Navigate, Outlet } from 'react-router-dom';

type ProtectedRoutesProps = {
    isAllowed: () => boolean;
    redirectPath: string;
    children?: ReactNode;
};

export default function ProtectedRoute({
    isAllowed,
    redirectPath,
    children,
}: ProtectedRoutesProps) {
    if (isAllowed()) {
        return children ? children : <Outlet />;
    } else {
        return <Navigate to={{ pathname: redirectPath }} replace />;
    }
}
