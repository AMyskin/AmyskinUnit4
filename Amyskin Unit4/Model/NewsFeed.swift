//
//  NewsFeed.swift
//  lessson 3
//
//  Created by Alexander Myskin on 01.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
    case photo = "photo"
    case wallPhoto = "wall_photo"
}

// MARK: - NewsFeedElement
struct NewsFeedElement: Codable {
    let sourceID, date: Int
    let type: PostTypeEnum
    let text: String?
    let attachments: [Attachment]?
    let photos: PhotosNews?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case type
        case text
        case attachments
        case photos
        case comments, likes, reposts, views
        case postID = "post_id"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let video: AttachmentVideo?
    let doc: Doc?
    let photo: AttachmentPhoto?
    let link: Link?
    let audio: Audio?
}

// Mark: - PhotosNews
struct PhotosNews: Codable {
    let count: Int
    let arrayPhoto: [PhotosItems]
    enum CodingKeys: String, CodingKey {
          case count
          case arrayPhoto = "items"
      }
}
struct PhotosItems: Codable {
    let sizes: [ArrayPhoto]
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
}

struct ArrayPhoto: Codable {
    let url: String?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String
    let id, ownerID: Int
    let title: String
    let duration: Int
    let isExplicit, isFocusTrack: Bool
    let trackCode: String
    let url: String
    let date: Int
    //let mainArtists: [MainArtist]
    //let subtitle: String
    //let shortVideosAllowed, storiesAllowed: Bool

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration
        case isExplicit = "is_explicit"
        case isFocusTrack = "is_focus_track"
        case trackCode = "track_code"
        case url, date
        //case mainArtists = "main_artists"
        //case subtitle
        //case shortVideosAllowed = "short_videos_allowed"
        //case storiesAllowed = "stories_allowed"
    }
}

// MARK: - MainArtist
struct MainArtist: Codable {
    let name, domain, id: String
}

// MARK: - Doc
struct Doc: Codable {
    let id, ownerID: Int
    let title: String
    let size: Int
    let ext: String
    let date, type: Int
    let url: String
    let preview: Preview?
    //let accessKey: String

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, size, ext, date, type, url, preview
        //case accessKey = "access_key"
    }
}

// MARK: - Preview
struct Preview: Codable {
    let photo: PreviewPhoto
    let video: VideoElement?
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Codable {
    let sizes: [VideoElement]
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let src: String?
    let width, height: Int?
    let type: String?
    let fileSize: Int?
    let url: String?
    let withPadding: Int?



    enum CodingKeys: String, CodingKey {
        case src, width, height, type
        case fileSize = "file_size"
        case url
        case withPadding = "with_padding"

    }
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let title, linkDescription, target: String?
    let photo: LinkPhoto?
    //let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target, photo
       // case isFavorite = "is_favorite"
    }
}

// MARK: - LinkPhoto
struct LinkPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [VideoElement]
    let text: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
    }
}

// MARK: - AttachmentPhoto
struct AttachmentPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    //let accessKey: String
    let postID: Int?
    let sizes: [VideoElement]
    let text: String
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
       // case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
    }
}

// MARK: - AttachmentVideo
struct AttachmentVideo: Codable {
 
    let date: Int
    let videoDescription: String
    let image: [VideoElement] //,firstFrame: [VideoElement]
    let title: String
    let views: Int
    let id: Int?
    let ownerId: Int?

    enum CodingKeys: String, CodingKey {
    
        case date
        case videoDescription = "description"
        case image
        case title
        case views
        case id
        case ownerId = "owner_id"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int

}

// MARK: - Likes
struct Likes: Codable {
    let count: Int

}

// MARK: - PostSource
struct PostSource: Codable {
    let type: PostSourceType
    let platform: String?
}



// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

typealias NewsFeed = [NewsFeedElement]
