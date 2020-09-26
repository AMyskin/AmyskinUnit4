//
//  FriendService.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 23.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit


final class FriendService {
    
    func sectionsOfFriends(friends: [FriendData]) -> Array<String>{
        return      Array(
            Set(
                friends.compactMap ({
                    var tmp : String?
                    if String($0.lastName.prefix(1)).uppercased() != "" {
                        tmp = String($0.lastName.prefix(1)).uppercased()
                    } else {
                        tmp = nil
                    }
                    return tmp
                })
            )
        ).sorted()
    }
    
    func arrayOfFriends(sections: Array<String> , friens: [FriendData]) ->Array<Array<FriendData>> {
        var tmp:Array<Array<FriendData>> = []
        for section in sections {
            let letter: String = section
            tmp.append(friens.filter { $0.lastName.hasPrefix(letter) && letter != ""})
        }
        return tmp
    }
    
    
    
    
}

