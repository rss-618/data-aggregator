import Fluent
import Vapor

open class ProjectRepository: @unchecked Sendable {

    public static let `default`: ProjectRepository = .init()
    
    func find(_ id: UUID, database: any Database) async throws -> ProjectModel? {
        try await ProjectModel
            .query(on: database)
            .filter(\.$id == id)
            .first()
    }
    
    func getAll(_ database: any Database) async throws -> [Project] {
        try await ProjectModel
            .query(on: database)
            .all()
            .map { .init($0) }
    }

    func add(_ request: AddProjectRequest, database: any Database) async throws {
        try await ProjectModel(
            name: request.name,
            description: request.description,
            projectType: request.projectType,
        )
        .save(on: database)
    }
    
    func delete(_ id: UUID, database: any Database) async throws {
        guard let item = try await find(id, database: database) else {
            throw Abort(.badRequest)
        }
        try await item.delete(on: database)
    }
}

