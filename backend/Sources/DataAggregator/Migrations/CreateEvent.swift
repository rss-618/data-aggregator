import Fluent

struct CreateEvent: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(EventModel.schema)
            .id()
            .field("parameter", .string, .required)
            .field("value", .string, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(EventModel.schema).delete()
    }
}
