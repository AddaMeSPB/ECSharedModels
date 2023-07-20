
import Foundation

// MARK: - VCardProperty
public enum VCardProperty: String, Codable {
    case N
    case FN
    case PHOTO
    case LOGO
    case TITLE
    case EMAIL
    case ORG
    case URL
    case TEL
    case ADR
    case FACEBOOK = "X-FACEBOOK"
    case SKYPE = "X-SKYPE"
    case INSTAGRAM = "X-INSTAGRAM"
    case LINKEDIN = "X-LINKEDIN"
    case TWITTER = "X-TWITTER"
    case VK = "X-VK"
    case TELEGRAM = "X-TELEGRAM"
}

// MARK: - VCard
public struct VCard: Codable, Equatable, Identifiable {

    public struct Contact: Codable, Equatable {
        /// The last name of the contact.
        public var lastName: String

        /// The first name of the contact.
        public var firstName: String

        /// An additional name or middle name of the contact.
        public var additionalName: String?

        /// The name prefix or honorific of the contact (e.g., Mr., Mrs., Dr.).
        public var namePrefix: String?

        /// The name suffix of the contact (e.g., Jr., Sr., PhD).
        public var nameSuffix: String?

        /// Initializes a new instance of `ContactName` with values for each property.
        ///
        /// - Parameters:
        ///   - lastName: The last name of the contact.
        ///   - firstName: The first name of the contact.
        ///   - additionalName: An additional name or middle name of the contact.
        ///   - namePrefix: The name prefix or honorific of the contact (e.g., Mr., Mrs., Dr.).
        ///   - nameSuffix: The name suffix of the contact (e.g., Jr., Sr., PhD).
        public init(
            lastName: String,
            firstName: String,
            additionalName: String? = nil,
            namePrefix: String? = nil,
            nameSuffix: String? = nil
        ) {
            self.lastName = lastName
            self.firstName = firstName
            self.additionalName = additionalName
            self.namePrefix = namePrefix
            self.nameSuffix = nameSuffix
        }

        /// Returns a string representation of the `ContactName` instance in vCard format.
        public var vcardRepresentation: String {
            "N:\(self.lastName);\(self.firstName);\(self.additionalName ?? "");\(self.namePrefix ?? "");\(self.nameSuffix ?? "")\n"
        }

        public var fullName: String {
            get {
                "\(firstName) \(lastName)"
            }
        }

        public var isFormValid: Bool {
            !self.firstName.isEmpty
            && !self.lastName.isEmpty
            && self.firstName.count >= 2
            && self.lastName.count >= 2
        }

        public static var empty: Self = .init(lastName: "", firstName: "")
        public static var Mock: Self = .init(lastName: "Stephan", firstName: "Danial")
    }

    public struct Address: Codable, Equatable, Identifiable {

        public enum AType: String, Codable, CaseIterable, Identifiable {
            public var id: Self {
                return self
            }
            
            case   home, work, postal, dom, intl, parcel
        }

        public var id: UUID

        /// Type: The type of address represented (dom(domestic), intl(international), postal, parcel, home, work)
        public var type: AType

        /// postOfficeAddress: Post Office Address
        public var postOfficeAddress: String

        /// ExtendedAddress: Extended Address
        public var extendedAddress: String?

        /// Street (eg. 123 Main Street)
        public var street: String

        /// Locality /City (eg. San Francisco)
        public var locality: String

        /// The region/state specifier (eg. CA)
        public var region: String?

        /// Post code (eg. 91921)
        public var postalCode: String

        /// Country (eg. USA)
        public var country: String

        /// Create an address for a VCARD style QR Code
        /// - Parameters:
        ///   - type: The type of address represented (dom(domestic), intl(international), postal, parcel, home, work)
        ///   - postOfficeAddress: Post Office Address
        ///   - extendedAddress: Extended Address
        ///   - street: Street (eg. 123 Main Street)
        ///   - locality: Locality /City (eg. San Francisco)
        ///   - region: The region specifier (eg. CA)
        ///   - postalCode: Post code (eg. 91921)
        ///   - country: Country (eg. USA)
        public init(
            id: UUID = .init(),
            type: AType,
            postOfficeAddress: String,
            extendedAddress: String?,
            street: String,
            locality: String,
            region: String?,
            postalCode: String,
            country: String
        ) {
            self.id = id
            self.type = type
            self.postOfficeAddress = postOfficeAddress
            self.extendedAddress = extendedAddress
            self.street = street
            self.locality = locality
            self.region = region
            self.postalCode = postalCode
            self.country = country
        }

        public var vcardRepresentation: String {
            return "ADR;TYPE=\(self.type):\(self.postOfficeAddress);\(self.extendedAddress ?? "");\(self.street);\(self.locality);\(self.region ?? "");\(self.postalCode);\(self.country)\n"
        }

