import type { ChangeEvent } from 'react';
import './CustomInput.css';

type InputProps = {
    title: string;
    onChange: (value: string) => void;
    onFocus?: () => void;
};

export default function CustomInput({ title, onChange, onFocus }: InputProps) {
    const inputChange = (e: ChangeEvent<HTMLInputElement>) => {
        onChange(e.target.value);
    };
    return (
        <input
            className="card-background"
            placeholder={title}
            onChange={inputChange}
            onFocus={onFocus}
        />
    );
}
