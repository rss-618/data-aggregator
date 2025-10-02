import Fluent
import Vapor

open class EventRepository: @unchecked Sendable {
    
    public static let `default`: EventRepository = .init()
    
    func getAll(_ database: any Database) async throws -> [Event] {
        try await EventModel.query(on: database).all().map { $0.toDTO() }
    }

    func add(_ event: EventModel, database: any Database) async throws -> HTTPStatus {
        do {
            try await event.save(on: database)
        } catch {
            return .badRequest
        }
        return .ok
    }
//
//    func delete(req: Request) async throws -> HTTPStatus {
//        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
//            throw Abort(.notFound)
//        }
//
//        try await todo.delete(on: req.db)
//        return .noContent
//    }
}
