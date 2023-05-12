import Foundation
import BSON

public struct DeviceModel: Codable {

    public static var collectionName = "devices"

    public init(
        _id: ObjectId,
        identifierForVendor: String? = nil,
        name: String,
        model: String? = nil,
        osVersion: String? = nil,
        pushToken: String,
        voipToken: String,
        ownerId: ObjectId?
    ) {
        self._id = _id
        self.identifierForVendor = identifierForVendor
        self.name = name
        self.model = model
        self.osVersion = osVersion
        self.pushToken = pushToken
        self.voipToken = voipToken
        self.ownerId = ownerId
    }

    public var _id: ObjectId
    public var identifierForVendor: String?
    public var name: String
    public var model: String?
    public var osVersion: String?
    public var pushToken: String
    public var voipToken: String
    public var ownerId: ObjectId?

    public var createdAt: Date?
    public var updatedAt: Date?

    public func toBSON() throws -> Document {
        let encoder = BSONEncoder()
        let bson = try encoder.encode(self)
        return bson
    }

}

extension DeviceModel: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs._id == rhs._id
        && lhs.pushToken == rhs.pushToken
        && lhs.voipToken == rhs.voipToken
        && lhs.createdAt == rhs.createdAt
        && lhs.updatedAt == rhs.updatedAt
    }
}

extension DeviceModel {
    public func mapGet() -> DeviceOutPut {
        return .init(
            id: self._id,
            ownerId: self.ownerId,
            identifierForVendor: self.identifierForVendor,
            name: self.name,
            model: self.model,
            osVersion: self.osVersion,
            pushToken: self.pushToken,
            voipToken: self.voipToken,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
}

public struct DeviceOutPut: Codable, Equatable, Hashable, Identifiable {
    public var id: ObjectId
    public var ownerId: ObjectId?
    public var identifierForVendor: String?
    public var name: String
    public var model: String?
    public var osVersion: String?
    public var pushToken: String
    public var voipToken: String
    public var createdAt, updatedAt: Date?
    
    public init(
        id: ObjectId,
        ownerId: ObjectId? = nil,
        identifierForVendor: String? = nil,
        name: String,
        model: String? = nil,
        osVersion: String? = nil,
        pushToken: String,
        voipToken: String,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.ownerId = ownerId
        self.identifierForVendor = identifierForVendor
        self.name = name
        self.model = model
        self.osVersion = osVersion
        self.pushToken = pushToken
        self.voipToken = voipToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
