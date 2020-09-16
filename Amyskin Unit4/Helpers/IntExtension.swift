//
//  IntExtension.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 02.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation

extension Int {
    func getStringOfCount() -> String {
        let num = self
        var str = "\(num)"
        if num == 0 {
            return ""
        }
        if num > 1000 && num < 2000 {
            str = String(format: "%1d.1K", num/1000)
        }else  if num > 2000 {
            str = String(format: "%1dK", num/1000)
            
        }
        
        return str
    }
}
