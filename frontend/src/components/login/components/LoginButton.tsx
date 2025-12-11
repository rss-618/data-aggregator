import classnames from '../../../utilities/classnames.ts';
import type { ButtonHTMLAttributes } from 'react';

export default function LoginButton({
    ...others
}: ButtonHTMLAttributes<HTMLButtonElement>) {
    return (
        <button
            {...others}
            className={classnames(
                'flex p-1 px-3 rounded-3xl border-[1px] border-blue bg-blue-500',
                'not-disabled:hover:border-gray-300 not-disabled:active:bg-blue-700 ',
                'disabled:bg-gray-600 disabled:border-gray-600'
            )}
        >
            login
        </button>
    );
}
