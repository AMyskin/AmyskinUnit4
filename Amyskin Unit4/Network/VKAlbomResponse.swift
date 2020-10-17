//
//  VKAlbomResponse.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 17.10.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//


import Foundation

struct VKAlbomResponse<T: Decodable>: Decodable {
    var items: [T]
    //var sizes: [T]
    var count : Int?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
        case items
        case count

    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws  {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        
        self.items = try container.decode([T].self, forKey: .items)

    }

}
