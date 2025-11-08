import Fluent

protocol ProjectRepository: Sendable {
    func find(_ id: UUID, on database: any Database) async throws -> ProjectModel?
    func getAll(on database: any Database) async throws -> [ProjectModel]
    func add(_ model: ProjectModel, on database: any Database) async throws
    func delete(_ id: UUID, on database: any Database) async throws
}

