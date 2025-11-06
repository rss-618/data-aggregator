import Fluent
import Vapor

struct EventController: RouteCollection {
    
    let repository: EventRepository
    
    public init(repository: EventRepository) {
        self.repository = repository
    }
    
    // Link things
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("events")
        
        events.get("", use: getAll)
        events.post("", use: add)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Event] {
        return try await repository.getAll(req.db)
    }

    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        let eventModel: EventModel = .init(try req.content.decode(Event.self))
        return try await repository.add(eventModel,
                                        database: req.db)
    }
    
}
