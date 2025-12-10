export const LoadingStage = {
    IDLE: 'idle',
    LOADING: 'loading',
    SUCCESS: 'success',
    ERROR: 'error',
} as const;

export type LoadingStage = (typeof LoadingStage)[keyof typeof LoadingStage];
