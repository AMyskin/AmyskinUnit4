//
//  CustomPopAnimator.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 08.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else {
            return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
       // transitionContext.containerView.sendSubviewToBack(destination.view)
        
       // destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: +CGFloat.pi/2 )
        destination.view.frame = CGRect(x: -source.view.frame.height ,y:  100,   width: source.view.frame.height, height: source.view.frame.width)
        
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: 0 , y: +source.view.frame.height )
                                                        let rotation = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
                                                        source.view.transform = translation.concatenating(rotation)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: -destination.view.frame.height - destination.view.frame.width/4 - 20, y: +destination.view.frame.height -  185)
                                                        let scale = CGAffineTransform(rotationAngle: 0)
                                                        destination.view.transform = translation.concatenating(scale)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        destination.view.frame = CGRect(x: 0 , y: 0,   width: destination.view.frame.width, height: destination.view.frame.height)
                                    })
                                    
                                    
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
}

}
