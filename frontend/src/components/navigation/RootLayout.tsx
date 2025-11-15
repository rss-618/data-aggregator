import { type ReactNode } from 'react';
import logo from '../../resources/img/daggregate.svg';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';
import { PageRoute } from './PageRoute.tsx';

type RootLayoutProps = {
    children?: ReactNode;
};

export default function RootLayout({ children }: RootLayoutProps) {
    const coordinator = useCoordinator();

    const header = () => {
        return (
            <header className="select-none flex flex-row space-x-3 justify-start py-5">
                <div
                    className="hover:bg-gray-700/50 active:bg-gray-800/50 rounded-4xl flex flex-row space-x-2 p-3"
                    onClick={() => coordinator.navigateTo(PageRoute.Home)}
                >
                    <img src={logo} alt="logo" className="w-10" />
                    <h1>Daggregate</h1>
                </div>
            </header>
        );
    };

    const footer = () => {
        return (
            <footer className="w-full justify-center select-none flex py-3 opacity-50">
                <div className="flex flex-col sm:flex-row space-x-4 space-y-2 md:text-sm text-xs">
                    <div>
                        Created by&nbsp;
                        <a
                            className="text-blue hover:text-cyan"
                            href="https://github.com/rss-618"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            Ryan Schildknecht
                        </a>
                    </div>
                    <div>
                        Project&nbsp;
                        <a
                            className="text-blue hover:text-cyan"
                            href="https://github.com/rss-618/data-aggregator"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            Link
                        </a>
                    </div>
                </div>
            </footer>
        );
    };

    return (
        <main className="flex justify-center justify-items-center overflow-x-clip max-w-screen">
            <div className="flex flex-col w-screen min-h-screen container">
                {header()}
                <div className="grow flex justify-center">{children}</div>
                {footer()}
            </div>
        </main>
    );
}
