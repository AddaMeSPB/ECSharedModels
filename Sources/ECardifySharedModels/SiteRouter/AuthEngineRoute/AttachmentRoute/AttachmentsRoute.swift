
import URLRouting

public enum AttachmentsRoute: Equatable {
    case create(input: AttachmentInOutPut)
    case findWithOwnerId
    case attachment(id: String, AttachmentRoute)
}

struct AttachmentsRouter: ParserPrinter {
    var body: some Router<AttachmentsRoute> {
        OneOf {
            Route(.case(AttachmentsRoute.create)) {
                Method.post
                Body(.json(AttachmentInOutPut.self))
            }

            Route(.case(AttachmentsRoute.findWithOwnerId))

            Route(.case(AttachmentsRoute.attachment)) {
                Path { Parse(.string) }
                AttachmentRouter()
            }
        }
    }

}

public enum AttachmentRoute: Equatable {
    case delete
}

public struct AttachmentRouter: ParserPrinter {
    public var body: some Router<AttachmentRoute> {
        Route(.case(AttachmentRoute.delete)) {
            Method.delete
        }
    }

}
