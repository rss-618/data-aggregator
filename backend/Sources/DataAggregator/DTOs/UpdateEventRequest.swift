import Vapor

struct UpdateEventRequest: Content {
    var id: UUID
    var parameter: String
    var value: String
    
    init(id: UUID, parameter: String, value: String) {
        self.id = id
        self.parameter = parameter
        self.value = value
    }
}