        public var fullAddress: String {
            return "\(self.postOfficeAddress), \(self.extendedAddress ?? ""), \(self.street), \(self.locality), \(self.region ?? ""), \(self.postalCode), \(self.country)\n"
        }

        public var isFormValid: Bool {
            !self.postOfficeAddress.isEmpty
            && !self.street.isEmpty
            && !self.locality.isEmpty
            && !(self.region?.isEmpty ?? false)
            && !self.postalCode.isEmpty
            && !self.country.isEmpty
        }

        public static var work: Self = .init(type: .work, postOfficeAddress: "", extendedAddress: nil, street: "", locality: "", region: "", postalCode: "", country: "")

        public static var usa: Self = .init(type: .work, postOfficeAddress: "151 Moore Avenue", extendedAddress: nil, street: "151 Moore Avenue", locality: "Grand Rapids", region: "MI", postalCode: "49503", country: "United States of America")
    }

    public struct Telephone: Codable, Equatable, Identifiable {

        public enum TType: String, Codable, CaseIterable, Identifiable {
            public var id: Self {
                return self
            }

            case cell, work, home, fax
        }

        public var id: UUID
        public var type: TType
        public var number: String

        public init(
            id: UUID = .init(),
            type: VCard.Telephone.TType,
            number: String
        ) {
            self.id = id
            self.type = type
            self.number = number
        }

        public static var empty: Self = .init(type: .work, number: "")
        public static var demo: Self = .init(type: .work, number: "+79210000000")

        public var isTelephoneValied: Bool {
            !self.number.isEmpty && self.number.count >= 10
        }
    }

    public struct Email: Codable, Equatable, Identifiable {

        public var id: UUID = .init()
        public var text: String = ""

        public init(
            id: UUID = .init(),
            text: String = ""
        ) {
            self.id = id
            self.text = text
        }

        public static var empty: Self = .init()
        public static var demo: Self = .init(text: "demogood@mail.com")

        public var vcardRepresentation: String {
            return "\(VCardProperty.EMAIL.rawValue.uppercased()):\(self.text)\r\n"
        }

    }

    public struct SocialMedia: Codable, Equatable {
        public var facebook: String?
        public var skype: String?
        public var instagram: String?
        public var linkedIn: String?
        public var twitter: String?
        public var telegram: String?
        public var vk: String?

        public init(
            facebook: String?,
            skype: String?,
            instagram: String?,
            linkedIn: String?,
            twitter: String?,
            telegram: String?,
            vk: String?
        ) {
            self.facebook = facebook
            self.skype = skype
            self.instagram = instagram
            self.linkedIn = linkedIn
            self.twitter = twitter
            self.telegram = telegram
            self.vk = vk
        }

        public static var empty: Self = .init(
            facebook: nil,
            skype: nil,
            instagram: nil,
            linkedIn: nil,
            twitter: nil,
            telegram: nil,
            vk: nil
        )

        public static var telegram: Self = .init(
            facebook: nil,
            skype: nil,
            instagram: nil,
            linkedIn: nil,
            twitter: nil,
            telegram: "@iamdev2",
            vk: nil
        )

        public var vcardRepresentation: String {
            var result = ""

            if let fb = self.facebook {
                result += "\(VCardProperty.FACEBOOK.rawValue):\(fb)\n"
            }

            if let skype = self.skype {
                result += "\(VCardProperty.SKYPE.rawValue):\(skype)\n"
            }

            if let instagram = self.instagram {
                result += "\(VCardProperty.INSTAGRAM.rawValue):\(instagram)\n"
            }

            if let linkedIn = self.linkedIn {
                result += "\(VCardProperty.LINKEDIN.rawValue):\(linkedIn)\n"
            }

            if let twitter = self.twitter {
                result += "\(VCardProperty.TWITTER.rawValue):\(twitter)\n"
            }

            if let telegram = self.telegram {
                result += "\(VCardProperty.TELEGRAM.rawValue):\(telegram)\n"
            }

            if let vk = self.vk {
                result += "\(VCardProperty.VK.rawValue):\(vk)\n"
            }

            return result
        }

    }


    public var id: UUID
    public var position: String
    public var formattedName: String
    public var organization: String?
    public var contact: Contact
    public var imageURLs: [ImageURL] = []
    public var addresses: [Address] = []
    public var telephones: [Telephone] = []
    public var emails: [Email] = []
    public var urls: [URL] = []
    public var notes: [String] = []
    public var website: String?
    public var socialMedia: SocialMedia?

