//
//  ArrayExtension.swift
//  WeatherClient
//
//  Created by Vadim on 13.08.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    
    func mapToIndexPaths() -> [IndexPath] {
        return map { IndexPath(row: $0, section: 0) }
    }
}
