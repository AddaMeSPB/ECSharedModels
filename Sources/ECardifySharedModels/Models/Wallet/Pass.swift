import Foundation
import BSON

public struct WalletPass: Codable, Equatable {

    static public var collectionName = "wallet_passes"

    public var _id: ObjectId
    public let ownerId: ObjectId
    public let pass: Pass
    public let imageURLs: [ImageURL]
    public var createdAt: Date?
    public var updatedAt: Date?

    public init(
        _id: ObjectId,
        ownerId: ObjectId,
        pass: Pass,
        imageURLs: [ImageURL],
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self._id = _id
        self.ownerId = ownerId
        self.pass = pass
        self.imageURLs = imageURLs
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// I.e. passContents of the pass.json file
/// For all available fields and their documentation, see [this page](https://developer.apple.com/documentation/walletrpasses/pass)
public struct Pass: Codable, Equatable {
    public var formatVersion: Int
    public var passTypeIdentifier: String
    public var serialNumber: String
    public var teamIdentifier: String
    public var organizationName: String
    public var description: String
    public var logoText: String
    public var foregroundColor: String
    public var backgroundColor: String
    public var labelColor: String
    public var relevantDate: String?
    public var locations: [Location]?
    public var maxDistance: Int?
    public var barcodes: [Barcode]
    public var beacons: [Beacon]?
    public var nfc: [NFC]?
    public var appLaunchURL: String?
    public var associatedStoreIdentifiers: [Int]?
    public var authenticationToken: String?
    public var expirationDate: String?
    public var groupingIdentifier: String?
    public var sharingProhibited: Bool
    public var suppressStripShine: Bool
    public var userInfo: [String: String]?
    public var voided: Bool
    public var webServiceURL: String?
    public var coupon: PassContent?
    public var boardingPass: PassContentTransit?
    public var storeCard: PassContent?
    public var eventTicket: PassContent?
    public var generic: PassContent?

    
    public init(
        formatVersion: Int,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        organizationName: String,
        description: String,
        logoText: String,
        foregroundColor: Color = .rgb(r: 255, g: 255, b: 255),
        backgroundColor: Color = .rgb(r: 197,g: 208, b: 197),
        labelColor: Color = .rgb(r: 0, g: 0, b: 128),
        barcodes: [Barcode] = [],
        relevantDate: String? = nil,
        locations: [Location]? = nil,
        maxDistance: Int? = nil,
        beacons: [Beacon]? = nil,
        nfc: [NFC]? = nil,
        appLaunchURL: String? = nil,
        associatedStoreIdentifiers: [Int]? = nil,
        authenticationToken: String? = nil,
        expirationDate: String? = nil,
        groupingIdentifier: String? = nil,
        sharingProhibited: Bool = false,
        suppressStripShine: Bool = true,
        userInfo: [String: String]? = nil,
        voided: Bool = false,
        webServiceURL: String? = nil,
        coupon: PassContent? = nil,
        boardingPass: PassContentTransit? = nil,
        storeCard: PassContent? = nil,
        eventTicket: PassContent? = nil,
        generic: PassContent?
    ) {
        self.formatVersion = formatVersion
        self.passTypeIdentifier = passTypeIdentifier
        self.serialNumber = serialNumber
        self.teamIdentifier = teamIdentifier
        self.organizationName = organizationName
        self.foregroundColor = foregroundColor.stringForm
        self.backgroundColor = backgroundColor.stringForm
        self.labelColor = labelColor.stringForm
        self.relevantDate = relevantDate
        self.locations = locations
        self.maxDistance = maxDistance
        self.beacons = beacons
        self.nfc = nfc
        self.appLaunchURL = appLaunchURL
        self.associatedStoreIdentifiers = associatedStoreIdentifiers
        self.authenticationToken = authenticationToken
        self.expirationDate = expirationDate
        self.groupingIdentifier = groupingIdentifier
        self.sharingProhibited = sharingProhibited
        self.suppressStripShine = suppressStripShine
        self.userInfo = userInfo
        self.voided = voided
        self.webServiceURL = webServiceURL
        self.barcodes = barcodes
        self.logoText = logoText
        self.description = description
        self.coupon = coupon
        self.boardingPass = boardingPass
        self.storeCard = storeCard
        self.eventTicket = storeCard
        self.generic = generic

    }
}

extension Pass {
    public static var mock: Pass = .init(
        formatVersion: 1,
        passTypeIdentifier: "pass.ecardify.addame.com",
        serialNumber: UUID().uuidString,
        teamIdentifier: "6989658CU5",
        organizationName: "Addame",
        description: "IT Consultant",
        logoText: "Alif",
        foregroundColor: .rgb(r: 255, g: 255, b: 255),
        backgroundColor: .rgb(r: 197, g: 208, b: 197),
        labelColor: .rgb(r: 147, g: 108, b: 137),
        generic: .init(
            primaryFields: [
                .init(label: "NAME", key: "member", value: "SAROAR \nKKHANDOKER")
            ],
            secondaryFields: [
                .init(label: "POSITION", key: "position", value: "IOS Developer")
            ],
            auxiliaryFields: [
                .init(label: "PHONE", key: "mobile", value: "+351911700782"),
                .init(label: "EMAIL", key: "email", value: "saroar9@gmail.com")

            ],
            backFields: [
                .init(label: "Spelled out", key: "numberStyle", value: "200")
            ]
        )
    )

    public static var draff: Pass = .init(
        formatVersion: 1,
        passTypeIdentifier: "pass.ecardify.addame.com",
        serialNumber: UUID().uuidString,
        teamIdentifier: "6989658CU5",
        organizationName: "",
        description: "",
        logoText: "",
        foregroundColor: .rgb(r: 0, g: 0, b: 255),
        backgroundColor: .rgb(r: 255, g: 255, b: 255),
        labelColor: .rgb(r: 0, g: 0, b: 0),
        generic: .init(
            primaryFields: [
                .init(label: "NAME", key: "member", value: "")
            ],
            secondaryFields: [
                .init(label: "POSITION", key: "position", value: "")
            ],
            auxiliaryFields: [
                .init(label: "PHONE", key: "mobile", value: ""),
                .init(label: "EMAIL", key: "email", value: "")

            ],
            backFields: [
                .init(label: "Anything you want", key: "just", value: "???")
            ]
        )
    )
}

public enum AssetType: String, Codable, Equatable {
    case icon, logo, thumbnail
}

public struct ImageURL: Codable, Equatable {
    public let type: AssetType
    public let urlString: String

    public init(type: AssetType, urlString: String) {
        self.type = type
        self.urlString = urlString
    }
}

extension ImageURL {
    static public var draff: [ImageURL] = [
        .init(type: .icon, urlString: "https://learnplaygrow.ams3.digitaloceanspaces.com/uploads/images/9155F894-E500-453A-A691-6CDE8F722BDF/CECF3925-180E-4373-A15E-E7876760D18F/logo.png"),
        .init(type: .logo, urlString: "https://learnplaygrow.ams3.digitaloceanspaces.com/uploads/images/9155F894-E500-453A-A691-6CDE8F722BDF/CECF3925-180E-4373-A15E-E7876760D18F/logo.png"),
        .init(type: .thumbnail, urlString: "https://learnplaygrow.ams3.digitaloceanspaces.com/uploads/images/DC6E2827-FF38-4038-A3BB-6F2C40695EC5/CECF3925-180E-4373-A15E-E7876760D18F/thumbnail.png")
    ]
}


public struct WalletPassResponse: Codable {
    public init(urlString: String) {
        self.urlString = urlString
    }

    public var urlString: String
}

extension WalletPassResponse: Equatable {}
