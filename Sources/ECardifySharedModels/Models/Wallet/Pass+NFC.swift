import Foundation

public extension Pass {
    /// [documentation](https://developer.apple.com/documentation/walvarpasses/pass/nfc)
    struct NFC: Codable, Equatable {
        public var encryptionPublicKey: String
        public var message: String
        public var requiresAuthentication: Bool

        public init(
            encryptionPublicKey: String,
            message: String,
            requiresAuthentication: Bool = false
        ) {
            self.encryptionPublicKey = encryptionPublicKey
            self.message = message
            self.requiresAuthentication = requiresAuthentication
        }
    }
}
