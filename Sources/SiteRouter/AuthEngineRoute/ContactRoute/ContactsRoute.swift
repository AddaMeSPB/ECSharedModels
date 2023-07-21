import Parsing
import URLRouting

public enum ContactsRoute: Equatable {
    case getRegisterUsers(inputs: MobileNumbersInput)
}

public struct ContactsRouter: ParserPrinter {
    public var body: some Router<ContactsRoute> {
        Route(.case(ContactsRoute.getRegisterUsers)) {
            Method.post
            Body(.json(MobileNumbersInput.self))
        }
    }
}
