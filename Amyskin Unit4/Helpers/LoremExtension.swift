//
//  Lorem+Avatar.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

public extension Lorem {
    
    static var avatar: UIImage? {
        return UIImage(named: "Avatars/\(String(Int.random(in: 1...20)))")
    }
    
    static var thumbnail: UIImage? {
        return UIImage(named: "Thumbnails/\(String(Int.random(in: 1...10)))")
    }
    
    static var photo: UIImage? {
        return UIImage(named: "Photos/\(String(Int.random(in: 1...5)))")
    }
    
}
