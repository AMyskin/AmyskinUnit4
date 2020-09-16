//
//  GroupData.swift
//  lessson 3
//
//  Created by Alexander Myskin on 01.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
import RealmSwift
//import FirebaseDatabase

class GroupData: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var imageUrl: String?
    
    override class func primaryKey() -> String? {
         return "id"
     }
    
     enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case imageUrl = "photo_50"
    }
    
    required init() {
        super.init()
    }
    init(id: Int, name: String, screenName: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.imageUrl = imageUrl
    }
    

    

}

//final class FirebaseGroup  {
//    let  id: Int
//    let  userId: Int // Для варианта если группы хранить в отдельной от пользователей ветке
//    let  name: String
//    let  imageUrl: String
//
//    var ref: DatabaseReference?
//
//    init(id: Int, name: String, imageUrl: String, userId: Int) {
//        self.id = id
//        self.name = name
//        self.imageUrl = imageUrl
//        self.userId = userId
//    }
//
//    init?(snapshot: DataSnapshot?) {
//        guard
//            let value = snapshot?.value as? [String: Any],
//            let name = value["name"] as? String,
//            let imageUrl = value["imageUrl"] as? String,
//            let id = value["id"] as? Int,
//            let userId = value["userId"] as? Int
//            else { return nil }
//
//        self.name = name
//        self.imageUrl = imageUrl
//        self.id = id
//        self.ref = snapshot?.ref
//        self.userId = userId
//    }
//
//    func toDictionary() -> [String: Any] {
//        return [
//            "name": name,
//            "imageUrl": imageUrl,
//            "userId": userId
//        ]
//    }


//}
