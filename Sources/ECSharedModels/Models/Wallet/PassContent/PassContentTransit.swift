//
//  PassCotnentTransit.swift
//  
//
//  Created by Jing Wei Li on 5/27/21.
//

import Foundation

/// Represents a boarding pass.
/// - Note that for auxiliary fields, the time must be provided and should be in a appropriate time format, e.g.
/// ```
/// .init(key: "Date2", label: "Destination", value: "2021-05-18T17:00Z", dateStyle: .short, timeStyle: .short)
/// ```
public struct PassContentTransit: Codable, Equatable {
    public enum TransitType: String, Codable {
        case air = "PKTransitTypeAir"
        case train = "PKTransitTypeTrain"
        case bus = "PKTransitTypeBus"
        case boat = "PKTransitTypeBoat"
        case generic = "PKTransitTypeGeneric"
    }

    
    public var passContent: PassContent
    public var transitType: TransitType
    
    public init(
        passContent: PassContent,
        transitType: TransitType
    ) {
        self.passContent = passContent
        self.transitType = transitType
    }

    public static func == (lhs: PassContentTransit, rhs: PassContentTransit) -> Bool {
        return lhs.passContent == rhs.passContent &&
            lhs.transitType == rhs.transitType
    }
}
