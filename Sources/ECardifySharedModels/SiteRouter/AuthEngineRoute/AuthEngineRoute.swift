
import URLRouting

public enum AuthEngineRoute: Equatable {
    case authentication(AuthenticationRoute)
    case users(UsersRoute)
    case contacts(ContactsRoute)
    case devices(DevicesRoute)
}

public struct AuthEngineRouter: ParserPrinter {
    public var body: some Router<AuthEngineRoute> {
        OneOf {
            Route(.case(AuthEngineRoute.authentication)) {
                Path { "auth" }
                AuthenticationRouter()
            }

            Route(.case(AuthEngineRoute.users)) {
                Path { "users" }
                UsersRouter()
            }

            Route(.case(AuthEngineRoute.contacts)) {
                Path { "contacts" }
                ContactsRouter()
            }

            Route(.case(AuthEngineRoute.devices)) {
                Path { "devices" }
                DevicesRouter()
            }
        }
    }
}
