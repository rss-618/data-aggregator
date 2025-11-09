import Vapor

extension Environment {
    
    enum ErrorType: Error {
        case missingValue(String)
        case cannotEncode
    }
    
    static func require(_ key: String) throws -> String {
        guard let value = Environment.get(key) else {
            throw ErrorType.missingValue(key)
        }
        return value
    }
    
    static func require<ReturnType: Decodable>(_ key: String, to type: ReturnType.Type) throws -> ReturnType {
        guard let data = try require(key).data(using: .utf8) else {
            throw ErrorType.cannotEncode
        }
        return try JSONDecoder().decode(type, from: data)
    }
    
}
