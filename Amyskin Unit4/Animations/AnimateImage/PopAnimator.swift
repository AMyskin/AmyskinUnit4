//
//  PopAnimator.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 08.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit


class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    let interactionController: SwipeInteractionController?
    
    
    
    var startImage: UICollectionViewCell? = nil
    let duration = 0.7
    var presenting = true
    var originFrame = CGRect.zero
    
    init(startImage: UICollectionViewCell, presenting: Bool, interactionController: SwipeInteractionController?){
        
        self.startImage = startImage
        self.presenting = presenting
        self.interactionController = interactionController
    }
    
    

    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
            return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if presenting {
            present(using : transitionContext)
        } else{
            
            dismiss(using : transitionContext)
        }
        
        
        
        
        
    }
    
    func present(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to),
            let presentedVC = transitionContext.viewController(forKey: .to),
            let recipeView =  transitionContext.view(forKey: .to)  else {
                transitionContext.completeTransition(false)
                return
                
        }
        
        
        guard let startImage = startImage else {return}
        
        let originFrame = startImage.convert(startImage.bounds, to: containerView)
        let finalFrame = transitionContext.finalFrame(for: presentedVC)
        
        
        let initialFrame =  originFrame
        
        
        let xScaleFactor = initialFrame.width / finalFrame.width
        
        let yScaleFactor = initialFrame.height / finalFrame.height
        
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        
        recipeView.transform = scaleTransform
        recipeView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
        recipeView.clipsToBounds = true
        
        
        //recipeView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(recipeView)
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            animations: {
                recipeView.transform = .identity
                recipeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
        
    }
    
    
    
    func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to),
          // let presentedVC = transitionContext.viewController(forKey: .to),
            let recipeView =  transitionContext.view(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
                
        }
        
        
        guard let startImage = startImage else {return}
        
        let finalFrame = startImage.convert(startImage.bounds, to: containerView)
        //let originFrame = transitionContext.finalFrame(for: presentedVC)
        
          //let initialFrame = originFrame
        
        
        guard let imageSize = containerView.viewWithTag(100) as? UIImageView else {return}
        
        print("Image dismiss size = \(imageSize.contentClippingRect) ")
        
        let initialFrame = imageSize.contentClippingRect
        
        let aspectRatio = initialFrame.height / initialFrame.width
        
        print("Image aspectRatio = \(aspectRatio) ")
        
        let xScaleFactor = finalFrame.width / initialFrame.width
        
        let yScaleFactor = finalFrame.height / initialFrame.height
        
        // не поличается правильтно сделать анимацию поэтому обрезаю уже после анимации
        
        let scaleTransform = aspectRatio < 1 ? CGAffineTransform(scaleX: yScaleFactor, y: yScaleFactor) :
            CGAffineTransform(scaleX: xScaleFactor, y: xScaleFactor)
        
        
        
        recipeView.frame = imageSize.contentClippingRect
        
  
        
 
        //recipeView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(recipeView)
        
      //  let finalTransitionSize = finalFrame
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            
            animations: {
               //recipeView.frame = finalFrame
               recipeView.transform =  scaleTransform
               recipeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
        
    }
    
    

    
    
    
    
    
    
    
    
    
}
