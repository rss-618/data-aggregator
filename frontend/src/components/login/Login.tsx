import CustomInput from '../shared-ui/custom-input/CustomInput.tsx';
import { useState } from 'react';
import { useCoordinator } from '../../context/coordinator/useCoordinator.tsx';
import { LoadingStage } from '../../types/utility/LoadingStage.type.ts';
import { ApiClient } from '../../api/ApiClient.ts';
import LoginButton from './components/LoginButton.tsx';
import Localizable from '../../resources/Localizable.ts';

export default function Login() {
    const coordinator = useCoordinator();

    // TODO: make a reducer this is kinda annoying to look at
    const [loginStage, setLoginStage] = useState<LoadingStage>();

    const [username, setUsername] = useState<string>('');
    const [password, setPassword] = useState<string>('');

    const [usernameErrorText, setUsernameErrorText] = useState<string>('');
    const [passwordErrorText, setPasswordErrorText] = useState<string>('');

    const clearErrors = () => {
        setLoginStage(LoadingStage.IDLE);
        setUsernameErrorText('');
        setUsernameErrorText('');
    };

    const validateInputs = () => {
        if (username.length == 0) {
            setUsernameErrorText(Localizable.usernameEmptyError);
        }

        if (password.length == 0) {
            setPasswordErrorText(Localizable.passwordEmptyError);
        }
    };

    const hasValidInputs = () => {
        return username.length > 0 && password.length > 0;
    };

    const login = async () => {
        if (loginStage === LoadingStage.LOADING) {
            return;
        }
        clearErrors();
        setLoginStage(LoadingStage.LOADING);
        validateInputs();
        if (!hasValidInputs()) {
            setLoginStage(LoadingStage.ERROR);
            return;
        }

        try {
            const user = await ApiClient.login({ username, password });
            coordinator.login(user);
        } catch {
            setLoginStage(LoadingStage.ERROR);
        }
    };

    return (
        <div className="flex flex-col space-y-3 content-center">
            <div className={'flex flex-col space-y-1'}>
                <h1>{Localizable.welcomeTitle}</h1>
                <p>{Localizable.pleaseEnterCredentials} &#128539;</p>
            </div>

            <div className="flex flex-col space-y-[8px]">
                <CustomInput
                    placeholder="Username"
                    value={username}
                    onChange={(event) => {
                        setUsername(event.target.value);
                    }}
                    onFocus={() => setUsernameErrorText('')}
                    errorText={usernameErrorText}
                />
                <CustomInput
                    placeholder="Password"
                    value={password}
                    onChange={(event) => {
                        setPassword(event.target.value);
                    }}
                    onEnter={login}
                    onFocus={() => setPasswordErrorText('')}
                    errorText={passwordErrorText}
                />
            </div>
            <div className={'flex justify-center'}>
                <LoginButton
                    onClick={login}
                    disabled={loginStage === LoadingStage.LOADING}
                />
            </div>
        </div>
    );
}
