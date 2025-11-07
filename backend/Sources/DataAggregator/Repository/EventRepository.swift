import Fluent
import Vapor

open class EventRepository: @unchecked Sendable {
    
    enum EventRepositoryError: Error {
        case invalidSearch
    }
    
    public static let `default`: EventRepository = .init()
    
    func getAll(_ database: any Database) async throws -> [Event] {
        try await EventModel
            .query(on: database)
            .all()
            .map { .init($0) }
    }

    func add(_ request: AddEventRequest, database: any Database) async throws {
        // TODO: create service layer between repo and controller so i dont need to link repos directly
        guard let project = try await ProjectRepository.default.find(request.projectId, database: database) else {
            throw Abort(.badRequest)
        }
        try await EventModel(
            project: project,
            parameter: request.parameter,
            value: request.value
        )
        .save(on: database)
    }
    
    func find(_ id: UUID, database: any Database) async throws -> EventModel? {
        try await database
            .query(EventModel.self)
            .filter(\.$id == id)
            .first()
    }
    
    func update(_ content: UpdateEventRequest, database: any Database) async throws {
        guard let foundItem = try await find(content.id, database: database) else {
            throw Abort(.badRequest)
        }
        foundItem.parameter = content.parameter
        foundItem.value = content.value
        try await foundItem.update(on: database)
    }
    
    func delete(_ id: UUID, database: any Database) async throws {
        guard let item = try await find(id, database: database) else {
            throw Abort(.badRequest)
        }
        try await item.delete(on: database)
    }
}
