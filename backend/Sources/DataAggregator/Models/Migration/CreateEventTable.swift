import Fluent

struct CreateEventTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(EventModel.schema)
            .id()
            .field("project_id", .uuid, .required, .references(ProjectModel.schema, "id"))
            .field("device_id", .uuid, .references(DeviceModel.schema, "id"))
            .field("parameter", .string, .required)
            .field("value", .string, .required)
            .field("created", .double)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(EventModel.schema).delete()
    }
}
