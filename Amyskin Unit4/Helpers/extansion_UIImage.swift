//
//  extansion_UIImage.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 10.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

extension UIImageView {
    var contentClippingRect: CGRect {
        var newWidth: CGFloat
        var newHeight: CGFloat
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

//        if image.size.height >= image.size.width {
//
//            newHeight = frame.size.height
//            newWidth = ((image.size.width / (image.size.height)) * newHeight)
//
//            if CGFloat(newWidth) > (frame.size.width) {
//                let diff = Float((frame.size.width) - newWidth)
//                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
//                newWidth = frame.size.width
//            }
//        } else {
//            newWidth = frame.size.width
//            newHeight = (image.size.height / image.size.width) * newWidth
//
//            if CGFloat(newHeight) > frame.size.height {
//                let diff = Float((frame.size.height) - newHeight)
//                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
//                newHeight = frame.size.height
//            }
//        }
//
//        let size = CGSize(width: newWidth, height: newHeight)
        newWidth = image.size.width * scale
        newHeight = image.size.height * scale
        if CGFloat(newWidth) > (frame.size.width) {
                    //let diff = Float((frame.size.width) - newWidth)
            let myDiff = frame.size.width / newWidth
                    //newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                    //newWidth = frame.size.width
            newHeight = newHeight * myDiff
            newWidth = newWidth * myDiff
                }
        
        if CGFloat(newHeight) > frame.size.height {
                       // let diff = Float((frame.size.height) - newHeight)
            let myDiff = frame.size.height / newHeight
                       //newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                // newHeight = frame.size.height
            newHeight = newHeight * myDiff
                newWidth = newWidth * myDiff
                    }
        
        
        let size = CGSize(width: newWidth, height: newHeight)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

extension UIImageView {

    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat

        guard let image = image else { return frame.size }

        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)

            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth

            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        return .init(width: newWidth, height: newHeight)
    }
}
