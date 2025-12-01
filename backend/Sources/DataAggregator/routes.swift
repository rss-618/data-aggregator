import Fluent
import Vapor
import JWT

func routes(_ app: Application) throws {
    // MARK: Sessioned
    let sessioned = app.grouped(app.sessions.middleware, UserModel.sessionAuthenticator())
    // Auth Controller
    try sessioned.register(collection: SessionedAuthenticationController())
    // Protected Frontend
    let protectedFrontend = sessioned.grouped(
        UserModel.guardMiddleware()
    )
    try protectedFrontend.register(collection: EventController())
    try protectedFrontend.register(collection: ProjectController())
    
    // MARK: Sessionless
//    let sessionless = app
    

}

