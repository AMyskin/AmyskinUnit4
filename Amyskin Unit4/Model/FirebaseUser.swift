//
//  User.swift
//  lessson 3
//
//  Created by Alexander Myskin on 18.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
//import FirebaseDatabase

//final class FirebaseUser: Decodable{
//    let userFirstName: String
//    let userLastName: String
//    let id: Int
//    var ref: DatabaseReference?
//    
//    init(userFirstName: String, userLastName: String, id: Int) {
//        self.userFirstName = userFirstName
//        self.userLastName = userLastName
//        self.id = id
//    }
//    
//    init?(snapshot: DataSnapshot?) {
//        guard
//            let value = snapshot?.value as? [String: Any],
//            let userFirstName = value["userFirstName"] as? String,
//            let userLastName = value["userLastName"] as? String,
//            let id = value["id"] as? Int
//            else { return nil }
//        
//        self.userFirstName = userFirstName
//        self.userLastName = userLastName
//        self.id = id
//        self.ref = snapshot?.ref
//    }
//    
//    func toDictionary() -> [String: Any] {
//        return [
//            "userFirstName": userFirstName,
//            "userLastName": userLastName
//   
//        ]
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case response
//        case id
//        case userFirstName = "first_name"
//        case userLastName = "last_name"
//
//    }
//    
//     init(from decoder: Decoder) throws {
//       let topContainer = try decoder.container(keyedBy: CodingKeys.self)
//       let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
//        self.id = try container.decode(Int.self, forKey: .id)
//        
//        self.userFirstName = try container.decode(String.self, forKey: .userFirstName)
//        self.userLastName = try container.decode(String.self, forKey: .userLastName)
//    
//
//    }
//}
