import Foundation

public extension Pass {
    /// [Documentation](https://developer.apple.com/documentation/walletpasses/pass/barcodes)
    struct Barcode: Codable, Equatable {
        public let message: String
        public let format: BarcodeFormat
        public let messageEncoding: BarcodeEncoding
        public let altText: String?
        
        public init(
            message: String,
            format: BarcodeFormat,
            encoding: BarcodeEncoding = .iso_8859_1,
            altText: String? = nil
        ) {
            self.message = message
            self.format = format
            self.messageEncoding = encoding
            self.altText = altText
        }
    }

    enum BarcodeFormat: String, Codable, Equatable {
        case pdf417 = "PKBarcodeFormatPDF417"
        case qr = "PKBarcodeFormatQR"
        case aztec = "PKBarcodeFormatAztec"
        case code128 = "PKBarcodeFormatCode128"
    }

    enum BarcodeEncoding: String, Codable, Equatable {
        case iso_8859_1 = "iso-8859-1"
    }

}
