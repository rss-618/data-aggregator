import Dependencies
import Fluent
import Vapor

struct ProjectController: RouteCollection {
    
    @Dependency(\.service) var service
        
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("projects")
        
        events.get("all", use: getAll)
        events.post("add", use: add)
        events.delete("delete", use: delete)
    }
    
    @Sendable
    func getAll(_ req: Request) async throws -> [Project] {
        return try await service.project.getAllDisplayProjects(on: req.db)
    }
    
    @Sendable
    func add(_ req: Request) async throws -> HTTPStatus {
        try await service.project.add(
            req.content.decode(AddProjectRequest.self),
            on: req.db
        )
        return .ok
    }
    
    @Sendable
    func find(_ req: Request) async throws -> Project {
        return try await service.project.find(
            req.query.get(UUID.self, at: "id"),
            on: req.db
        )
    }
    
    @Sendable
    func delete(_ req: Request) async throws -> HTTPStatus {
        try await service.project.delete(
            req.query.get(UUID.self, at: "id"),
            on: req.db
        )
        return .ok
    }
    
}
