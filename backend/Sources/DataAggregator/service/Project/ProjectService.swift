import Fluent
import Vapor

protocol ProjectService: Sendable {
    func find(_ id: UUID, on database: any Database) async throws -> Project
    func getAllDisplayProjects(on database: any Database) async throws -> [Project]
    func add(_ request: AddProjectRequest, on database: any Database) async throws
    func delete(_ id: UUID, on database: any Database) async throws
}
