//
//  FotoData.swift
//  lessson 3
//
//  Created by Alexander Myskin on 02.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
import RealmSwift


// MARK: - FotoData
struct FotoData:  Codable {

    let photo1280 : String?
    let photo130 : String?
    let photo2560 : String?
    let photo604: String?
    let photo75 : String?
    let photo807: String?


    enum CodingKeys: String, CodingKey {
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo2560 = "photo_2560"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"

    }
}
