import Fluent

struct CreateProjectUserPivotTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(ProjectUserPivotTable.schema)
            .id()
            .field("project_id", .uuid, .required, .references(ProjectModel.schema, "id"))
            .field("user_id", .uuid, .required, .references(UserModel.schema, "id"))
            .unique(on: "project_id", "user_id")
            .field("created", .double)
            .field("status", .string, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(ProjectUserPivotTable.schema).delete()
    }
}
