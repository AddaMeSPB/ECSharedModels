
import Foundation
import BSON

// MARK: - NeuAuth OTP Request/Response Models

/// Request body for POST /api/v1/auth/otp/send
public struct NeuAuthOtpRequest: Codable, Equatable {
    public var email: String
    public var purpose: String

    public init(email: String, purpose: String = "login") {
        self.email = email
        self.purpose = purpose
    }
}

/// Response from POST /api/v1/auth/otp/send
public struct NeuAuthOtpResponse: Codable, Equatable {
    public var message: String
    public var expiresIn: Int

    public init(message: String, expiresIn: Int) {
        self.message = message
        self.expiresIn = expiresIn
    }

    private enum CodingKeys: String, CodingKey {
        case message
        case expiresIn = "expires_in"
    }
}

/// Request body for POST /api/v1/auth/otp/verify
public struct NeuAuthOtpVerifyRequest: Codable, Equatable {
    public var email: String
    public var code: String

    public init(email: String, code: String) {
        self.email = email
        self.code = code
    }
}

/// User object returned by NeuAuth in auth responses
public struct NeuAuthUser: Codable, Equatable {
    public var id: UUID
    public var email: String
    public var emailVerified: Bool
    public var displayName: String?
    public var avatarUrl: String?
    public var phone: String?
    public var roles: [String]
    public var tenantId: UUID

    public init(
        id: UUID,
        email: String,
        emailVerified: Bool = false,
        displayName: String? = nil,
        avatarUrl: String? = nil,
        phone: String? = nil,
        roles: [String] = ["user"],
        tenantId: UUID
    ) {
        self.id = id
        self.email = email
        self.emailVerified = emailVerified
        self.displayName = displayName
        self.avatarUrl = avatarUrl
        self.phone = phone
        self.roles = roles
        self.tenantId = tenantId
    }

    private enum CodingKeys: String, CodingKey {
        case id, email, phone, roles
        case emailVerified = "email_verified"
        case displayName = "display_name"
        case avatarUrl = "avatar_url"
        case tenantId = "tenant_id"
    }
}

/// Full auth response from POST /api/v1/auth/otp/verify and POST /api/v1/auth/login
public struct NeuAuthResponse: Codable, Equatable {
    public var accessToken: String
    public var tokenType: String
    public var expiresIn: Int
    public var refreshToken: String
    public var idToken: String?
    public var user: NeuAuthUser

    public init(
        accessToken: String,
        tokenType: String = "Bearer",
        expiresIn: Int = 900,
        refreshToken: String,
        idToken: String? = nil,
        user: NeuAuthUser
    ) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
        self.idToken = idToken
        self.user = user
    }

    private enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case idToken = "id_token"
    }
}

/// Request body for POST /api/v1/auth/refresh
public struct NeuAuthRefreshRequest: Codable, Equatable {
    public var refreshToken: String

    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }

    private enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

// MARK: - Mapping NeuAuth -> Existing App Models

extension NeuAuthResponse {
    /// Map NeuAuth response to the existing SuccessfulLoginResponse
    /// so the rest of the app (Settings, keychain storage) works unchanged
    public func toSuccessfulLoginResponse() -> SuccessfulLoginResponse {
        let userOutput = user.toUserOutput()
        let tokens = RefreshTokenResponse(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
        return SuccessfulLoginResponse(
            status: "ok",
            user: userOutput,
            access: tokens
        )
    }
}

extension NeuAuthUser {
    /// Map NeuAuth user to existing UserOutput
    /// Uses a deterministic ObjectId derived from UUID for backward compatibility
    public func toUserOutput() -> UserOutput {
        // Create a deterministic ObjectId from first 12 bytes of UUID (24 hex chars)
        let uuidHex = id.uuidString.replacingOccurrences(of: "-", with: "").lowercased()
        let hexPrefix = String(uuidHex.prefix(24))
        let objectId = ObjectId(hexPrefix) ?? ObjectId()

        return UserOutput(
            id: objectId,
            fullName: displayName,
            email: email,
            phoneNumber: phone,
            role: roles.contains("admin") ? .superAdmin : .basic,
            language: .english,
            url: .home,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
