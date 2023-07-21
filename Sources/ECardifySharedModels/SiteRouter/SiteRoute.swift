
import BSON
import Parsing
import URLRouting

let objectIdParser = ParsePrint {
  Prefix<Substring> { $0.isHexDigit }
    .map(.string)
    .map(
      .convert(
        apply: { ObjectId($0) },
        unapply: { $0.hexString }
      )
    )
}

public enum SiteRoute: Equatable {
    case authEngine(AuthEngineRoute)
    case walletPasses(WalletPassRoute)
    case terms
    case privacy
}

public struct SiteRouter: ParserPrinter {

    public init() {}

    public var body: some Router<SiteRoute> {
        OneOf {
            Route(.case(SiteRoute.authEngine)) {
                Path { "v1" }
                AuthEngineRouter()
            }

            Route(.case(SiteRoute.walletPasses)) {
                Path { "v1" }
                Path { "wallet_pass" }
                WalletPassRouter()
            }

            Route(.case(SiteRoute.terms)) {
                Path { "terms" }
            }

            Route(.case(SiteRoute.privacy)) {
                Path { "privacy" }
            }
        }
    }
}
