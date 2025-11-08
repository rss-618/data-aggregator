import Vapor
import Fluent
import Dependencies

struct EventServiceImpl: EventService {
    
    @Dependency(\.repository) var repository
    
    func getAllDisplayEvents(on database: any Database) async throws -> [Event] {
        return try await repository.event
            .getAll(on: database)
            .map { .init($0) }
    }
    
    func addEvent(event: AddEventRequest, on database: any Database) async throws {
        guard let project = try await repository.project.find(event.projectId, on: database) else {
            throw Abort(.notFound)
        }
        try await repository.event.add(
            .init(project: project,
                  parameter: event.parameter,
                  value: event.value),
            on: database
        )
    }
    
    func updateEvent(request: UpdateEventRequest, on database: any Database) async throws {
        guard let event = try await repository.event.find(request.id, on: database) else {
            throw Abort(.notFound)
        }
        event.parameter = request.parameter
        event.value = request.value
        try await repository.event.update(event, on: database)
    }
    
    func deleteEvent(id: UUID, on database: any Database) async throws {
        try await repository.event.delete(id, on: database)
    }
    
    
}
