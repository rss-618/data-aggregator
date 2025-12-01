import Vapor

extension SessionData {
    
    static let expirationKey: String = "_vapor_session_expiration"
    
    var expiration: Date? {
        get {
            guard let data = self[Self.expirationKey], let date = try? Date(data, strategy: .dateTime) else {
                return nil
            }
            return date
        }
        set {
            self[Self.expirationKey] = if let newValue {
                "\(newValue)"
            } else {
                nil
            }
        }
    }
    
    var isExpired: Bool {
        guard let expiration else {
            return true
        }
        return expiration < Date()
    }
}
