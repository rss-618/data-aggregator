import { Outlet, useLocation } from 'react-router-dom';
import { PageRoute } from './PageRoute.tsx';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';
import classnames from '../../utilities/classnames.ts';
import { useState } from 'react';
import RootLayout from './RootLayout.tsx';

export default function DashboardLayout() {
    return (
        <div className="flex flex-row justify-center w-screen">
            <RootLayout>
                <Outlet />
            </RootLayout>
            <NavBar />
        </div>
    );
}

function NavBar() {
    const coordinator = useCoordinator();
    const location = useLocation();

    const [isNavOpen, setIsNavOpen] = useState(screen.width > 768); // TODO: make a constants file for screen widths n what not

    const isHighlighted = (route: PageRoute) => {
        return route === location.pathname;
    };

    const navigate = (route: PageRoute) => {
        coordinator.navigateTo(route);
    };

    const navbarClassnames = classnames(
        'transition-all duration-250 ease-in-out',
        isNavOpen ? 'translate-x-0 visible' : 'translate-x-full hidden',
        'flex flex-col space-y-2 p-3 bg-dark rounded-md'
    );

    const expandButton = () => {
        return (
            <button
                className="text-5xl hover:bg-gray-700/50 active:bg-gray-800/50 rounded-4xl p-2"
                onClick={() => setIsNavOpen(!isNavOpen)}
            >
                &#8942;
            </button>
        );
    };

    return (
        <aside className="fixed end-0 flex h-screen items-center">
            <div className="flex h-1/2 flex-row space-x-1 ">
                <div className="flex flex-col justify-center">
                    {expandButton()}
                </div>
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
        </aside>
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
