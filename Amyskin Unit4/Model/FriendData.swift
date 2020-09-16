import Foundation
import RealmSwift

// MARK: - Friend
final class FriendData: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var online: Int = 0
    let foto = List<Foto>()
    
    override class func primaryKey() -> String? {
        return "id"
    }


    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case online

    }
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        self.online = try container.decode(Int.self, forKey: .online)
    }
    
}


