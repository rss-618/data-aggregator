import Fluent
import Vapor

struct EventController: RouteCollection {
    
    let repository: EventRepository
    
    public init(repository: EventRepository) {
        self.repository = repository
    }
    
    // Link things
    func boot(routes: any RoutesBuilder) throws {
        let todos = routes.grouped("events")
        
        if BuildConfig.shared.isDebug {
            todos.get("all", use: getAll)
        }

        todos.post("add", use: add)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Event] {
        return try await repository.getAll(req.db)
    }

    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        let eventModel = try req.content.decode(Event.self).toModel()
        return try await repository.add(eventModel,
                                        database: req.db)
    }
    
}
