import Parsing
import URLRouting

public enum UserRoute: Equatable {
    case find
    case delete
    
    case attachments(AttachmentsRoute)
    case devices(DevicesRoute)

}

public struct UserRouter: ParserPrinter {
    public var body: some Router<UserRoute> {
        OneOf {
            Route(.case(UserRoute.find))

            Route(.case(UserRoute.delete)) {
                Method.delete
            }

            Route(.case(UserRoute.attachments)) {
                Path { "attachments" }
                AttachmentsRouter()
            }

            Route(.case(UserRoute.devices)) {
                Path { From(.utf8) { "devices".utf8 } }
                DevicesRouter()
            }
        }
    }
}
