import Fluent
import Vapor
import Dependencies

struct EventController: RouteCollection {
    
    @Dependency(\.service) var service
    
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("events")
        
        events.get("all", use: getAll)
        events.post("add", use: add)
        events.put("update", use: update)
        events.delete("delete", use: delete)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Event] {
        return try await service.event.getAllDisplayEvents(on: req.db)
    }
    
    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        try await service.event.addEvent(
            event: req.content.decode(AddEventRequest.self),
            on: req.db
        )
        return .ok
    }
    
    @Sendable
    func update(_ req: Request) async throws -> HTTPStatus {
        try await service.event.updateEvent(
            request: req.content.decode(UpdateEventRequest.self),
            on: req.db
        )
        return .ok
    }
    
    @Sendable
    func delete(_ req: Request) async throws -> HTTPStatus {
        try await service.event.deleteEvent(
            id: req.query.get(UUID.self, at: "id"),
            on: req.db
        )
        return .ok
    }
    
}
