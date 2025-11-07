import Vapor

struct AddEventRequest: Content {
    var parameter: String
    var value: String
    
    init(parameter: String, value: String) {
        self.parameter = parameter
        self.value = value
    }
}
