import Foundation

public class PassContent: Codable, Equatable {
    public let primaryFields: [Field]
    public let secondaryFields: [Field]?
    public let auxiliaryFields: [Field]?
    public let headerFields: [Field]?
    public let backFields: [Field]?

    public init(
        primaryFields: [Field],
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
    }

    public static func == (lhs: PassContent, rhs: PassContent) -> Bool {
        return lhs.primaryFields == rhs.primaryFields &&
            lhs.secondaryFields == rhs.secondaryFields &&
            lhs.auxiliaryFields == rhs.auxiliaryFields &&
            lhs.headerFields == rhs.headerFields &&
            lhs.backFields == rhs.backFields
    }
}

public struct Field: Codable, Equatable {
    public let key: String
    public let label: String?
    public let value: String
    public let dateStyle: DateTimeStyle?
    public let timeStyle: DateTimeStyle?
    public let textAlignment: TextAlignment?
    /// only works for Auxiliary Fields
    public let row: Int?
    public let attributedValue: String?

    public init(
        key: String,
        label: String?,
        value: String,
        dateStyle: DateTimeStyle? = nil,
        timeStyle: DateTimeStyle? = nil,
        textAlignment: TextAlignment? = nil,
        row: Int? = nil,
        attributedValue: String? = nil
    ) {
        self.key = key
        self.label = label
        self.value = value
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.textAlignment = textAlignment
        self.row = row
        self.attributedValue = attributedValue
    }

    public static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.key == rhs.key &&
            lhs.label == rhs.label &&
            lhs.value == rhs.value &&
            lhs.dateStyle == rhs.dateStyle &&
            lhs.timeStyle == rhs.timeStyle &&
            lhs.textAlignment == rhs.textAlignment &&
            lhs.row == rhs.row &&
            lhs.attributedValue == rhs.attributedValue
    }
}

public enum DateTimeStyle: String, Codable, Equatable {
    case none = "PKDateStyleNone"
    case short = "PKDateStyleShort"
    case medium = "PKDateStyleMedium"
    case long = "PKDateStyleLong"
    case full = "PKDateStyleFull"

    public static func ==(lhs: DateTimeStyle, rhs: DateTimeStyle) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

public enum TextAlignment: String, Codable, Equatable {
    case left = "PKTextAlignmentLeft"
    case center = "PKTextAlignmentCenter"
    case right = "PKTextAlignmentRight"
    case natural = "PKTextAlignmentNatural"

    public static func ==(lhs: TextAlignment, rhs: TextAlignment) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
