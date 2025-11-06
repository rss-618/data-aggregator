import Fluent
import Vapor

struct Event: Content {
    var id: UUID?
    var parameter: String
    var value: String
    
    init(id: UUID? = nil, parameter: String, value: String) {
        self.id = id
        self.parameter = parameter
        self.value = value
    }
    
    init(_ eventModel: EventModel) {
        self.init(id: eventModel.id, parameter: eventModel.parameter, value: eventModel.value)
    }
}
