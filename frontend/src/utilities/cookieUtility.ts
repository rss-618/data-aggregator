export default {
    getSessionId: async () => {
        await cookieStore.get('daggregator_session');
    },
    clearSessionId: async () => {
        await cookieStore.delete('daggregator_session');
    },
};
