import Fluent
import Vapor

struct EventController: RouteCollection {
    
    let repository: EventRepository
    
    public init(repository: EventRepository) {
        self.repository = repository
    }
    
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("events")
        
        events.get("", use: getAll)
        events.post("add", use: add)
        events.put("update", use: update)
        events.delete("delete", use: delete)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Event] {
        return try await repository.getAll(req.db)
    }
    
    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        try await repository.add(req.content.decode(AddEventRequest.self), database: req.db)
        return .ok
    }
    
    @Sendable
    func update(_ req: Request) async throws -> HTTPStatus {
        let content = try req.content.decode(UpdateEventRequest.self)
        try await repository.update(content, database: req.db)
        return .ok
    }
    
    @Sendable
    func delete(_ req: Request) async throws -> HTTPStatus {
        guard let uuid = try? req.query.get(UUID.self, at: "id") else {
            throw Abort(.badRequest)
        }
        try await repository.delete(uuid, database: req.db)
        return .ok
    }
    
}
