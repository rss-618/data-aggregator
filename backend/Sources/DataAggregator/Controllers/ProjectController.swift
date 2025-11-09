import Dependencies
import Fluent
import Vapor

struct ProjectController: RouteCollection {
    
    @Dependency(\.service) var service
        
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("project")
        
        events.get("all") { req in
            return try await service.project.getAllDisplayProjects(on: req.db)
        }
        
        events.post { req in
            try await service.project.add(
                req.content.decode(AddProjectRequest.self),
                on: req.db
            )
            return HTTPStatus.ok
        }
        
        events.get("", ":id") { req in
            guard let uuidString = req.parameters.get("id"),
                  let id = UUID(uuidString: uuidString) else {
                throw Abort(.badRequest)
            }
            return try await service.project.find(id, on: req.db)
        }
        
        events.delete("", ":id") { req in
            guard let uuidString = req.parameters.get("id"),
                  let id = UUID(uuidString: uuidString) else {
                throw Abort(.badRequest)
            }
            try await service.project.delete(id, on: req.db)
            return HTTPStatus.ok
        }
    }
    
}
