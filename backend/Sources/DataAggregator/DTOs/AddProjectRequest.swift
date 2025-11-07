import Vapor

// TODO: Add abiliity to link in users with initial add
struct AddProjectRequest: Content {
    var name: String
    var description: String
    var projectType: PlatformType
}
