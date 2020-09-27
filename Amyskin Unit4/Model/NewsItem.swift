//
//  NewsItem.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 26.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
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
    
    var text: String?
    var photo: NewsItemPhoto?
    
    init(json: JSON) {
        self.sourceId = json["source_id"].intValue
        self.type = NewsItemType(rawValue: json["type"].stringValue) ?? .post
        let timeInterval = json["date"].intValue
        self.date = Date(timeIntervalSince1970: Double(timeInterval))
        self.likesCount = json["likes"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        
        switch self.type {
        case .post:
            self.text = json["text"].string
        case .photo:
            if let json = json["photos"]["items"].arrayValue.first {
                self.photo = NewsItemPhoto(json: json)
                self.likesCount = self.photo?.likesCount ?? 0
                self.commentCount = self.photo?.commentCount ?? 0
                self.repostsCount = self.photo?.repostsCount ?? 0
                self.viewsCount = self.photo?.viewsCount ?? 0
            }
        }
    }
}


final class NewsItemPhoto {
    var id: Int
    var date: Date
    var likesCount: Int = 0
    var commentCount: Int = 0
    var repostsCount: Int = 0
    var viewsCount: Int = 0
    
    var height: Int
    var width: Int
    var aspectRatio: CGFloat {
       
        return CGFloat(height) / CGFloat(width)
    }
    
    var imageUrl: String = ""
    
    init(json: JSON) {
        self.id = json["post_id"].intValue
        let timeInterval = json["date"].intValue
        self.date = Date(timeIntervalSince1970: Double(timeInterval))
        
        self.height = json["sizes"]
            .arrayValue
            .last?["height"].intValue ?? 0
        
        self.width = json["sizes"]
            .arrayValue
            .last?["width"].intValue ?? 0
        
         //print("aspectRatio= \(CGFloat(self.height) / CGFloat(self.width))")
        
        self.likesCount = json["likes"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        
  
            self.imageUrl = json["sizes"]
                .arrayValue
                .last?["url"]
            .string ?? ""
        
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
