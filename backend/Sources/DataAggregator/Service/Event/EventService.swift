import Fluent

protocol EventService: Sendable {
    func getAllDisplayEvents(on database: any Database) async throws -> [Event]
    func addEvent(event: AddEventRequest, on database: any Database) async throws
    func updateEvent(request: UpdateEventRequest, on database: any Database) async throws
    func deleteEvent(id: UUID, on database: any Database) async throws
}
