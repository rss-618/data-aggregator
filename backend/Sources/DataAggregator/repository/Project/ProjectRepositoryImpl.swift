import Fluent
import Vapor

struct ProjectRepositoryImpl: ProjectRepository {
    
    func find(_ id: UUID, on database: any Database) async throws -> ProjectModel? {
        try await ProjectModel
            .query(on: database)
            .filter(\.$id == id)
            .first()
    }
    
    func getAll(on database: any Database) async throws -> [ProjectModel] {
        try await ProjectModel
            .query(on: database)
            .all()
    }

    func add(_ model: ProjectModel, on database: any Database) async throws {
        try await model.save(on: database)
    }
    
    func delete(_ id: UUID, on database: any Database) async throws {
        guard let item = try await find(id, on: database) else {
            throw Abort(.badRequest)
        }
        try await item.delete(on: database)
    }
}

