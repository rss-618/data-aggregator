export default function createPublisher<ParamValue>() {
    type Event = (input: ParamValue) => void;
    const events: Set<Event> = new Set();
    return {
        // Send an event to a subscriber
        emit: (value: ParamValue) => {
            for (const event of events) {
                event(value);
            }
        },
        // Define a subscriber
        subscribe: (callback: Event) => {
            events.add(callback);
        },
        // Unsubscribe from pub-sub
        unsubscribe: (callback: Event) => {
            events.delete(callback);
        },
    };
}
