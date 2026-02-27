//
//  User.swift
//  
//
//  Created by Saroar Khandoker on 12.10.2020.
//

import Foundation
import BSON

/// Dont have any role and language Need to combine with UserGetObject
public struct UserOutput: Codable, Identifiable {

    public var id: ObjectId
    public var fullName, phoneNumber, email: String?
    public var role: UserRole
    public var language: UserLanguage

    // User Device lists
    public var devices: [DeviceOutPut]?

    // Attachments Photo,Video, etc url
    public var attachments: [AttachmentInOutPut]?

    /// Date
    public var createdAt, updatedAt: Date?

    public var url: URL

    /// Init
    /// - Parameters:
    ///   - id: An ObjectId is a 12-byte unique identifier used in MongoDB to uniquely identify a document within a collection. It consists of a timestamp, a machine identifier, a process id, and a counter.
    ///   - fullName: String combine Firstname + Lastname
    ///   - email: Email
    ///   - phoneNumber: phoneNumber
    ///   - attachments: attachments for images
    ///   - adminsConversations: admins Conversations list
    ///   - membersConversaions: membersConversaions list
    ///   - url: url description
    ///   - createdAt: createdAt its Date
    ///   - updatedAt: updatedAt its Date

    public init(
        id: ObjectId,
        fullName: String? = nil,
        email: String? = nil,
        phoneNumber: String? = nil,
        role: UserRole,
        language: UserLanguage,
        devices: [DeviceOutPut]? = nil,
        attachments: [AttachmentInOutPut]? = nil,
        url: URL,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.role = role
        self.language = language
        self.devices = devices
        self.attachments = attachments
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

extension UserOutput {
//    public static var draff: Self {
//      .init(
//        id: ObjectId(), phoneNumber: "+79212121211",
//        avatarUrl: nil, firstName: "1st Draff",
//        lastName: "2nd Draff", email: nil,
//        contactIDs: nil, deviceIDs: nil, attachments: nil,
//        createdAt: Date(), updatedAt: Date()
//      )
//    }
}

extension UserOutput: Equatable, Hashable {

    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    public static func == (lhs: UserOutput, rhs: UserOutput) -> Bool {
      return
        lhs.id == rhs.id && lhs.email == rhs.email
        && lhs.fullName == rhs.fullName
    }
}

extension UserOutput {
    private static let placeholderURLString = "https://placeholder.ecardify.com/user.png"

    /// Returns the last avatar URL string, or nil if no image attachments exist
    public var lastAvatarURLString: String? {
        guard let attachments = attachments, !attachments.isEmpty else {
            return nil
        }

        let imageAttachments = attachments.filter { $0.type == .image }
        return imageAttachments.last?.imageUrlString
    }

    /// Returns the image URL, or nil if not available
    public var imageURL: URL? {
        guard let urlString = lastAvatarURLString else { return nil }
        return URL(string: urlString)
    }

    /// Returns the image URL or a default placeholder - use when a non-optional URL is required
    public var imageURLOrPlaceholder: URL {
        imageURL ?? URL(string: Self.placeholderURLString)!
    }
}
