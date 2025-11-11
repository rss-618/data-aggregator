import './App.css'
import {SessionProvider} from "../context/SessionProvider.tsx";
import Router from "../navigation/Router.tsx";

export default function App() {
    return (
        <>
            <SessionProvider>
                <Router/>
            </SessionProvider>
        </>
    )
}
