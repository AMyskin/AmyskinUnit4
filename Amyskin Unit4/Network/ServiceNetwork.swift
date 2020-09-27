//
//  FriendsNetwork.swift
//  lessson 3
//
//  Created by Alexander Myskin on 26.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import PromiseKit

enum AttachmentEnum: String {
    case photo = "photo"
    case video = "video"
    case audio = "audio"
    case doc = "doc"
    case link = "link"
}

class ServiceNetwork {
    
    let session = Session.instance
    var nextFromVKNews = ""
  
    
    
    lazy var realm: Realm = {
        var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        config.schemaVersion = 0
        let realm = try! Realm(configuration: config)
        //print(realm.configuration.fileURL ?? "")
        return realm
    }()
    
    
    
    func getVkMetod(path: String, queryItem: [URLQueryItem],_ callback: @escaping ( (Data) -> Void) ){
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = path
        components.queryItems = queryItem
        
        
        guard let url = components.url else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data , responce , eror in
            if let data = data{
                DispatchQueue.main.async {
                    callback(data)
                }
            }
            if let eror = eror {
                
                print("Ошибка загрузки данных!!! \n \(eror)")
            }
        }
        task.resume()
        
    }
    
    //    func getUserInfo(completion: @escaping (FirebaseUser) -> Void){
    //               let queryArray: [URLQueryItem] = [
    //                   URLQueryItem(name: "v", value: "5.122"),
    //                   URLQueryItem(name: "access_token", value: session.token)
    //               ]
    //               getVkMetod(path: "/method/account.getProfileInfo", queryItem: queryArray){ jsonData in
    //
    //                   do {
    //
    //
    //                    let response = try JSONDecoder().decode(FirebaseUser.self, from: jsonData)
    //
    //                   // print(response.userFirstName + " " + response.userLastName)
    //                    completion(response)
    ////
    ////                           self?.saveFriensToRealm(response.items)
    //
    //                   } catch {
    //                       print(error)
    //
    //                   }
    //               }
    //    }
    
    
    func getFriends(){
        //print(#function)
        let queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.52"),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        getVkMetod(path: "/method/friends.get", queryItem: queryArray){[weak self] jsonData in
            
            do {
                let response = try JSONDecoder().decode(VKResponse<FriendData>.self, from: jsonData)
                
                self?.saveFriensToRealm(response.items)
                
            } catch {
                print(error)
                
            }
        }
        
    }
    
    func getVideo(ownerId: Int, videoId:Int, completion: @escaping (String?) -> Void)   {
        //print(#function)
        var videoUrl: String?
        let queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.124"),
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "videos", value: "\(ownerId)_\(videoId)"),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        getVkMetod(path: "/method/video.get", queryItem: queryArray){ jsonData in
            
       
                
                let swiftyJson = try? JSON(data: jsonData)
                       guard
                        let responseItems = swiftyJson?["response"]["items"].array
                      
                
                else {return}
                
                videoUrl = responseItems.first?["player"].stringValue
                
                print(videoUrl ?? "no url ------------")
                
                completion(videoUrl)
                
                //let response = try JSONDecoder().decode(VKResponse<FriendData>.self, from: jsonData)
                
                //let items = response.items
      
        }
        
      
        
    }
    
    let baseUrl = "https://api.vk.com/method/"
    let apiKey = Session.instance.token
    
    func getFriendsWithPromise() -> Promise<VKResponse<FriendData>> {
        
        let url = baseUrl + "friends.get"
        
        let parameters: Parameters = [
            "v": 5.52,
            "fields": "photo_50",
            "access_token": apiKey
        ]

        let promise = Promise<VKResponse<FriendData>> { (resolver) in

            AF.request(url , parameters: parameters).responseData{ (response) in
                
                switch response.result {
                case .success(let data):
                    do {
                        let friends = try JSONDecoder().decode(VKResponse<FriendData>.self, from: data)
                        resolver.fulfill(friends)
                    } catch {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    resolver.reject(error)
                }
                
            }

        }
        return promise
    }
    

    
    
    
    //    func getFriends(_ completion: @escaping ([FriendData]) -> Void){
    //        //print(#function)
    //        let queryArray: [URLQueryItem] = [
    //            URLQueryItem(name: "v", value: "5.52"),
    //            URLQueryItem(name: "fields", value: "photo_50"),
    //            URLQueryItem(name: "access_token", value: session.token)
    //        ]
    //        getVkMetod(path: "/method/friends.get", queryItem: queryArray){[weak self] jsonData in
    //
    //            do {
    //                let response = try JSONDecoder().decode(VKResponse<FriendData>.self, from: jsonData)
    //
    //                    completion(response.items)
    //                    self?.saveFriensToRealm(response.items)
    //
    //            } catch {
    //                print(error)
    //                completion([])
    //            }
    //        }
    //
    //    }
    
    
    
    func getFriendsPhoto(friend: Int){
        //print(#function)
        let queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.52"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "owner_id", value: "\(friend)"),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        getVkMetod(path: "/method/photos.getAll", queryItem: queryArray){jsonData in
            
            do {
                
                let fotos = try JSONDecoder().decode(VKResponse<FotoData>.self, from: jsonData).items
                
                let tmpFoto = self.convertFoto(response: fotos)
                self.saveFotoToRealm(tmpFoto, friendId: friend)
                
                
            } catch {
                print(error)
                
            }
            
        }
    }
    
    func getUserWall(friend: Int, lastRow: Int,_ callback: @escaping ( ([NewsOfUser]) -> Void)){
        //print(#function)
        
        let queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.52"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "owner_id", value: "\(friend)"),
            URLQueryItem(name: "offset", value: "\(lastRow)"),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        getVkMetod(path: "/method/wall.get", queryItem: queryArray){[weak self] jsonData in
            guard let self = self else {return}
            
            do {
                
                let response = try JSONDecoder().decode(VKResponse<WallUserElement>.self, from: jsonData).items
                
                callback(self.convertWall(response: response))
                
            } catch {
                print(error)
                callback([])
            }
            
            
            
            //            let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            //
            //            print(json ?? "no json")
            
            
        }
        
        
        
    }
    
    func getUserNewsFeed(from startTime: TimeInterval? = nil,
                         
                         _ callback: @escaping ( ([NewsItem]) -> Void)){
        //print(nextFromVKNews)
        
//        if newQuery {
//                 nextFromVKNews = ""
//             }
        
   
        var queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.120"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "filters", value: "post,photo,wall_photo"), //wall_photo
            URLQueryItem(name: "start_from", value: nextFromVKNews),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        if let startTime = startTime {
            queryArray.append(
                URLQueryItem(name: "start_time", value: String(startTime))
            )
        }
        getVkMetod(path: "/method/newsfeed.get", queryItem: queryArray){[weak self] data in
            guard let self = self else {return}
            
            
            self.parseNewsFromJSON(withDate: data){[weak self](mynews, nextFrom) in
                self?.nextFromVKNews = nextFrom
                callback(mynews)
            }
            
//                          let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
//            
//                          print(json ?? "no json")
            
           //  Это основной способ
//            DispatchQueue.global().async {
//                do {
//                    let response = try JSONDecoder().decode(VKResponse<NewsFeedElement>.self, from: jsonData)
//
//                    DispatchQueue.main.async {
//                        let news = self.convertNew(response: response)
//
//                        callback(news)
//                        //                                    self.setVideoUrl(news: news) { (news) in
//                        //                                            callback(news)
//                        //                                        }
//
//                        // callback(self.convertNew(response: response))
//                    }
//
//                } catch {
//                    print(error)
//                    callback([])
//                }
//            }
        }
        
    }
    
    
       func parseNewsFromJSON(withDate data: Data, completion: @escaping ([NewsItem],String) -> Void) {

           
        if let swiftyJson = try? JSON(data: data) {
            
            let responseGroup = swiftyJson["response"]["groups"].arrayValue.map {NewsItemProfile(json: $0)}
            let responseProfiles = swiftyJson["response"]["profiles"].arrayValue.map {NewsItemProfile(json: $0)}
            let responseItems = swiftyJson["response"]["items"].arrayValue.map {NewsItem(json: $0)}
            let nextFrom = swiftyJson["response"]["next_from"].stringValue
            let allProfiles = responseGroup + responseProfiles
            
          
            
            
            for (index, news) in responseItems.enumerated() {
                responseItems[index].profile = allProfiles
                    .first(where: {abs(news.sourceId) == $0.id })
            }
            
            
            completion(responseItems,nextFrom)
        }
        
               
               
           
    
           
       }
    
    
    func parseNewsJSON(withDate data: Data, completion: @escaping ([NewsOfUser]) -> Void) {
        var tmpNews: [NewsOfUser] = []
        var tmpGroup: [GroupData] = []
        var tmpProfiles: [Profiles] = []
        
        let swiftyJson = try? JSON(data: data)
        guard let responseGroup = swiftyJson?["response"]["groups"].array,
            let responseProfiles = swiftyJson?["response"]["profiles"].array,
            let responseItems = swiftyJson?["response"]["items"].array else {return}
        
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
            tmpGroup = self.getGroupsForJSON(findIn: responseGroup)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
            tmpProfiles = self.getProfilesForJSON(findIn: responseProfiles)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
            tmpNews = self.getItemsForJSON(findIn: responseItems)
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
          
            for (index, news) in tmpNews.enumerated() {
                let tmpGroupSourceId = -(news.sourceId ?? 0)
                let group = tmpGroup.filter{ $0.id == tmpGroupSourceId}
                let profile = tmpProfiles.filter{ $0.id == news.sourceId}
                
                if group.count > 0 {
                    tmpNews[index].author = group[0].name
                    if let avatar = group[0].imageUrl {
                        tmpNews[index].avatarUrl = avatar
                    }
                }
                if profile.count > 0{
                    tmpNews[index].author = profile[0].firstName
                    if let avatar = profile[0].imageUrl {
                        tmpNews[index].avatarUrl = avatar
                    }
                }
            }
            
            
             completion(tmpNews)
            
            
        }
 
        
    }
    
    func getItemsForJSON(findIn: [JSON])->[NewsOfUser]{
        var tmpNews: [NewsOfUser] = []
        findIn.forEach{(items) in
            //print(items)
            
            var likesCount = 0
            var comentCount = 0
            var viewsCount = 0
            var repostsCount = 0
            var text = ""
            
            var newsDate: Date = Date()
            let author = ""
            let avatarUrl = ""
            var sourceID = 0
            var photosSizesUrl = ""
            
            var newsType: PostTypeEnum = .post
            
            let newsTypeString = items["type"].string
            switch newsTypeString {
            case "post":
                newsType = .post
                sourceID = items["source_id"].int ?? 0
                
                
                
                
                text = items["text"].string ?? ""
                viewsCount = items["views"]["count"].int ?? 0
                likesCount = items["likes"]["count"].int ?? 0
                comentCount = items["comments"]["count"].int ?? 0
                repostsCount = items["reposts"]["count"].int ?? 0
                newsDate = Date(timeIntervalSince1970: TimeInterval(items["date"].int ?? 0))
                
            case "wall_photo":
                newsType = .wallPhoto
                let photos = items["photos"]["items"].array
                let photosSizes = photos?.first?["sizes"].array
                let index = (photosSizes?.count ?? 1) - 1
                photosSizesUrl = photosSizes?[index]["url"].string ?? ""
    
                
                viewsCount = photos?.first?["comments"]["count"].int ?? 0
                likesCount = photos?.first?["likes"]["count"].int ?? 0
                comentCount = photos?.first?["comments"]["count"].int ?? 0
                repostsCount = photos?.first?["reposts"]["count"].int ?? 0
                
                sourceID = items["source_id"].int ?? 0
                
                
                
            case "photo":
                newsType = .photo
                
            default :
                newsType = .post
            }
            
            
            
            
            let tmpNew: NewsOfUser = NewsOfUser(type: newsType,
                                                author: author,
                                                avatarUrl: avatarUrl,
                                                imageUrl: [photosSizesUrl],
                                                attachments: nil,
                                                date: newsDate,
                                                newsTest: text,
                                                countOfViews: viewsCount,
                                                countOfLike: likesCount,
                                                countOfReposts: comentCount,
                                                countOfComents: repostsCount,
                                                isLiked: true,
                                                sourceId : sourceID)
            
            tmpNews.append(tmpNew)
        }
        
        
        
        return tmpNews
    }
    
    func getGroupsForJSON(findIn: [JSON])->[GroupData]{
        var groupsArray:[GroupData] = []
        
        findIn.forEach{(group) in
            let id = group["id"].int
            let avatar: String? = group["photo_50"].string
            let name: String? = group["name"].string
            
            if  let id = id, let avatar = avatar, let name = name {
                
                let group = GroupData(id: id, name: name, screenName: avatar, imageUrl: avatar)
                groupsArray.append(group)
            }
            
        }
        
        return groupsArray
    }
    func getProfilesForJSON(findIn: [JSON])->[Profiles]{
        var profilesArray:[Profiles] = []
        
        findIn.forEach{(profile) in
            let id = profile["id"].int
            let avatar: String? = profile["photo_50"].string
            let firstName: String? = profile["first_name"].string
            let lastName: String? = profile["last_name"].string
            
            if  let id = id, let avatar = avatar, let firstName = firstName, let lastName = lastName {
                
                let profiles = Profiles(id: id, firstName: firstName, lastName: lastName, imageUrl: avatar)
                profilesArray.append(profiles)
            }
            
        }
        
        return profilesArray
    }
    
    
    
    
    
    func getDate(item : NSDictionary) -> Date{
        var date: Date
        let newsDate = item["date"] as? Int
        if let newsDate = newsDate {
            date = Date(timeIntervalSince1970: TimeInterval(newsDate))
            return date
            
        } else {
            return Date()
        }
        
        
        
    }
    
    func getGroupsForNews(findIn: NSDictionary)->[GroupData]{
        var groupsArray:[GroupData] = []
        
        if  let groups = findIn["groups"] as? NSArray{
            for item in groups {
                
                
                let item = item as? NSDictionary
                let id = item?["id"] as? Int
                let avatar = item?["photo_50"] as? String
                let name = item?["name"] as? String
                
                
                
                if  let id = id, let avatar = avatar, let name = name {
                    
                    let group = GroupData(id: id, name: name, screenName: avatar, imageUrl: avatar)
                    groupsArray.append(group)
                }
                
            }
        }
        return groupsArray
    }
    func getProfiles(findIn: NSDictionary)->[Profiles]{
        var profilesArray:[Profiles] = []
        if  let profiles = findIn["profiles"] as? NSArray {
            
            for item in profiles {
                
                let item = item as? NSDictionary
                let id = item?["id"] as? Int
                let avatar = item?["photo_50"] as? String
                let firstName = item?["first_name"] as? String
                let lastName = item?["last_name"] as? String
                if  let id = id, let avatar = avatar, let firstName = firstName, let lastName = lastName {
                    
                    let profiles = Profiles(id: id, firstName: firstName, lastName: lastName, imageUrl: avatar)
                    profilesArray.append(profiles)
                }
                
            }
        }
        return profilesArray
    }
    
    
    
    func convertNew(response : VKResponse<NewsFeedElement>) -> [NewsOfUser]{
        
        var tmpNews: [NewsOfUser] = []
        var author = ""
        var avatarUrl = ""
        var attachmentFotoSizeDicUrl: String = ""
        var ownerId: Int?
        var videoId: Int?
        //var videoUrl: String?
          
        
        let news = response.items
        guard let profiles = response.profiles,
            let group = response.groups
             else {return []}
        //self.nextFromVKNews = response.nextFrom ?? ""
        
        
        
        news.forEach{(news) in
            let tmpGroup = group.filter{ $0.id == -news.sourceID}
            let tmpProfile = profiles.filter{ $0.id == news.sourceID}
            
            // print(tmpGroup)
            if tmpGroup.count > 0 {
                author = tmpGroup[0].name
                if let avatar = tmpGroup[0].imageUrl {
                    avatarUrl = avatar
                }
            } else {
                author = tmpProfile[0].firstName
                if let avatar = tmpProfile[0].imageUrl {
                    avatarUrl = avatar
                }
            }
            let newsType = news.type
            let newsDate = Date(timeIntervalSince1970: TimeInterval(news.date))
            let newsText = news.text
            let countOfViews = news.views?.count ?? 0
            let likesCount = news.likes?.count ?? 0
            let countOfReposts = news.reposts?.count ?? 0
            let countOfComents = news.comments?.count ?? 0
            if let newsAttach = news.attachments {
                
                
                
       
                
                
                newsAttach.forEach{(attachment) in
                    
             
                    
                    if attachment.type == AttachmentEnum.photo.rawValue{
                        
                        guard let photo = attachment.photo else {return}
                        let index = photo.sizes.count - 1
                        
                        attachmentFotoSizeDicUrl = photo.sizes[index].url ?? ""
                    }
                    if attachment.type == AttachmentEnum.video.rawValue{
                        guard let video = attachment.video
                        else {return}
                        let index = video.image.count - 1
                        
                        ownerId = video.ownerId
                        videoId = video.id
                        
                        attachmentFotoSizeDicUrl = video.image[index].url ?? ""
                        
//                        getVideo(ownerId: ownerId, videoId: id){ (url) in
//
//                           videoUrl = url
//
//
//                        }
                        
                        
                    }
                    if attachment.type == AttachmentEnum.doc.rawValue{
                        guard let doc = attachment.doc?.preview?.photo.sizes else {return}
                        let index = doc.count - 1
                        
                        attachmentFotoSizeDicUrl = doc[index].src ?? ""
                        
                    }
                    if attachment.type == AttachmentEnum.link.rawValue{
                        guard let link = attachment.link?.photo?.sizes else {return}
                        let index = link.count - 1
                        
                        attachmentFotoSizeDicUrl = link[index].url ?? ""
                        
                    }
                }
                
              
                    
                    let tmpNew: NewsOfUser = NewsOfUser(type: newsType,
                                                           author: author,
                                                           avatarUrl: avatarUrl,
                                                           imageUrl: [attachmentFotoSizeDicUrl],
                                                           ownerId: ownerId,
                                                           videoId: videoId,
                                                           attachments: nil,
                                                           date: newsDate,
                                                           newsTest: newsText ?? "",
                                                           countOfViews: countOfViews,
                                                           countOfLike: likesCount,
                                                           countOfReposts: countOfReposts,
                                                           countOfComents: countOfComents,
                                                           isLiked: true)
                       
                tmpNews.append(tmpNew)
//                setVideoUrl(news: tmpNew){ (new) in
//                    tmpNews.append(new)
//
//                }
                
                //фывафыва
            }
            
            
            
            //
            
            
            if let newsPhotos = news.photos {
                
                let countOfViews: Int = 0
                var likesCount : Int = 0
                var countOfReposts : Int = 0
                var countOfComents : Int = 0
                
                newsPhotos.arrayPhoto.forEach{(attachment) in
                    let index = attachment.sizes.count - 1
                    
                    attachmentFotoSizeDicUrl = attachment.sizes[index].url ?? ""
                    //attachmentFotoSizeDicUrl = attachment.sizes.first?.url ?? ""
                    
                    likesCount = attachment.likes?.count ?? 0
                    countOfReposts = attachment.reposts?.count ?? 0
                    countOfComents = attachment.comments?.count ?? 0
                }
                
                
                let tmpNew: NewsOfUser = NewsOfUser(type: newsType,
                                                    author: author,
                                                    avatarUrl: avatarUrl,
                                                    imageUrl: [attachmentFotoSizeDicUrl],
                                                    attachments: nil,
                                                    date: newsDate,
                                                    newsTest: newsText ?? "",
                                                    countOfViews: countOfViews,
                                                    countOfLike: likesCount,
                                                    countOfReposts: countOfReposts,
                                                    countOfComents: countOfComents,
                                                    isLiked: true)
                
      
                
                tmpNews.append(tmpNew)
            }
            
        }
        
        
//        for (index, news) in tmpNews.enumerated(){
//            setVideoUrl(news: news){_ in
//
//            }
//        }
        
   //print(tmpNews)
        
        
        return tmpNews
    }
    
    func setVideoUrl(news: [NewsOfUser], completion: @escaping ([NewsOfUser]) -> Void){
        
        guard news.count > 0 else {completion(news)
            return}
        var tmpNews = news
        for (index, news) in tmpNews.enumerated(){
            if let ownerId = news.ownerId,
                let id = news.videoId {
                
                    
                
                        getVideo(ownerId: ownerId, videoId: id){ (url) in
                    
                        tmpNews[index].videoUrl = url
                            completion(tmpNews)
                        }
                    
            }
        }
        
    }
