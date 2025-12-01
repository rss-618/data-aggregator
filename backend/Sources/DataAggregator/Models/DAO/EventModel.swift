import Fluent
import Foundation

final class EventModel: Model, @unchecked Sendable {
    static let schema = "event"
        
    @ID(key: .id)
    var id: UUID?
    @Parent(key: "project_id")
    var project: ProjectModel
    @OptionalParent(key: "device_id")
    var device: DeviceModel?
    @Field(key: "parameter")
    var parameter: String
    @Field(key: "value")
    var value: String
    @Timestamp(key: "created", on: .create, format: .unix)
    var created: Date?
    

    init() { }

    init(
        id: UUID? = nil,
        project: ProjectModel,
        device: DeviceModel? = nil,
        parameter: String,
        value: String,
        created: Date? = nil
    ) throws {
        self.id = id
        self.$project.id = try project.requireID()
        self.$device.id = device?.id
        self.parameter = parameter
        self.value = value
        self.created = created
    }
    
}

extension EventModel {
    struct Migration: AsyncMigration {
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
}
