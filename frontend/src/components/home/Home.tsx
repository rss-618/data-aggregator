import { useSession } from '../../context/session/useSession.tsx';

export default function Home() {
    const session = useSession();
    const username = session.model?.user?.userName;
    return (
        <div className="w-max flex flex-col">
            <p>I'm a home page</p>
            <div>Hello {username}</div>
        </div>
    );
}
