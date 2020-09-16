//
//  UIScrollViewExtension.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollRectToVisible(frame, animated: animated)
    }
    
}
