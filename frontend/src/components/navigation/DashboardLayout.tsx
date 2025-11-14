import { Outlet, useLocation } from 'react-router-dom';
import { PageRoute } from './PageRoute.tsx';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';
import classnames from '../../utilities/classnames.tsx';
import { useState } from 'react';

export default function DashboardLayout() {
    return (
        <div className="grow flex">
            <div className="grow flex flex-row">
                <div className="grow flex justify-center">
                    <Outlet />
                </div>
                <NavBar />
            </div>
        </div>
    );
}

function NavBar() {
    const coordinator = useCoordinator();
    const location = useLocation();

    const [isNavOpen, setIsNavOpen] = useState(true);

    const isHighlighted = (route: PageRoute) => {
        return route === location.pathname;
    };

    const navigate = (route: PageRoute) => {
        coordinator.navigateTo(route);
    };

    const navbarClassnames = classnames(
        'transition-all duration-250 ease-in-out',
        isNavOpen ? 'translate-x-0 visible' : 'translate-x-full hidden',
        'flex flex-col y-full space-y-2 p-3 bg-dark rounded-md'
    );

    const expandButton = () => {
        return (
            <button
                className={classnames('text-3xl')}
                onClick={() => setIsNavOpen(!isNavOpen)}
            >
                &lt;
            </button>
        );
    };

    return (
        <div className="y-full flex flex-row space-x-1 align-middle">
            {expandButton()}
            <div className={navbarClassnames}>
                <NavButton
                    title="Home"
                    highlighted={isHighlighted(PageRoute.Home)}
                    action={() => navigate(PageRoute.Home)}
                />

                <div className="grow" />

                <NavButton
                    title="Logout"
                    highlighted={false}
                    action={() => coordinator.logout()}
                />
            </div>
        </div>
    );
}

type NavButtonProps = {
    title: string;
    highlighted: boolean;
    action: () => void;
};

function NavButton({ title, highlighted, action }: NavButtonProps) {
    return (
        <button
            className={classnames(
                highlighted ? 'text-blue' : 'text-cullen',
                'hover:border-blade hover:text-blade rounded-md p-1 bg-aro border-cullen border-[1px]'
            )}
            onClick={action}
        >
            {title}
        </button>
    );
}
