import { type InputHTMLAttributes, type KeyboardEventHandler } from 'react';
import './CustomInput.css';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
    onEnter?: () => void;
}

export default function CustomInput({ onEnter, ...others }: InputProps) {
    const keyPressHandler: KeyboardEventHandler = (e) => {
        if (onEnter && e.key == 'Enter') {
            onEnter();
        }
    };
    return (
        <input
            className="card-background"
            {...others}
            onKeyDown={keyPressHandler}
        />
    );
}
