import Vapor

struct ClientTokenResponse: Content {
    var accessToken: String
    var refreshToken: String
}
