import Foundation

public extension Pass {
    /// [Documentation](https://developer.apple.com/documentation/walvarpasses/pass/locations)
    struct Location: Codable, Equatable {
        public var latitude: Double
        public var longitude: Double
        public var altitude: Double?
        public var relevantText: String?
        
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
