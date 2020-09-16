//
//  CGRectExtension.swift
//  Lesson10
//
//  Created by Vadim on 12.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
