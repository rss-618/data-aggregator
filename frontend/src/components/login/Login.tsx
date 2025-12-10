import CustomInput from '../shared-ui/custom-input/CustomInput.tsx';
import { useState } from 'react';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';
import { LoadingStage } from '../../types/utility/LoadingStage.type.ts';
import classnames from '../../utilities/classnames.ts';
import { ApiClient } from '../../api/ApiClient.ts';

export default function Login() {
    const coordinator = useCoordinator();

    const [loginStage, setLoginStage] = useState<LoadingStage>();

    const [username, setUsername] = useState<string>('');
    const [password, setPassword] = useState<string>('');

    const login = async () => {
        try {
            setLoginStage(LoadingStage.LOADING);
            const user = await ApiClient.login({ username, password });
            coordinator.login(user);
        } catch {
            setLoginStage(LoadingStage.ERROR);
        }
    };

    const onFocus = () => {
        setLoginStage(LoadingStage.IDLE);
    };

    const classNames = classnames();
    return (
        <div className="flex flex-col space-x-1 content-center">
            <h1>I'm a login page WANAGI EATS BUTT</h1>

            <div className="flex flex-col space-y-[8px]">
                <CustomInput
                    title="Username"
                    onChange={setUsername}
                    onFocus={onFocus}
                />
                <CustomInput
                    title="Password"
                    onChange={setPassword}
                    onFocus={onFocus}
                />
            </div>
            <button onClick={login} className={classNames}>
                logine
            </button>
        </div>
    );
}
