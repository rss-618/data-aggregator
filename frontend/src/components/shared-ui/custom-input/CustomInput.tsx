import { type InputHTMLAttributes, type KeyboardEventHandler } from 'react';
import './CustomInput.css';
import classnames from '../../../utilities/classnames.ts';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
    onEnter?: () => void;
    errorText?: string;
}

export default function CustomInput({
    onEnter,
    errorText,
    ...others
}: InputProps) {
    const keyPressHandler: KeyboardEventHandler = (e) => {
        if (onEnter && e.key == 'Enter') {
            onEnter();
        }
    };

    const canShowErrorText = errorText !== undefined && errorText.length > 0;

    return (
        <div className={'flex flex-col space-y-2'}>
            <input
                className={classnames(
                    'flex input',
                    canShowErrorText ? 'error' : ''
                )}
                {...others}
                onKeyDown={keyPressHandler}
            />

            <div
                className={classnames(
                    'flex text-xs error',
                    errorText ? 'gone' : '',
                    canShowErrorText ? '' : 'invisible'
                )}
            >
                {errorText}&#10240;
            </div>
        </div>
    );
}
