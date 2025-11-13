import type { ChangeEvent } from 'react';
import './CustomInput.css';

type InputProps = {
    title: string;
    onChange: (value: string) => void;
};

export default function CustomInput({ title, onChange }: InputProps) {
    const inputChange = (e: ChangeEvent<HTMLInputElement>) => {
        onChange(e.target.value);
    };
    return (
        <input
            className="card-background"
            placeholder={title}
            onChange={inputChange}
        />
    );
}
