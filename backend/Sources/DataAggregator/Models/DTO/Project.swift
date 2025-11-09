import Vapor

struct Project: Content {
    var id: UUID?
    var name: String
    var description: String
    var projectType: PlatformType
    var created: Date?
    var lastUpdated: Date?
    
    init(
        id: UUID?,
        name: String,
        description: String,
        projectType: PlatformType,
        created: Date?,
        lastUpdated: Date?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.projectType = projectType
        self.created = created
        self.lastUpdated = lastUpdated
    }
    
    init(_ table: ProjectModel) {
        self.init(
            id: table.id,
            name: table.name,
            description: table.description,
            projectType: table.projectType,
            created: table.created,
            lastUpdated: table.lastUpdated
        )
    }
}
