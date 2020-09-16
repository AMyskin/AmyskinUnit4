//
//  VKResponse.swift
//  lessson 3
//
//  Created by Alexander Myskin on 06.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation

struct VKResponse<T: Decodable>: Decodable {
    var items: [T]
    var profiles : [Profiles]?
    var groups : [GroupData]?
    var nextFrom : String?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws  {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        
        self.items = try container.decode([T].self, forKey: .items)
        
 
        self.profiles = try? container.decodeIfPresent([Profiles].self, forKey: .profiles)
      
        
        self.groups = try? container.decodeIfPresent([GroupData].self, forKey: .groups) //container.decode([GroupData].self, forKey: .groups)

        self.nextFrom = try? container.decodeIfPresent(String.self, forKey: .nextFrom)
        
    }

}


