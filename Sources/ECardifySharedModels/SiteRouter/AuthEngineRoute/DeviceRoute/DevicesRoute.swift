import Parsing
import Foundation
import URLRouting

public enum DevicesRoute: Equatable {
    case createOrUpdate(input: DeviceModel)
}

public struct DevicesRouter: ParserPrinter {
    public var body: some Router<DevicesRoute> {
        Route(.case(DevicesRoute.createOrUpdate)) {
            Method.post
            Body(.json(DeviceModel.self))
        }
    }
}
