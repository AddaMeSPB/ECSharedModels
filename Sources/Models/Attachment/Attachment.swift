
import Foundation
import BSON

public enum AttachmentType: String, Codable {
    case file, image, audio, video
}

public struct AttachmentInOutPut: Codable {
    
    public var id: ObjectId?
    public var type: AttachmentType
    public var userId: ObjectId?
    public var swapId: ObjectId?
    public var conversationId: ObjectId?
    public var imageUrlString: String?
    public var audioUrlString: String?
    public var videoUrlString: String?
    public var fileUrlString: String?
    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?
    
    public init(
        id: ObjectId? = nil,
        type: AttachmentType,
        userId: ObjectId? = nil,
        swapId: ObjectId? = nil,
        conversationId: ObjectId? = nil,
        imageUrlString: String? = nil,
        audioUrlString: String? = nil,
        videoUrlString: String? = nil,
        fileUrlString: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        deletedAt: Date? = nil
    ) {
        self.id = id
        self.type = type
        self.userId = userId
        self.swapId = swapId
        self.imageUrlString = imageUrlString
        self.audioUrlString = audioUrlString
        self.videoUrlString = videoUrlString
        self.fileUrlString = fileUrlString
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
    
}

extension AttachmentInOutPut: Identifiable {}

extension AttachmentInOutPut: Equatable {
    public static func < (lhs: AttachmentInOutPut, rhs: AttachmentInOutPut) -> Bool {
        guard let lhsDate = lhs.updatedAt, let rhsDate = rhs.createdAt else { return false }
        return lhsDate > rhsDate
    }
}

extension AttachmentInOutPut: Hashable {}

extension AttachmentInOutPut {
    public static var logo: Self = .init(type: .image, imageUrlString: "https://learnplaygrow.ams3.digitaloceanspaces.com/uploads/images/9155F894-E500-453A-A691-6CDE8F722BDF/CECF3925-180E-4373-A15E-E7876760D18F/logo.png")

    public static var thumbnail: Self = .init(type: .image, imageUrlString: "https://learnplaygrow.ams3.digitaloceanspaces.com/uploads/images/DC6E2827-FF38-4038-A3BB-6F2C40695EC5/CECF3925-180E-4373-A15E-E7876760D18F/thumbnail.png")
}
