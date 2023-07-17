import Foundation

public extension Pass {
    enum Color {
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
}
