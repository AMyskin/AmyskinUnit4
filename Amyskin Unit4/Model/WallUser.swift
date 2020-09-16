//
//  WallUser.swift
//  lessson 3
//
//  Created by Alexander Myskin on 01.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation

// MARK: - WallUserElement
struct WallUserElement: Codable {
    let id, fromID, ownerID, date: Int
    let postType: PostType?
    let text: String
    
  //  let canDelete: Int
  //  let canPin: Int?
   // let canArchive, isArchived: Bool
    let attachments: [WallUserAttachment]?
   // let postSource: WallUserPostSource
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let geo: Geo?
    let copyHistory: [CopyHistory]?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case postType = "post_type"
        case text
        
       // case canDelete = "can_delete"
      //  case canPin = "can_pin"
     //   case canArchive = "can_archive"
     //   case isArchived = "is_archived"
        case attachments
       // case postSource = "post_source"
        case comments, likes, reposts, geo
        case copyHistory = "copy_history"
    }
}

// MARK: - WallUserAttachment
struct WallUserAttachment: Codable {
    let type: AttachmentType
    let photo: AttachmentWallPhoto?
    let video: PurpleVideo?
    let link: PurpleLink?
}

// MARK: - AttachmentPhoto
struct AttachmentWallPhoto: Codable {

    let photo1280: String?
    let photo130: String?
    let photo2560: String?
    let photo604: String?
    let photo75: String?
    let photo807: String?


    enum CodingKeys: String, CodingKey {

        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo2560 = "photo_2560"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"

    }
}

// MARK: - PurpleLink
struct PurpleLink: Codable {
    let url: String?
    let title, caption: String?
    let linkDescription: String?
    let isExternal: Int?
    let photo: LinkPhotoWall?

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case isExternal = "is_external"
        case photo
    }
}

struct LinkPhotoWall: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
   // let height: Int
    let photo130, photo604, photo75: String?
    let text: String?
    //let width: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
     //   case height
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case text//, width
    }
}





enum AttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
    case video = "video"
    case doc = "doc"
    case audio = "audio"
    case photos_list = "photos_list"
    case album = "album"
    case poll = "poll"
}

// MARK: - PurpleVideo
struct PurpleVideo: Codable {
    let accessKey: String
    //let canComment, canEdit, canLike, canRepost: Int
    //let canSubscribe, canAddToFaves, canAdd, canAttachLink: Int
    let comments: Int?
    let date: Int
   // let videoDescription: String
    let duration: Int
    let photo130, photo320, photo640, photo800: String?
    let photo1280: String?
    //let firstFrame130, firstFrame160, firstFrame320, firstFrame800: String
   // let firstFrame1280: String?
    //let width, height, id, ownerID: Int
    let title, trackCode: String
    let views: Int
    //let isPrivate: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        //case canComment = "can_comment"
        //case canEdit = "can_edit"
//        case canLike = "can_like"
//        case canRepost = "can_repost"
//        case canSubscribe = "can_subscribe"
//        case canAddToFaves = "can_add_to_faves"
//        case canAdd = "can_add"
//        case canAttachLink = "can_attach_link"
        case comments, date
        //case videoDescription = "description"
        case duration
        case photo130 = "photo_130"
        case photo320 = "photo_320"
        case photo640 = "photo_640"
        case photo800 = "photo_800"
        case photo1280 = "photo_1280"
//        case firstFrame130 = "first_frame_130"
//        case firstFrame160 = "first_frame_160"
//        case firstFrame320 = "first_frame_320"
//        case firstFrame800 = "first_frame_800"
//        case firstFrame1280 = "first_frame_1280"
//        case width, height, id
//        case ownerID = "owner_id"
        case title
        case trackCode = "track_code"
        case views
       // case isPrivate = "is_private"
    }
}



// MARK: - CopyHistory
struct CopyHistory: Codable {
    let  date: Int
   // let postType: PostType
    let text: String
    let attachments: [WallUserAttachment]?
    //let postSource: CopyHistoryPostSource

    enum CodingKeys: String, CodingKey {
        //case id
       // case ownerID = "owner_id"
       // case fromID = "from_id"
        case date
      //  case postType = "post_type"
        case text, attachments
      //  case postSource = "post_source"
    }
}

//// MARK: - CopyHistoryAttachment
//struct CopyHistoryAttachment: Codable {
//    let type: AttachmentType
//    let photo: AttachmentWallPhoto?
//    let video: FluffyVideo?
//    let link: FluffyLink?
//}

// MARK: - FluffyLink
struct FluffyLink: Codable {
    let url: String
    let title, linkDescription, target: String
    let photo: LinkPhotoWall?

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target, photo
    }
}

// MARK: - FluffyVideo
struct FluffyVideo: Codable {
    let accessKey: String
   // let canComment, canLike, canRepost, canSubscribe: Int
   // let canAddToFaves, canAdd: Int
    let comments: Int?
    let date: Int
    let videoDescription: String?
    let duration: Int
    let photo130, photo320: String?
    let photo640: String?
    let id, ownerID: Int
    let title, trackCode: String
    let views: Int
    let localViews: Int?
   // let platform: String?
    let photo800: String?
    let restriction: Restriction?
    let contentRestricted, width, height: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
//        case canComment = "can_comment"
//        case canLike = "can_like"
//        case canRepost = "can_repost"
//        case canSubscribe = "can_subscribe"
//        case canAddToFaves = "can_add_to_faves"
//        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration
        case photo130 = "photo_130"
        case photo320 = "photo_320"
        case photo640 = "photo_640"
        case id
        case ownerID = "owner_id"
        case title
        case trackCode = "track_code"
        case views
        case localViews = "local_views"
     //   case platform
        case photo800 = "photo_800"
        case restriction
        case contentRestricted = "content_restricted"
        case width, height
    }
}

// MARK: - Restriction
struct Restriction: Codable {
    let title, text: String
    let alwaysShown, blur, canPlay, canPreview: Int
    let cardIcon, listIcon: [Icon]

    enum CodingKeys: String, CodingKey {
        case title, text
        case alwaysShown = "always_shown"
        case blur
        case canPlay = "can_play"
        case canPreview = "can_preview"
        case cardIcon = "card_icon"
        case listIcon = "list_icon"
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height: Int
    let url: String
    let width: Int
}





enum PostType: String, Codable {
    case post = "post"
}

// MARK: - Geo
struct Geo: Codable {
    let type: GeoType?
    let coordinates: String
    let place: Place
}

// MARK: - Place
struct Place: Codable {
    let id: Int
    let title: String
    let latitude, longitude: Double
    let created: Int
    let icon: String
    let checkins, type: Int?
    let country: City
    let address: String?
    let city: City?
}

enum City: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(City.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for City"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum GeoType: String, Codable {
    case place = "place"
    case point = "point"
}



// MARK: - WallUserPostSource
struct WallUserPostSource: Codable {
    let type: PostSourceType?
    let platform: Platform?
    let data: String?
}

enum Platform: String, Codable {
    case ipad = "ipad"
    case iphone = "iphone"
}



typealias WallUser = [WallUserElement]
