import Fluent
import Vapor

open class EventRepository: @unchecked Sendable {
    
    public static let `default`: EventRepository = .init()
    
    func getAll(_ database: any Database) async throws -> [Event] {
        try await EventModel.query(on: database).all().map { .init($0) }
    }

    func add(_ event: EventModel, database: any Database) async throws -> HTTPStatus {
        do {
            try await event.save(on: database)
        } catch {
            return .badRequest
        }
        return .ok
    }
}
