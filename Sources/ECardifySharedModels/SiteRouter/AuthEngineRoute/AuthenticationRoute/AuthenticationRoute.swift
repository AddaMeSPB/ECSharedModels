import URLRouting

public enum AuthenticationRoute: Equatable {
    case loginViaEmail(EmailLoginInput)
    case verifyEmail(VerifyEmailInput)
    case refreshToken(input: RefreshTokenInput)
}

public struct AuthenticationRouter: ParserPrinter {
    public var body: some Router<AuthenticationRoute> {
         OneOf {
            Route(.case(AuthenticationRoute.loginViaEmail)) {
                Path { "otp_login_email" }
                Method.post
                Body(.json(EmailLoginInput.self))
            }

            Route(.case(AuthenticationRoute.verifyEmail)) {
                Path { "verify_otp_email" }
                Method.post
                Body(.json(VerifyEmailInput.self))
            }

            Route(.case(AuthenticationRoute.refreshToken)) {
                Path { "refresh_token" }
                Method.post
                Body(.json(RefreshTokenInput.self))
            }
        }
    }
}

//public struct Router: ParserPrinter {
//    public var body: some Router<> {
//
//    }
//}
