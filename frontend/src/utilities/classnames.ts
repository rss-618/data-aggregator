export default function classnames(...args: string[]): string {
    return args
        .filter((string) => {
            return string.trim().length !== 0;
        })
        .join(' ');
}
