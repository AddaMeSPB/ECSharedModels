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
public class PassContentTransit: Codable, Equatable {
    public enum TransitType: String, Codable {
        case air = "PKTransitTypeAir"
        case train = "PKTransitTypeTrain"
        case bus = "PKTransitTypeBus"
        case boat = "PKTransitTypeBoat"
        case generic = "PKTransitTypeGeneric"
    }

    
    public var primaryFields: [Field]
    public var secondaryFields: [Field]?
    public var auxiliaryFields: [Field]?
    public var headerFields: [Field]?
    public var backFields: [Field]?
    public var transitType: TransitType
    
    public init(
        primaryFields: [Field],
        transitType: TransitType,
        secondaryFields: [Field]? = nil,
        auxiliaryFields: [Field]? = nil,
        headerFields: [Field]? = nil,
        backFields: [Field]? = nil
    ) {
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.auxiliaryFields = auxiliaryFields
        self.headerFields = headerFields
        self.backFields = backFields
        self.transitType = transitType
    }

    public static func == (lhs: PassContentTransit, rhs: PassContentTransit) -> Bool {
        return lhs.primaryFields == rhs.primaryFields &&
            lhs.secondaryFields == rhs.secondaryFields &&
            lhs.auxiliaryFields == rhs.auxiliaryFields &&
            lhs.headerFields == rhs.headerFields &&
            lhs.backFields == rhs.backFields &&
            lhs.transitType == rhs.transitType
    }
}
