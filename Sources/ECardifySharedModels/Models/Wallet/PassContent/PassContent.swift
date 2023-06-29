import Foundation

public enum FieldTypes: Codable, Equatable {
    case header
    case primary
    case secondary
    case auxiliary
    case back
}

public struct PassContent: Codable, Equatable, Identifiable {
    public var id: String {
        UUID().uuidString
    }
    public var headerFields: [Field]?
    public var primaryFields: [Field]
    public var secondaryFields: [Field]?
    public var auxiliaryFields: [Field]?
    public var backFields: [Field]?

    public init(
        headerFields: [Field]? = nil,
        primaryFields: [Field],
        secondaryFields: [Field]? = nil,
        auxiliaryFields: [Field]? = nil,
        backFields: [Field]? = nil
    ) {
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
    }

    public static func == (lhs: PassContent, rhs: PassContent) -> Bool {
        return lhs.primaryFields == rhs.primaryFields &&
            lhs.secondaryFields == rhs.secondaryFields &&
            lhs.auxiliaryFields == rhs.auxiliaryFields &&
            lhs.headerFields == rhs.headerFields &&
            lhs.backFields == rhs.backFields
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(headerFields)
        hasher.combine(primaryFields)
        hasher.combine(secondaryFields)
        hasher.combine(auxiliaryFields)
        hasher.combine(backFields)
    }
}

public struct Field: Codable, Equatable, Hashable {
    public var label: String?
    public var key: String
    public var value: String
    public var dateStyle: DateTimeStyle?
    public var timeStyle: DateTimeStyle?
    public var textAlignment: TextAlignment?
    /// only works for Auxiliary Fields
    public var row: Int?
    public var attributedValue: String?

    public init(
        label: String? = nil,
        key: String,
        value: String = "",
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(label)
        hasher.combine(value)
        hasher.combine(dateStyle)
        hasher.combine(timeStyle)
        hasher.combine(textAlignment)
        hasher.combine(row)
        hasher.combine(attributedValue)
    }
}

public enum DateTimeStyle: String, Codable, Equatable, Hashable {
    case none = "PKDateStyleNone"
    case short = "PKDateStyleShort"
    case medium = "PKDateStyleMedium"
    case long = "PKDateStyleLong"
    case full = "PKDateStyleFull"

    public static func ==(lhs: DateTimeStyle, rhs: DateTimeStyle) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

public enum TextAlignment: String, Codable, Equatable, Hashable {
    case left = "PKTextAlignmentLeft"
    case center = "PKTextAlignmentCenter"
    case right = "PKTextAlignmentRight"
    case natural = "PKTextAlignmentNatural"

    public static func ==(lhs: TextAlignment, rhs: TextAlignment) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
