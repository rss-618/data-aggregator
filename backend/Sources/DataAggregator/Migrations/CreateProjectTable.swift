import Fluent

struct CreateProjectTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(ProjectModel.schema)
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("project_type", .string, .required)
            .field("created", .double)
            .field("last_updated", .double)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(ProjectModel.schema).delete()
    }
}
