import Fluent
import Vapor

struct ProjectController: RouteCollection {
    
    let repository: ProjectRepository
    
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("projects")
        
        events.get("all", use: getAll)
        events.post("add", use: add)
        events.delete("delete", use: delete)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Project] {
        return try await repository.getAll(req.db)
    }
    
    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        try await repository.add(req.content.decode(AddProjectRequest.self), database: req.db)
        return .ok
    }
    
    @Sendable
    func find(_ req: Request) async throws -> Project {
        guard let uuid = try? req.query.get(UUID.self, at: "id"),
        let project = try await repository.find(uuid, database: req.db)
        else {
            throw Abort(.badRequest)
        }
        return .init(project)
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
