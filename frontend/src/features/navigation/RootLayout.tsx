import type { ReactNode } from 'react';
import logo from '../../resources/img/daggregate.svg';

type RootLayoutProps = {
    children?: ReactNode;
};

export default function RootLayout({ children }: RootLayoutProps) {
    const header = () => {
        return (
            <header className="flex flex-row space-x-3 justify-start p-8">
                <img src={logo} alt="logo" className="w-10" />
                <h1>Daggregate</h1>
            </header>
        );
    };

    const footer = () => {
        return (
            <footer className="flex justify-center py-3 opacity-50">
                <div>Footer</div>
            </footer>
        );
    };

    return (
        <div className="flex flex-col h-screen w-screen bg-darker">
            {header()}
            <div className="grow flex justify-center">{children}</div>
            {footer()}
        </div>
    );
}
