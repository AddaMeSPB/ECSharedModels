import Foundation
import BSON

//// MARK: - Pass
//public struct WalletPassModel: Codable {
//
//    static public var collectionName = "wallet_passes"
//
//    public init(
//        _id: ObjectId,
//        formatVersion: Int,
//        passTypeIdentifier: String = "pass.cardify.addame.com",
//        serialNumber: String,
//        webServiceURL: String,
//        authenticationToken: String,
//        teamIdentifier: String = "",
//        locations: [Location]? = nil,
//        barcode: Barcode,
//        organizationName: String,
//        description: String? = nil,
//        logoText: String,
//        foregroundColor: String,
//        backgroundColor: String,
//        generic: Generic
//    ) {
//        self._id = _id
//        self.formatVersion = formatVersion
//        self.passTypeIdentifier = passTypeIdentifier
//        self.serialNumber = serialNumber
//        self.webServiceURL = webServiceURL
//        self.authenticationToken = authenticationToken
//        self.teamIdentifier = teamIdentifier
//        self.locations = locations
//        self.barcode = barcode
//        self.organizationName = organizationName
//        self.description = description
//        self.logoText = logoText
//        self.foregroundColor = foregroundColor
//        self.backgroundColor = backgroundColor
//        self.generic = generic
//    }
//
//    public var _id: ObjectId
//    public var formatVersion: Int
//    public var passTypeIdentifier, serialNumber: String
//    public var webServiceURL: String
//    public var authenticationToken, teamIdentifier: String
//    public var locations: [Location]?
//    public var barcode: Barcode
//    public var organizationName, logoText: String
//    public var description: String?
//    public var backgroundColor, foregroundColor: String
//    public var generic: Generic
//}
//
//extension WalletPassModel: Equatable {
//    public static func == (lhs: WalletPassModel, rhs: WalletPassModel) -> Bool {
//        return lhs._id == rhs._id &&
//            lhs.formatVersion == rhs.formatVersion &&
//            lhs.passTypeIdentifier == rhs.passTypeIdentifier &&
//            lhs.serialNumber == rhs.serialNumber &&
//            lhs.webServiceURL == rhs.webServiceURL &&
//            lhs.authenticationToken == rhs.authenticationToken &&
//            lhs.teamIdentifier == rhs.teamIdentifier &&
//            lhs.locations == rhs.locations &&
//            lhs.barcode == rhs.barcode &&
//            lhs.organizationName == rhs.organizationName &&
//            lhs.description == rhs.description &&
//            lhs.backgroundColor == rhs.backgroundColor &&
//            lhs.foregroundColor == rhs.foregroundColor &&
//            lhs.generic == rhs.generic
//    }
//}
//
//// MARK: - Barcode
//public struct Barcode: Codable {
//
//    public var message, format, messageEncoding: String
//
//    public init(message: String, format: String, messageEncoding: String) {
//        self.message = message
//        self.format = format
//        self.messageEncoding = messageEncoding
//    }
//
//}
//
//extension Barcode: Equatable {
//    public static func == (lhs: Barcode, rhs: Barcode) -> Bool {
//        return lhs.message == rhs.message
//            && lhs.format == rhs.format
//            && lhs.messageEncoding == rhs.messageEncoding
//    }
//}
//
//
//// MARK: - Generic
//public struct Generic: Codable {
//    public init(
//        _id: ObjectId,
//        primaryFields: [PrimaryField],
//        secondaryFields: [AryField],
//        auxiliaryFields: [AryField],
//        backFields: [BackField]
//    ) {
//        self._id = _id
//        self.primaryFields = primaryFields
//        self.secondaryFields = secondaryFields
//        self.auxiliaryFields = auxiliaryFields
//        self.backFields = backFields
//    }
//
//    public var _id: ObjectId
//    public var primaryFields: [PrimaryField]
//    public var secondaryFields, auxiliaryFields: [AryField]
//    public var backFields: [BackField]
//}
//
//extension Generic: Equatable {
//    public static func == (lhs: Generic, rhs: Generic) -> Bool {
//        return lhs._id == rhs._id
//            && lhs.primaryFields == rhs.primaryFields
//            && lhs.secondaryFields == rhs.secondaryFields
//            && lhs.auxiliaryFields == rhs.auxiliaryFields
//            && lhs.backFields == rhs.backFields
//    }
//}
//
//// MARK: - AryField
//public struct AryField: Codable, Identifiable {
//    public init(key: String, label: String, value: String, textAlignment: String? = nil) {
//        self.key = key
//        self.label = label
//        self.value = value
//        self.textAlignment = textAlignment
//    }
//
//    public var id: String {
//        self.value
//    }
//    public var key, label, value: String
//    public var textAlignment: String?
//}
//
//extension AryField: Equatable {
//    public static func == (lhs: AryField, rhs: AryField) -> Bool {
//        return lhs.key == rhs.key
//            && lhs.label == rhs.label
//            && lhs.value == rhs.value
//            && lhs.textAlignment == rhs.textAlignment
//    }
//}
//
//// MARK: - BackField
//public struct BackField: Codable {
//    public init(
//        _id: ObjectId,
//        numberStyle: String? = nil,
//        label: String,
//        key: String,
//        value: Value,
//        currencyCode: String? = nil,
//        dateStyle: String? = nil,
//        timeStyle: String? = nil,
//        isRelative: Bool? = nil
//    ) {
//        self._id = _id
//        self.numberStyle = numberStyle
//        self.label = label
//        self.key = key
//        self.value = value
//        self.currencyCode = currencyCode
//        self.dateStyle = dateStyle
//        self.timeStyle = timeStyle
//        self.isRelative = isRelative
//    }
//
//    var _id: ObjectId
//    var numberStyle: String?
//    var label: String
//    var key: String
//    var value: Value
//    var currencyCode, dateStyle, timeStyle: String?
//    var isRelative: Bool?
//}
//
//extension BackField: Identifiable {
//    public var id: String {
//        self._id.hexString
//    }
//}
//
//extension BackField: Equatable {
//    public static func == (lhs: BackField, rhs: BackField) -> Bool {
//        return lhs._id == rhs._id
//            && lhs.numberStyle == rhs.numberStyle
//            && lhs.label == rhs.label
//            && lhs.key == rhs.key
//            && lhs.value == rhs.value
//            && lhs.currencyCode == rhs.currencyCode
//            && lhs.dateStyle == rhs.dateStyle
//            && lhs.timeStyle == rhs.timeStyle
//            && lhs.isRelative == rhs.isRelative
//    }
//}
//
//public enum Value: Codable {
//    case integer(Int)
//    case string(String)
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Int.self) {
//            self = .integer(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .integer(let x):
//            try container.encode(x)
//        case .string(let x):
//            try container.encode(x)
//        }
//    }
//}
//
//extension Value: Equatable {
//    public static func == (lhs: Value, rhs: Value) -> Bool {
//        switch (lhs, rhs) {
//        case (.integer(let lhsValue), .integer(let rhsValue)):
//            return lhsValue == rhsValue
//        case (.string(let lhsValue), .string(let rhsValue)):
//            return lhsValue == rhsValue
//        default:
//            return false
//        }
//    }
//}
//
//// MARK: - PrimaryField
//public struct PrimaryField: Codable, Identifiable {
//    public var id: String {
//        self.value
//    }
//    public var key, value: String
//}
//
//extension PrimaryField: Equatable {
//    public static func == (lhs: PrimaryField, rhs: PrimaryField) -> Bool {
//        return lhs.key == rhs.key && lhs.value == rhs.value
//    }
//}
//
//// MARK: - Location
//public struct Location: Codable, Identifiable {
//
//    public init(longitude: Double, latitude: Double) {
//        self.longitude = longitude
//        self.latitude = latitude
//    }
//
//    public var id: String {
//        return "\(self.latitude)\(longitude)"
//    }
//
//    public var longitude, latitude: Double
//}
//
//extension Location: Equatable {
//    public static func == (lhs: Location, rhs: Location) -> Bool {
//        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
//    }
//}
//
//extension WalletPassModel {
//
//    static public var walletPass = WalletPassModel(
//        _id: .init(),
//        formatVersion: 1,
//        passTypeIdentifier: "pass.com.apple.devpubs.example",
//        serialNumber: "8j23fm3",
//        webServiceURL: "https://addame.com/passes/",
//        authenticationToken: "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",
//        teamIdentifier: "A93A5CM278",
//        locations: [
//            Location(longitude: -122.3748889, latitude: 37.6189722),
//            Location(longitude: -122.03118, latitude: 37.33182)
//        ],
//        barcode: Barcode(message: "123456789", format: "PKBarcodeFormatPDF417", messageEncoding: "iso-8859-1"),
//        organizationName: "Toy Town",
//        description: "Toy Town Membership",
//        logoText: "Toy Town",
//        foregroundColor: "rgb(255, 255, 255)",
//        backgroundColor: "rgb(197, 31, 31)",
//        generic: Generic(
//            _id: .init(),
//            primaryFields: [
//                PrimaryField(key: "member", value: "Johnny Appleseed")
//            ],
//            secondaryFields: [
//                AryField(key: "subtitle", label: "MEMBER SINCE", value: "2012")
//            ],
//            auxiliaryFields: [
//                AryField(key: "level", label: "LEVEL", value: "Platinum"),
//                AryField(key: "favorite", label: "FAVORITE TOY", value: "Bucky Ball Magnets", textAlignment: "PKTextAlignmentRight")
//            ],
//            backFields: [
//                BackField(_id: .init(), numberStyle: "PKNumberStyleSpellOut", label: "spelled out", key: "numberStyle", value: .integer(200)),
//                BackField(_id: .init(), label: "in Reals", key: "currency", value: .integer(200), currencyCode: "BRL"),
//                BackField(_id: .init(), numberStyle: "PKDateStyleFull", label: "full date", key: "dateFull", value: .string("1980-05-07T10:00-05:00")),
//                BackField(_id: .init(), label: "full time", key: "timeFull", value: .string("1980-05-07T10:00-05:00"), timeStyle: "PKDateStyleFull"),
//                BackField(_id: .init(), numberStyle: "PKDateStyleShort", label: "short date and time", key: "dateTime", value: .string("1980-05-07T10:00-05:00"), currencyCode: "PKDateStyleShort"),
//                BackField(_id: .init(), numberStyle: "PKDateStyleShort", label: "relative date", key: "relStyle", value: .string("2013-04-24T10:00-05:00"))
//            ]
//        )
//    )
//
//}
//
