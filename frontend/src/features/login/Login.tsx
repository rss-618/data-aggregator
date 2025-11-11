import {useCoordinator} from "../../context/contexts.tsx";

export default function Login() {

    const coordinator = useCoordinator()

    const login = () => {

        coordinator.login({
            userName: "ryan",
            lastName: "schild"
        })
    }
    return (
        <>
            <h1>
                I'm a login page
                WANAGI EATS BUTT
                <button onClick={login}>
                    logine
                </button>
            </h1>
        </>
    )
}