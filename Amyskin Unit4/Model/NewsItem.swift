//
//  NewsItem.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 26.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
import SwiftyJSON

enum NewsItemType: String {
    case post
    case photo = "wall_photo"
}


final class NewsItem {
    var sourceId: Int
    var profile: NewsItemProfile?
    var type: NewsItemType
    var date: Date
    var likesCount: Int = 0
    var commentCount: Int = 0
    var repostsCount: Int = 0
    var viewsCount: Int = 0
    
    var text: String = ""
    var imageUrl: String = ""
    
    init(json: JSON) {
        self.sourceId = json["source_Id"].intValue
        self.type = NewsItemType(rawValue: json["type"].stringValue) ?? .post
        let timeInterval = json["date"].intValue
        self.date = Date(timeIntervalSince1970: Double(timeInterval))
        self.likesCount = json["likes"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        
        switch self.type {
        case .post:
            self.text = json["text"].stringValue
        case .photo:
            self.imageUrl = json["photos"]["items"]
            .arrayValue
            .first?["photo_604"]
            .string ?? ""
        }
    }
}

final class NewsItemProfile {
    
    var id: Int
    var name: String
    var imageUrl: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        if let name = json["name"].string {
            self.name = name
        } else {
            let firstName = json["first_name"].stringValue
            let lastName = json["last_name"].stringValue
            self.name = "\(firstName) \(lastName)"
                .trimmingCharacters(in: .whitespaces)
        }
        self.imageUrl = json["photo_50"].stringValue
    }


}
