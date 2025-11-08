import Dependencies
import Fluent
import Vapor

struct ProjectServiceImpl: ProjectService {
    
    @Dependency(\.repository) var repository
    
    func find(_ id: UUID, on database: any Database) async throws -> Project {
        guard let project = try await repository.project.find(id, on: database) else {
            throw Abort(.notFound)
        }
        return .init(project)
    }
    func getAllDisplayProjects(on database: any Database) async throws -> [Project] {
        return try await repository.project.getAll(on: database).map { .init($0) }
    }
    func add(_ request: AddProjectRequest, on database: any Database) async throws {
        try await repository.project.add(
            ProjectModel(
                name: request.name,
                description: request.description,
                projectType: request.projectType,
            ),
            on: database
        )
    }
    func delete(_ id: UUID, on database: any Database) async throws {
        try await repository.project.delete(id, on: database)
    }
}
