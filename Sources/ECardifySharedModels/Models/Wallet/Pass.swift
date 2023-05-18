import Foundation

public enum PContent: Codable, Equatable {
    case coupon(PassContent)
    case boardingPass(PassContentTransit)
    case storeCard(PassContent)
    case eventTicket(PassContent)
    case generic(PassContent)

    public static func == (lhs: PContent, rhs: PContent) -> Bool {
        switch (lhs, rhs) {
        case let (.coupon(left), .coupon(right)):
            return left == right
        case let (.boardingPass(left), .boardingPass(right)):
            return left == right
        case let (.storeCard(left), .storeCard(right)):
            return left == right
        case let (.eventTicket(left), .eventTicket(right)):
            return left == right
        case let (.generic(left), .generic(right)):
            return left == right
        default:
            return false
        }
    }
}

/// I.e. content of the pass.json file
/// For all available fields and their documentation, see [this page](https://developer.apple.com/documentation/walvarpasses/pass)
public struct Pass: Codable, Equatable {
    public var formatVersion: Int
    public var passTypeIdentifier: String
    public var serialNumber: String
    public var teamIdentifier: String
    public var organizationName: String
    public var description: String
    public var logoText: String?
    public var foregroundColor: String?
    public var backgroundColor: String?
    public var labelColor: String?
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
    public var content: PContent

    
    public init(
        formatVersion: Int,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        organizationName: String,
        description: String,
        logoText: String?,
        foregroundColor: Color?,
        backgroundColor: Color?,
        labelColor: Color?,
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
        suppressStripShine: Bool = false,
        userInfo: [String: String]? = nil,
        voided: Bool = false,
        webServiceURL: String? = nil,
        content: PContent
    ) {
        self.formatVersion = formatVersion
        self.passTypeIdentifier = passTypeIdentifier
        self.serialNumber = serialNumber
        self.teamIdentifier = teamIdentifier
        self.organizationName = organizationName
        self.foregroundColor = foregroundColor?.stringForm
        self.backgroundColor = backgroundColor?.stringForm
        self.labelColor = labelColor?.stringForm
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
        self.content = content
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        formatVersion = try container.decode(Int.self, forKey: .formatVersion)
        passTypeIdentifier = try container.decode(String.self, forKey: .passTypeIdentifier)
        serialNumber = try container.decode(String.self, forKey: .serialNumber)
        teamIdentifier = try container.decode(String.self, forKey: .teamIdentifier)
        organizationName = try container.decode(String.self, forKey: .organizationName)
        description = try container.decode(String.self, forKey: .description)
        logoText = try container.decodeIfPresent(String.self, forKey: .logoText)
        foregroundColor = try container.decodeIfPresent(String.self, forKey: .foregroundColor)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        labelColor = try container.decodeIfPresent(String.self, forKey: .labelColor)
        relevantDate = try container.decodeIfPresent(String.self, forKey: .relevantDate)
        locations = try container.decodeIfPresent([Pass.Location].self, forKey: .locations)
        maxDistance = try container.decodeIfPresent(Int.self, forKey: .maxDistance)
        barcodes = try container.decode([Pass.Barcode].self, forKey: .barcodes)
        beacons = try container.decodeIfPresent([Pass.Beacon].self, forKey: .beacons)
        nfc = try container.decodeIfPresent([Pass.NFC].self, forKey: .nfc)
        appLaunchURL = try container.decodeIfPresent(String.self, forKey: .appLaunchURL)
        associatedStoreIdentifiers = try container.decodeIfPresent([Int].self, forKey: .associatedStoreIdentifiers)
        authenticationToken = try container.decodeIfPresent(String.self, forKey: .authenticationToken)
        expirationDate = try container.decodeIfPresent(String.self, forKey: .expirationDate)
        groupingIdentifier = try container.decodeIfPresent(String.self, forKey: .groupingIdentifier)
        sharingProhibited = try container.decode(Bool.self, forKey: .sharingProhibited)
        suppressStripShine = try container.decode(Bool.self, forKey: .suppressStripShine)
        userInfo = try container.decodeIfPresent([String: String].self, forKey: .userInfo)
        voided = try container.decode(Bool.self, forKey: .voided)
        webServiceURL = try container.decodeIfPresent(String.self, forKey: .webServiceURL)

        // Decode the content property based on its associated value
        if let coupon = try container.decodeIfPresent(PassContent.self, forKey: .coupon) {
            content = .coupon(coupon)
        } else if let eventTicket = try container.decodeIfPresent(PassContent.self, forKey: .eventTicket) {
            content = .eventTicket(eventTicket)
        } else if let boardingPass = try container.decodeIfPresent(PassContentTransit.self, forKey: .boardingPass) {
            content = .boardingPass(boardingPass)
        } else if let storeCard = try container.decodeIfPresent(PassContent.self, forKey: .storeCard) {
            content = .storeCard(storeCard)
        } else if let genericCard = try container.decodeIfPresent(PassContent.self, forKey: .generic) {
            content = .storeCard(genericCard)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "coupon, eventTicket, storeCard, boardingPass, storeCard on of content Invalid data"))
            //.dataCorruptedError(forKey: .coupon, in: container, debugDescription: "Invalid content data")
        }
    }

    enum CodingKeys: String, CodingKey {
        case formatVersion = "formatVersion"
        case passTypeIdentifier = "passTypeIdentifier"
        case serialNumber = "serialNumber"
        case teamIdentifier = "teamIdentifier"
        case organizationName = "organizationName"
        case description = "description"
        case logoText = "logoText"
        case foregroundColor = "foregroundColor"
        case backgroundColor = "backgroundColor"
        case labelColor = "labelColor"
        case relevantDate = "relevantDate"
        case locations = "locations"
        case maxDistance = "maxDistance"
        case barcodes = "barcodes"
        case beacons = "beacons"
        case nfc = "nfc"
        case appLaunchURL = "appLaunchURL"
        case associatedStoreIdentifiers = "associatedStoreIdentifiers"
        case authenticationToken = "authenticationToken"
        case expirationDate = "expirationDate"
        case groupingIdentifier = "groupingIdentifier"
        case sharingProhibited = "sharingProhibited"
        case suppressStripShine = "suppressStripShine"
        case userInfo = "userInfo"
        case voided = "voided"
        case webServiceURL = "webServiceURL"

        case coupon = "coupon"
        case eventTicket = "eventTicket"
        case boardingPass = "boardingPass"
        case storeCard = "storeCard"
        case generic = "generic"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(formatVersion, forKey: .formatVersion)
        try container.encode(passTypeIdentifier, forKey: .passTypeIdentifier)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(teamIdentifier, forKey: .teamIdentifier)
        try container.encode(organizationName, forKey: .organizationName)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(logoText, forKey: .logoText)
        try container.encodeIfPresent(foregroundColor, forKey: .foregroundColor)
        try container.encodeIfPresent(backgroundColor, forKey: .backgroundColor)
        try container.encodeIfPresent(labelColor, forKey: .labelColor)
        try container.encodeIfPresent(relevantDate, forKey: .relevantDate)
        try container.encodeIfPresent(locations, forKey: .locations)
        try container.encodeIfPresent(maxDistance, forKey: .maxDistance)
        try container.encode(barcodes, forKey: .barcodes)
        try container.encodeIfPresent(beacons, forKey: .beacons)
        try container.encodeIfPresent(nfc, forKey: .nfc)
        try container.encodeIfPresent(appLaunchURL, forKey: .appLaunchURL)
        try container.encodeIfPresent(associatedStoreIdentifiers, forKey: .associatedStoreIdentifiers)
        try container.encodeIfPresent(authenticationToken, forKey: .authenticationToken)
        try container.encodeIfPresent(expirationDate, forKey: .expirationDate)
        try container.encodeIfPresent(groupingIdentifier, forKey: .groupingIdentifier)
        try container.encode(sharingProhibited, forKey: .sharingProhibited)
        try container.encode(suppressStripShine, forKey: .suppressStripShine)
        try container.encodeIfPresent(userInfo, forKey: .userInfo)
        try container.encode(voided, forKey: .voided)
        try container.encodeIfPresent(webServiceURL, forKey: .webServiceURL)

        switch content {
        case .coupon(let coupon):
            var contentContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coupon)
            try contentContainer.encode(coupon, forKey: .coupon)
        case .eventTicket(let eventTicket):
            var contentContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .eventTicket)
            try contentContainer.encode(eventTicket, forKey: .eventTicket)
        case .boardingPass(let boardingPass):
            var contentContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .boardingPass)
            try contentContainer.encode(boardingPass, forKey: .boardingPass)
        case .storeCard(let storeCard):
            var contentContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .storeCard)
            try contentContainer.encode(storeCard, forKey: .storeCard)
        case .generic(let genericStore):
            var contentContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .generic)
            try contentContainer.encode(genericStore, forKey: .generic)
        }
    }

}
