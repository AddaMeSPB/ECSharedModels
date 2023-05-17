import Foundation

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
        coupon: PassContent? = nil,
        boardingPass: PassContentTransit? = nil,
        storeCard: PassContent? = nil,
        eventTicket: PassContent? = nil,
        genericPass: PassContent? = nil
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
        self.coupon = coupon
        self.barcodes = barcodes
        self.logoText = logoText
        self.description = description
        self.boardingPass = boardingPass
        self.storeCard = storeCard
        self.eventTicket = eventTicket
        self.generic = genericPass
    }
}
