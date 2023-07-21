
import BSON
import Foundation

public struct AttachmentModel {

    public static var collectionName = "attachments"

    public init(
        _id: ObjectId,
        type: AttachmentType = .image,
        userId: ObjectId? = nil,
        swapId: ObjectId? = nil,
        conversationId: ObjectId? = nil,
        imageUrlString: String? = nil,
        audioUrlString: String? = nil,
        videoUrlString: String? = nil,
        fileUrlString: String? = nil
    )  {
        self._id = _id
        self.type = type
        self.userId = userId
        self.swapId = swapId
        self.conversationId = conversationId
        self.imageUrlString = imageUrlString
        self.audioUrlString = audioUrlString
        self.videoUrlString = videoUrlString
        self.fileUrlString = fileUrlString
    }

    public var _id: ObjectId
    public var type: AttachmentType

    public var conversationId: ObjectId?
    public var userId: ObjectId?
    public var swapId: ObjectId?

    public var imageUrlString: String?
    public var audioUrlString: String?
    public var videoUrlString: String?
    public var fileUrlString: String?

    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?

}

extension AttachmentModel: Codable {}

extension AttachmentModel: Equatable {}

