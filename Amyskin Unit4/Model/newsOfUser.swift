//
//  newsOfUser.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 01.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

public struct NewsOfUser: Equatable {
    var type: PostTypeEnum
    var author: String
    var avatarUrl: String?
    var imageUrl: [String]?
    var videoUrl: String?
    var ownerId: Int?
    var videoId: Int?
   
    let attachments: [WallUserAttachment]?
    
    var date : Date
    var newsTest : String
    var countOfViews : Int
    var countOfLike : Int
    var countOfReposts : Int
    var countOfComents : Int
    var isLiked : Bool
    var sourceId : Int?
    
 
    
    public static func == (lhs: NewsOfUser, rhs: NewsOfUser) -> Bool {
        return lhs.newsTest == rhs.newsTest
     
            && lhs.countOfViews == rhs.countOfViews
            && lhs.countOfLike == rhs.countOfLike
            && lhs.author == rhs.author
            && lhs.isLiked == rhs.isLiked
        
    }
}
