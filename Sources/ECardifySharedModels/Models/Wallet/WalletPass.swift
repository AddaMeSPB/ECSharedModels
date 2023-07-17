import Foundation
import BSON

public struct WalletPass: Codable, Equatable, Identifiable {

    static public var collectionName = "wallet_passes"

    public var _id: ObjectId
    public var id: String {
        get {
            return self._id.hexString
        }
        set { newValue } // its does nothing also no side effect
    }
    public let ownerId: ObjectId
    public var vCard: VCard
    public var colorPalette: ColorPalette
    public var isPaid: Bool = false
    public var isDataSavedOnServer: Bool = false
    public var createdAt: Date?
    public var updatedAt: Date?

    public init(
        _id: ObjectId,
        ownerId: ObjectId,
        vCard: VCard,
        colorPalette: ColorPalette = .default,
        isPaid: Bool = false,
        isDataSavedOnServer: Bool = false,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self._id = _id
        self.ownerId = ownerId
        self.vCard = vCard
        self.colorPalette = colorPalette
        self.isPaid = isPaid
        self.isDataSavedOnServer = isDataSavedOnServer
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey {
        case _id
        case ownerId
        case vCard
        case colorPalette
        case isPaid
        case isDataSavedOnServer
        case createdAt
        case updatedAt
    }
}

extension  WalletPass {
    public static var mock: WalletPass = .init(
        _id: .init(),
        ownerId: .init(),
        vCard: .empty
    )

    public static var mock1: WalletPass = .init(
        _id: .init(),
        ownerId: .init(),
        vCard: VCard.empty
    )
}

public struct ColorPalette: Codable, Identifiable {
    public enum Color {
        case rgb(r: Int, g: Int, b: Int)
        case string(String)

        var stringForm: String {
            switch self {
            case .rgb(r: let r, g: let g, b: let b):
                return "rgb(\(r), \(g), \(b))"
            case .string(let str):
                return str
            }
        }

        static func ==(lhs: Color, rhs: Color) -> Bool {
            switch (lhs, rhs) {
            case let (.rgb(r1, g1, b1), .rgb(r2, g2, b2)):
                return r1 == r2 && g1 == g2 && b1 == b2
            case let (.string(str1), .string(str2)):
                return str1 == str2
            default:
                return false
            }
        }
    }

    public var id: UUID
    public var labelColor: String
    public var foregroundColor: String
    public var backgroundColor: String

    public init(
        id: UUID = .init(),
        labelColor: Color = .rgb(r: 0, g: 0, b: 0),
        foregroundColor: Color = .rgb(r: 0, g: 0, b: 225),
        backgroundColor: Color = .rgb(r: 255, g: 255, b: 255)
    ) {
        self.id = id
        self.labelColor = labelColor.stringForm
        self.foregroundColor = foregroundColor.stringForm
        self.backgroundColor = backgroundColor.stringForm
    }
}

extension ColorPalette: Equatable {
  public static func == (lhs: ColorPalette, rhs: ColorPalette) -> Bool {
    return lhs.id == rhs.id &&
      lhs.labelColor == rhs.labelColor &&
      lhs.foregroundColor == rhs.foregroundColor &&
      lhs.backgroundColor == rhs.backgroundColor
  }
}

extension ColorPalette {

    static public let `default`: ColorPalette = .init(
        labelColor: .rgb(r: 0, g: 0, b: 0),
        foregroundColor: .rgb(r: 0, g: 0, b: 255),
        backgroundColor: .rgb(r: 255, g: 255, b: 255)
    )

    static public let colorPalettes: [ColorPalette] = [
        ColorPalette(labelColor: .rgb(r: 172, g: 139, b: 22), foregroundColor: .rgb(r: 230, g: 194, b: 0), backgroundColor: .rgb(r: 253, g: 245, b: 217)), // 0
        ColorPalette(labelColor: .rgb(r: 170, g: 170, b: 170), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 85, g: 85, b: 85)), // 1
        ColorPalette(labelColor: .rgb(r: 26, g: 35, b: 126), foregroundColor: .rgb(r: 255, g: 245, b: 157), backgroundColor: .rgb(r: 57, g: 73, b: 171)), // 2
        ColorPalette(labelColor: .rgb(r: 0, g: 96, b: 100), foregroundColor: .rgb(r: 255, g: 171, b: 0), backgroundColor: .rgb(r: 0, g: 151, b: 167)), // 3
        ColorPalette(labelColor: .rgb(r: 43, g: 12, b: 82), foregroundColor: .rgb(r: 255, g: 215, b: 64), backgroundColor: .rgb(r: 123, g: 31, b: 162)), // 4
        ColorPalette(labelColor: .rgb(r: 0, g: 77, b: 64), foregroundColor: .rgb(r: 255, g: 109, b: 0), backgroundColor: .rgb(r: 0, g: 131, b: 143)), // 5
        ColorPalette(labelColor: .rgb(r: 69, g: 7, b: 40), foregroundColor: .rgb(r: 255, g: 138, b: 101), backgroundColor: .rgb(r: 173, g: 20, b: 87)), // 6
        ColorPalette(labelColor: .rgb(r: 1, g: 87, b: 155), foregroundColor: .rgb(r: 255, g: 204, b: 128), backgroundColor: .rgb(r: 3, g: 155, b: 229)), // 7
        ColorPalette(labelColor: .rgb(r: 14, g: 47, b: 17), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 46, g: 125, b: 50)), // 8
        ColorPalette(labelColor: .rgb(r: 42, g: 27, b: 24), foregroundColor: .rgb(r: 255, g: 214, b: 0), backgroundColor: .rgb(r: 121, g: 85, b: 72)), // 9
        ColorPalette(labelColor: .rgb(r: 20, g: 15, b: 73), foregroundColor: .rgb(r: 240, g: 240, b: 240), backgroundColor: .rgb(r: 63, g: 81, b: 181)), // 10
        ColorPalette(labelColor: .rgb(r: 79, g: 102, b: 232), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 26, g: 35, b: 126)), // 11
        ColorPalette(labelColor: .rgb(r: 60, g: 165, b: 249), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 21, g: 101, b: 192)), // 12
        ColorPalette(labelColor: .rgb(r: 76, g: 175, b: 80), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 27, g: 94, b: 32)), // 13
        ColorPalette(labelColor: .rgb(r: 207, g: 123, b: 2), foregroundColor: .rgb(r: 33, g: 33, b: 33), backgroundColor: .rgb(r: 255, g: 235, b: 59)), // 14
        ColorPalette(labelColor: .rgb(r: 249, g: 179, b: 157), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 230, g: 74, b: 25)), // 15
        ColorPalette(labelColor: .rgb(r: 133, g: 45, b: 241), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 74, g: 20, b: 140)), // 16
        ColorPalette(labelColor: .rgb(r: 233, g: 30, b: 99), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 136, g: 14, b: 79)), // 17
        ColorPalette(labelColor: .rgb(r: 0, g: 150, b: 136), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 0, g: 77, b: 64)), // 18
        ColorPalette(labelColor: .rgb(r: 195, g: 138, b: 117), foregroundColor: .rgb(r: 255, g: 255, b: 255), backgroundColor: .rgb(r: 78, g: 52, b: 46)) // 19
    ]

}
