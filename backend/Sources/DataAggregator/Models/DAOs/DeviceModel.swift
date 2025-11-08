import Fluent
import Foundation

final class DeviceModel: Model, @unchecked Sendable {
    static let schema = "device"
        
    @ID(key: .id)
    var id: UUID?
    @Field(key: "device_identifier")
    var deviceIdentifier: String
    @Field(key: "device_version")
    var deviceVersion: String
    @OptionalEnum(key: "device_type")
    var deviceType: PlatformType?
    @Timestamp(key: "added", on: .create, format: .unix)
    var added: Date?

    init() { }
    
    init(
        id: UUID? = nil,
        deviceIdentifier: String,
        deviceVersion: String,
        deviceType: PlatformType? = nil,
        added: Date? = nil
    ) {
        self.id = id
        self.deviceIdentifier = deviceIdentifier
        self.deviceVersion = deviceVersion
        self.deviceType = deviceType
        self.added = added
    }
    
}
