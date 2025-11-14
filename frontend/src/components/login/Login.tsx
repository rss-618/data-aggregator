import CustomInput from '../shared-ui/custom-input/CustomInput.tsx';
import { useState } from 'react';
import ProtectedRoute from '../navigation/ProtectedRoute.tsx';
import { PageRoute } from '../navigation/PageRoute.tsx';
import { useAuth } from '../../context/auth/useAuth.tsx';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';

export default function Login() {
    const auth = useAuth();
    const coordinator = useCoordinator();

    const [username, setUsername] = useState<string>('');
    const [password, setPassword] = useState<string>('');

    const login = () => {
        coordinator.login({
            userName: username,
            lastName: password,
        });
    };
    return (
        <div className="flex flex-col space-x-1 content-center">
            <h1>I'm a login page WANAGI EATS BUTT</h1>

            <div className="flex flex-col space-y-[8px]">
                <CustomInput title="Username" onChange={setUsername} />
                <CustomInput title="Password" onChange={setPassword} />
            </div>
            <button onClick={login}>logine</button>
        </div>
    );
}