    /// Create a QR Code that contains a VCard
    /// - Parameters:
    ///   - name: The name to be used for the card
    ///   - formattedName: The name as it is to be displayed
    ///   - addresses: User's addresses
    ///   - organization: User's organization
    ///   - position: Job position, functional position or function
    ///   - imageURLs: Its images for logo and avatar
    ///   - telephone: An array of phone numbers. Format is (+)number, eg. +61000000000
    ///   - email: An array of email addresses (simple text, not validated)
    ///   - urls: Associated URLs
    ///   - notes: Some text to be attached to the card
    public init(
        id: UUID = UUID(),
        contact: Contact,
        formattedName: String,
        organization: String?,
        position: String,
        imageURLs: [ImageURL] = [],
        addresses: [Address] = [],
        telephones: [Telephone] = [],
        emails: [Email] = [],
        urls: [URL] = [],
        notes: [String] = [],
        website: String?,
        socialMedia: SocialMedia?
    ) {
        self.id = id
        self.contact = contact
        self.formattedName = formattedName
        self.organization = organization

        self.position = position
        self.imageURLs = imageURLs
        self.addresses = addresses
        self.telephones = telephones
        self.emails = emails
        self.urls = urls
        self.notes = notes
        self.socialMedia = socialMedia
    }

    public var vCardRepresentation: String {
        var result = "BEGIN:VCARD\r\n" +
            "VERSION:4.0\r\n"

        if !contact.firstName.isEmpty || contact.additionalName != nil || !contact.lastName.isEmpty {
            if let additionalName = contact.additionalName {
                result += "\(VCardProperty.N.rawValue):\(contact.lastName);\(contact.firstName);\(additionalName);\r\n"
            } else {
                result += "\(VCardProperty.N.rawValue):\(contact.lastName);\(contact.firstName);\r\n"
            }

        }

        if imageURLs.count > 2 {
            for image in imageURLs {
                result += "\(image.type.rawValue.uppercased());MEDIATYPE=image/png:\(image.urlString)\r\n"
                // LOGO;MEDIATYPE=image/png:http://example.com/logo.png
            }
        }

        if !position.isEmpty {
            result += "\(VCardProperty.TITLE.rawValue):\(position)\r\n"
        }

        if let org = organization {
            result += "\(VCardProperty.ORG.rawValue):\(org)\r\n"
        }

        if let website = website {
            result += "\(VCardProperty.URL.rawValue):\(website)\r\n"
        }

        if !telephones.isEmpty {
            // let numbers = telephones.map { $0 }.split(separator: ";")
            // TEL;TYPE=cell,VOICE:1234567890
            // TEL;TYPE=work,VOICE:9876543210
            // TEL;TYPE=home,VOICE:5678901234
            for tel in telephones {
                if tel.type == .fax {
                    result += "\(VCardProperty.TEL.rawValue);TYPE=\(tel.type):\(tel.number)\r\n"
                }
                result += "\(VCardProperty.TEL.rawValue);TYPE=\(tel.type),VOICE:\(tel.number)\r\n"
            }

        }

        if !emails.isEmpty {
            for email in emails {
                result += email.vcardRepresentation
            }
        }

        if !addresses.isEmpty {
            for adr in addresses {
                //ADR;TYPE=WORK,PREF:;;123 Main St;Portugal
                //"\(VCardProperty.ADR.rawValue);TYPE=\(adr.type),PREF:\(adr)\r\n"
                result += adr.vcardRepresentation
            }
        }

        if let socialMedia = socialMedia{

            result += socialMedia.vcardRepresentation
            //"\(VCardProperty.FACEBOOK.rawValue):\(facebook)\r\n"

        }

        result += "END:VCARD\r\n"

        return result
    }

    public var isVCardValid: Bool {

        !(self.organization?.isEmpty ?? false) &&
        self.contact.isFormValid &&
        self.addresses.filter({ $0.isFormValid == true }).count == self.addresses.count &&
        self.imageURLs.filter({ !$0.urlString.isEmpty }).count == self.imageURLs.count &&
        !self.position.isEmpty &&
        self.contact.isFormValid &&
        self.telephones.filter({$0.isTelephoneValied == true}).count == self.telephones.count
    }
}

extension VCard {

    public static var emptyContact: VCard.Contact = .init(lastName: "", firstName: "")
    public static var mockContact: VCard.Contact = .init(lastName: "Dan", firstName: "Stephan")

    public static var empty: Self = .init(
        contact: emptyContact,
        formattedName: "Alif",
        organization: nil,
        position: "CEO & IOS Developer",
        imageURLs: [],
        addresses: [Address.work],
        telephones:  [Telephone.empty],
        emails:  [Email.empty],
        urls: [URL(string: "https://addame.com") ?? URL(string: "https://www.apple.com")!],
        notes: [""],
        website: "https://addame.com",
        socialMedia: .telegram
    )

    public static var demo: Self = .init(
        contact: emptyContact,
        formattedName: "Alif",
        organization: "IT Company Adda.",
        position: "CEO & IOS Developer",
        imageURLs: ImageURL.draff,
        addresses: [Address.usa],
        telephones:  [Telephone.demo],
        emails:  [Email.demo],
        urls: [URL(string: "https://addame.com") ?? URL(string: "https://www.apple.com")!],
        notes: [""],
        website: "https://addame.com",
        socialMedia: .telegram
    )
}
