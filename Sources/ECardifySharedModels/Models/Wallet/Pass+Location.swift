import Foundation

public extension Pass {
    /// [Documentation](https://developer.apple.com/documentation/walletpasses/pass/locations)
    struct Location: Codable, Equatable {
        public let latitude: Double
        public let longitude: Double
        public let altitude: Double?
        public let relevantText: String?
        
        public init(
            latitude: Double,
            longitude: Double,
            altitude: Double? = nil,
            relevantText: String? = nil
        ) {
            self.latitude = latitude
            self.longitude = longitude
            self.altitude = altitude
            self.relevantText = relevantText
        }

        public static func ==(lhs: Location, rhs: Location) -> Bool {
            return lhs.latitude == rhs.latitude &&
                lhs.longitude == rhs.longitude &&
                lhs.altitude == rhs.altitude &&
                lhs.relevantText == rhs.relevantText
        }
    }

}
