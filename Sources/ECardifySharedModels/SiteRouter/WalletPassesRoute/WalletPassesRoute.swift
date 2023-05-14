
import URLRouting

public enum WalletPassRoute: Equatable {
    case create(input: Pass)
}

public struct WalletPassRouter: ParserPrinter {
    public var body: some Router<WalletPassRoute> {
        Route(.case(WalletPassRoute.create)) {
            Method.post
            Body(.json(Pass.self))
        }
    }
}
