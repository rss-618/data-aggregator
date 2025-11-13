export const PageRoute = {
    Login: '/login',
    Home: '/',
    NotFound: '*',
    Unauthorized: '/unauthorized',
};
export type PageRoute = (typeof PageRoute)[keyof typeof PageRoute];
