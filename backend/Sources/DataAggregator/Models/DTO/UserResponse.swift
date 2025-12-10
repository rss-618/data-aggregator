import Foundation
import Vapor

struct UserResponse: Content {
    let username: String
    let firstName: String?
    let lastName: String?
    
    init(username: String, firstName: String?, lastName: String?) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
    init(_ model: UserModel) {
        self.init(username: model.username, firstName: model.firstName, lastName: model.lastName)
    }
}
