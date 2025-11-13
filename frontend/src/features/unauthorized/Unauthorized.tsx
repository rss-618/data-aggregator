type UnauthorizedProps = {
    message: string;
};

Unauthorized.defaultProps = {
    message: 'You are not authorized to reach this page.',
};

export default function Unauthorized({ message }: UnauthorizedProps) {
    return (
        <div>
            <h1>Unauthorized</h1>
            <p>{message}</p>
        </div>
    );
}
