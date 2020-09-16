//
//  UIViewExtension.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
