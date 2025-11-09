import Fluent
import Dependencies
import Vapor

struct EventRepositoryImpl: EventRepository {
        
    enum EventRepositoryError: Error {
        case invalidSearch
    }
    
    func getAll(on database: any Database) async throws -> [EventModel] {
        try await EventModel
            .query(on: database)
            .all()
    }

    func add(_ request: EventModel, on database: any Database) async throws {
        try await request.save(on: database)
    }
    
    func find(_ id: UUID, on database: any Database) async throws -> EventModel? {
        try await database
            .query(EventModel.self)
            .filter(\.$id == id)
            .first()
    }
    
    func update(_ content: EventModel, on database: any Database) async throws {
        try await content.update(on: database)
    }
    
    func delete(_ id: UUID, on database: any Database) async throws {
        guard let event = try await find(id, on: database) else {
            throw Abort(.notFound)
        }
        try await event.delete(on: database)
    }
}
