import Vapor

struct AddEventRequest: Content {
    var projectId: UUID
    var parameter: String
    var value: String
}
