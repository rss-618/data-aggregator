import Vapor
import Fluent

struct Encryptor: Sendable {
    static let provider: Application.Passwords.Provider = .bcrypt
    typealias Hasher = BCryptDigest
}
