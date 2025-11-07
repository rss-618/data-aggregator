import Fluent

struct CreateDeviceTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(DeviceModel.schema)
            .id()
            .field("device_identifier", .string, .required)
            .field("device_version", .string, .required)
            .field("device_type", .string)
            .field("added", .double)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(DeviceModel.schema).delete()
    }
}
