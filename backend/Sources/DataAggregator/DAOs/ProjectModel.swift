import Fluent
import Foundation

final class ProjectModel: Model, @unchecked Sendable {
    static let schema = "project"
        
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "description")
    var description: String
    @Enum(key: "project_type")
    var projectType: PlatformType
    @Timestamp(key: "created", on: .create, format: .unix)
    var created: Date?
    @Timestamp(key: "last_updated", on: .update, format: .unix)
    var lastUpdated: Date?
    @Siblings(
        through: ProjectUserPivotTable.self,
        from: \.$project,
        to: \.$user
    )
    var users: [UserModel]
    
    init() {}
    
    init(
        id: UUID? = nil,
        name: String,
        description: String,
        projectType: PlatformType,
        created: Date? = nil,
        lastUpdated: Date? = nil,
        users: [UserModel]? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.projectType = projectType
        self.created = created
        self.lastUpdated = lastUpdated
        self.$users.value = users
    }
    
}
