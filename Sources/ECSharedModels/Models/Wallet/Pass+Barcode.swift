import Foundation

public extension Pass {
    /// [Documentation](https://developer.apple.com/documentation/walvarpasses/pass/barcodes)
    struct Barcode: Codable, Equatable {
        public var message: String
        public var format: BarcodeFormat
        public var messageEncoding: BarcodeEncoding
        public var altText: String?
        
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
