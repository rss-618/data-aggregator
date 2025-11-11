import {useCoordinator} from "../../context/contexts.tsx";

export default function Home() {

    const coordinator = useCoordinator();

    return (
        <>
            <p>
                I'm a home page
            </p>
            <button onClick={coordinator.logout}>
                logout
            </button>
        </>
    )
}