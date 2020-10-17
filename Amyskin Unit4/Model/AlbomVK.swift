//
//  AlbomVK.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 17.10.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation


struct AlbomVK: Codable {
    let id: Int
    let ownerId : Int
    let title: String?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case size

    }
    
}

struct AlbomPhotoVK: Codable {
    let sizes: [UrlPhoto]
    //let url: String?
}

struct UrlPhoto: Codable {
    let url: String?
}
