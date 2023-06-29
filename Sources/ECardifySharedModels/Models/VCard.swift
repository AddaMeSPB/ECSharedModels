
import Foundation

public struct VirtualCard: Codable, Equatable {
    public init(
        vcard: VCard? = nil,
        vnRecognizeString: String? = nil,
        qrString: String? = nil
    ) {
        self.vcard = vcard
        self.vnRecognizeString = vnRecognizeString
        self.qrString = qrString
    }

    public var vcard: VCard?
    public var vnRecognizeString: String?
    public var qrString: String?
}

extension VirtualCard {
    public static var empty: Self = .init(vcard: .empty, vnRecognizeString: nil, qrString: nil)
}

public struct VCard: Codable, Equatable {

    /// The full name of the contact.
    public var fullName: String

    /// The components of the contact's name (e.g., first name, last name).
    public var nameComponents: String

    /// The title or job position of the contact.
    public var title: String

    /// The contact's cell phone number.
    public var cellPhone: String

    /// The contact's work phone number.
    public var workPhone: String

    public var imageURL: String

    /// The contact's home phone number.
    public var homePhone: String

    /// The contact's work email address.
    public var workEmail: String

    /// The contact's website URL.
    public var website: String

    /// The contact's address.
    public var address: String

    /// The organization or company associated with the contact.
    public var organization: String


    /// Initializes a new VCard instance.
    ///
    /// - Parameters:
    ///   - fullName: The full name of the contact.
    ///   - nameComponents: The components of the contact's name (e.g., first name, last name).
    ///   - title: The title or job position of the contact.
    ///   - cellPhone: The contact's cell phone number.
    ///   - workPhone: The contact's work phone number.
    ///   - homePhone: The contact's home phone number.
    ///   - imageURL:
    ///   - workEmail: The contact's work email address.
    ///   - website: The contact's website URL.
    ///   - address: The contact's address.
    ///   - organization: The organization or company associated with the contact.
    public init(
        fullName: String,
        nameComponents: String,
        title: String,
        cellPhone: String,
        workPhone: String,
        homePhone: String,
        imageURL: String,
        workEmail: String,
        website: String,
        address: String,
        organization: String
    ) {
        self.fullName = fullName
        self.nameComponents = nameComponents
        self.title = title
        self.cellPhone = cellPhone
        self.workPhone = workPhone
        self.homePhone = homePhone
        self.imageURL = imageURL
        self.workEmail = workEmail
        self.website = website
        self.address = address
        self.organization = organization
    }


    /// Creates a string representation of the VCard.
    public func generateVCardString() -> String {
        var vcardString = "BEGIN:VCARD\n"
        vcardString += "N:\(nameComponents);\(fullName);\n"

        if !workPhone.isEmpty {
            vcardString += "TEL;TYPE=work,VOICE:\(workPhone)\n"
        }

        if !cellPhone.isEmpty {
            vcardString += "TEL;TYPE=cell,VOICE:\(cellPhone)\n"
        }

        if !homePhone.isEmpty {
            vcardString += "TEL;TYPE=home,VOICE:\(homePhone)\n"
        }

        if !imageURL.isEmpty {
            vcardString += "PHOTO;VALUE=URL:\(imageURL)\n"
        }

        if !workEmail.isEmpty {
            vcardString += "EMAIL:\(workEmail)\n"
        }

        if !organization.isEmpty {
            vcardString += "ORG:\(organization)\n"
        }

        if !title.isEmpty {
            vcardString += "TITLE:\(title)\n"
        }

        if !address.isEmpty {
            vcardString += "ADR;TYPE=WORK,PREF:;;\(address);PORTUGAL\n"
        }

        if !website.isEmpty {
            vcardString += "URL:\(website)\n"
        }

        vcardString += "END:VCARD"

        return vcardString
    }
}

extension VCard {
    public static var empty: Self = .init(
        fullName: "",
        nameComponents: "",
        title: "",
        cellPhone: "",
        workPhone: "",
        homePhone: "",
        imageURL: "",
        workEmail: "",
        website: "",
        address: "",
        organization: ""
    )
}