//    func getVideoUrl(news: NewsOfUser, completion: @escaping (NewsOfUser) -> Void){
//         var tmpNews = news
//        
//             if let ownerId = news.ownerId,
//                 let id = news.videoId {
//                 
//                     
//                 
//                         getVideo(ownerId: ownerId, videoId: id){ (url) in
//                     
//                         tmpNews.videoUrl = url
//                             completion(tmpNews)
//                         }
//                     
//             }
//         
//         
//     }
    
    func convertWall(response : [WallUserElement]) -> [NewsOfUser]{
        
        var tmpNews: [NewsOfUser] = []
        
        var attachmentFotoSizeDicUrl: [String] = []
    
        
        response.forEach{(news) in
            
            //  author = news.ownerID
            //  avatarUrl = avatar
            // let newsType = news.postType
            let newsDate = Date(timeIntervalSince1970: TimeInterval(news.date))
            var newsText = news.text
            let countOfViews = 0
            let likesCount = news.likes.count
            var wallAttach: [WallUserAttachment]?
            if news.copyHistory?.count ?? 0 > 0 {
                wallAttach = news.copyHistory?[0].attachments
                if let text = news.copyHistory?[0].text {
                    newsText = text
                }
            } else {
                wallAttach = news.attachments
            }
            attachmentFotoSizeDicUrl = []
            
            if let wallAttach = wallAttach {
                
                wallAttach.forEach{(attachment) in
                    
                    if attachment.type.rawValue == AttachmentEnum.photo.rawValue{
                        var photo: String? = nil
                        
                        let photo1280 =  attachment.photo?.photo1280
                        let photo807 =  attachment.photo?.photo807
                        let photo604 =  attachment.photo?.photo604
                        let photo130 =  attachment.photo?.photo130
                        let photo75 =  attachment.photo?.photo75
                        
                        if photo1280 != nil {
                            photo = photo1280
                            
                        } else if photo807 != nil {
                            photo = photo807
                            
                        } else if photo604 != nil {
                            photo = photo604
                            
                        } else if photo130 != nil {
                            photo = photo130
                            
                        } else {
                            photo = photo75
                        }
                        if let photo = photo {
                            attachmentFotoSizeDicUrl.append(photo)
                        }
                    }
                    if attachment.type.rawValue == AttachmentEnum.video.rawValue{
                        let video1280  = attachment.video?.photo1280
                        let video800  = attachment.video?.photo800
                        let video640  = attachment.video?.photo640
                        let video320  = attachment.video?.photo320
                        let video130  = attachment.video?.photo130
                        
                        var photo: String? = nil
                        
                        if video1280 != nil {
                            photo = video1280
                            
                        } else if video800 != nil {
                            photo = video800
                            
                        } else if video640 != nil {
                            photo =  video640
                            
                        } else if video320 != nil {
                            photo =  video320
                            
                        } else {
                            photo =  video130
                        }
                        
                        if let photo = photo {
                            attachmentFotoSizeDicUrl.append(photo)
                        }
                        
                        
                    }
                    if attachment.type.rawValue == AttachmentEnum.link.rawValue{
                        let link1280  = attachment.photo?.photo1280
                        
                        let link604  = attachment.photo?.photo604
                        
                        let link130  = attachment.photo?.photo130
                        
                        var photo: String? = nil
                        
                        if link1280 != nil {
                            photo = link1280
                            
                        } else if link604 != nil {
                            photo =  link604
                            
                        }  else {
                            photo =  link130
                        }
                        
                        if let photo = photo {
                            attachmentFotoSizeDicUrl.append(photo)
                        }
                        
                        
                    }
                    
                }
            }
            
            //            if attachmentFotoSizeDicUrl.count > 0 {
            //                print("картинок обнаружено \(attachmentFotoSizeDicUrl.count)")
            //            }
            let tmpNew: NewsOfUser = NewsOfUser(type: PostTypeEnum.post,
                                                author: "",
                                                avatarUrl: "",
                                                imageUrl: attachmentFotoSizeDicUrl,
                                                attachments: news.attachments,
                                                date: newsDate,
                                                newsTest: newsText,
                                                countOfViews: countOfViews,
                                                countOfLike: likesCount,
                                                countOfReposts: 0,
                                                countOfComents: 0,
                                                isLiked: true)
            
            tmpNews.append(tmpNew)
        }
        
        
        return tmpNews
    }
    
    
    func convertFoto( response : [FotoData]) -> [Foto]{
        
        
        var attachmentFotoSizeDicUrl: [Foto] = []
        
        
        response.forEach{(foto) in
            
            var photo: String? = nil
            
            let photo2560 =  foto.photo2560
            let photo1280 =  foto.photo1280
            let photo807 =  foto.photo807
            let photo604 =  foto.photo604
            let photo130 =  foto.photo130
            let photo75 =  foto.photo75
            
            
            if photo2560 != nil {
                photo = photo2560
                
            } else if photo1280 != nil {
                photo = photo1280
                
            } else if photo807 != nil {
                photo = photo807
                
            } else if photo604 != nil {
                photo = photo604
                
            } else if photo130 != nil {
                photo = photo130
                
            } else {
                photo = photo75
            }
            if let photo = photo {
                
                let tmpFotos = Foto()
                tmpFotos.photosUrl = photo
                
                attachmentFotoSizeDicUrl.append(tmpFotos)
            }
        }
        
        
        
        return attachmentFotoSizeDicUrl
    }
    
    
    
    //FetchDataOperation -> ParseDataOperation -> SaveToRealmOperation -> DisplayDataOperation.
    

    
    func getMyGroups(){
        //print(#function)

        let groupQueue = OperationQueue()
        
        
        
        let jsonData = GetGroupDataOperation()
        jsonData.completionBlock = {
            print("jsonData")
        }
        
        let parseGroupData = ParseGroupData()
        parseGroupData.completionBlock = {
            print("parseGroupData")
        }
        
        let saveGroupToRealm = SaveGroupToRealm()
 
     
        
    
        parseGroupData.addDependency(jsonData)
        saveGroupToRealm.addDependency(parseGroupData)
        
        groupQueue.addOperations([jsonData, parseGroupData, saveGroupToRealm], waitUntilFinished: false)
        
  
        
    }
    
    
    
    
    
    func searchGroups( q: String, quantity: Int, _ callback: @escaping ( ([GroupData]) -> Void)){
        
        let queryArray: [URLQueryItem] = [
            URLQueryItem(name: "v", value: "5.52"),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "count", value: String(quantity)),
            URLQueryItem(name: "access_token", value: session.token)
        ]
        
        getVkMetod(path: "/method/groups.search", queryItem: queryArray){jsonData in
            
            
            do {
                
                let response = try JSONDecoder().decode(VKResponse<GroupData>.self, from: jsonData).items
                
                callback(response)
                
                
                
            } catch {
                print(error)
                callback([])
            }
            
            
        }
        
    }
    
    
    
    // MARK: Realm
    
    func saveFriensToRealm(_ friends: [FriendData]) {
        do{
            //let realm = try Realm()
            
            let oldObjects = realm.objects(FriendData.self)
            try realm.write{
                realm.delete(oldObjects)
                realm.add(friends)
                
                
            }
        }catch{
            print(error)
        }
    }
    
    func saveGroupsToRealm(_ groups: [GroupData]) {
        do{
            //let realm = try Realm()
            let oldObjects = realm.objects(GroupData.self)
            try realm.write{
                realm.delete(oldObjects)
                realm.add(groups)
            }
        }catch{
            print(error)
        }
    }
    
    func saveFotoToRealm(_ objects: [Foto], friendId: Int) {
        do{
            let realm = try Realm()
            guard let friend = realm.object(ofType: FriendData.self, forPrimaryKey: friendId) else { return }
            
            let oldObjects = friend.foto
            
            try realm.write{
                realm.delete(oldObjects)
                realm.add(objects)
                friend.foto.append(objectsIn: objects)
            }
        }catch{
            print(error)
        }
    }
    
     func addToMyGroup(_ group: GroupData) {

        
        do {
            try realm.write {
                realm.add(group, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
     func deleteMyGroup(_ group: GroupData) {
        do {
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error)
        }
    }
    
    
    
}

class GetGroupDataOperation: AsyncOperation {

    override func cancel() {
        //request.cancel()
        super.cancel()
    }
    
    var data: Data?
    
    override func main() {
 
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/groups.get"
            components.queryItems = [
                URLQueryItem(name: "v", value: "5.52"),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "access_token", value: Session.instance.token)
            ]
            
            
            guard let url = components.url else { return }
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data , responce , eror in
                if let data = data{
                    self.data = data
                    self.state = .finished
                }
                if let eror = eror {
                    
                    print("Ошибка загрузки данных!!! \n \(eror)")
                }
            }
            task.resume()
            
        
    }

    
}

class ParseGroupData: Operation {

    var outputData: [GroupData] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetGroupDataOperation,
            let data = getDataOperation.data else { return }
        
        do {
            
            let response = try JSONDecoder().decode(VKResponse<GroupData>.self, from: data).items
            //print("parseDataOperation")
            outputData = response
        } catch {
            print(error)
            
        }
        
        
    }
}

class SaveGroupToRealm: Operation {

    lazy var realm: Realm = {
        var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        config.schemaVersion = 0
        let realm = try! Realm(configuration: config)
        //print(realm.configuration.fileURL ?? "")
        return realm
    }()


    override func main() {
        guard let getDataOperation = dependencies.first as? ParseGroupData else { return }
        let data = getDataOperation.outputData
        do{
            //let realm = try Realm()
            let oldObjects = realm.objects(GroupData.self)
            try realm.write{
                realm.delete(oldObjects)
                realm.add(data)
            }
            print("SaveGroupToRealm")
        }catch{
            print(error)
        }
  
  }
}


