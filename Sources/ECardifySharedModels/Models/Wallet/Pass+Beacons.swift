import Foundation

public extension Pass {
    /// Show a pass when an iBeacon is nearby
    /// [Documentation](https://developer.apple.com/documentation/walvarpasses/pass/beacons)
    struct Beacon: Codable, Equatable {
        public var proximityUUID: String
        public var major: UInt16?
        public var minor: UInt16?
        public var relevantText: String?
        
        public init(
            proximityUUID: String,
            major: UInt16? = nil,
            minor: UInt16? = nil,
            relevantText: String? = nil
        ) {
            self.proximityUUID = proximityUUID
            self.major = major
            self.minor = minor
            self.relevantText = relevantText
        }
    }
}
