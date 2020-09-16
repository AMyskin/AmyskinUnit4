//
//  CustomActivitiIndicator2.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 05.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
class CustomActivitiIndicator2: UIView {
    
  
    let shapeLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    let bezierPath = UIBezierPath()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        
        
        shapeLayer.fillColor = UIColor.blue.withAlphaComponent(0.5).cgColor
         shapeLayer.strokeColor = UIColor.green.cgColor
         
 
         
         //set up lines
         bezierPath.move(to: CGPoint(x: 200, y: 170))
         bezierPath.addLine(to: CGPoint(x:50, y: 170))
         bezierPath.addArc(withCenter: CGPoint(x: 50, y: 130), radius: 40, startAngle:1.57, endAngle: 4.71, clockwise: true)
         bezierPath.addArc(withCenter: CGPoint(x: 130, y: 90), radius: 80, startAngle: 3.14, endAngle: -0.40, clockwise: true)
         bezierPath.addArc(withCenter: CGPoint(x: 200, y: 115), radius: 55, startAngle: 4.71, endAngle: 1.5, clockwise: true)
         
         bezierPath.close()
         //
         //UIColor.black.setStroke()
         bezierPath.stroke()
         shapeLayer.lineWidth = 8
         shapeLayer.path = bezierPath.cgPath
         self.layer.addSublayer(shapeLayer)
        
        
         

        
        
    }
    

    
    func startAnimation() {
        
        
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")

        strokeEndAnimation.fromValue = 0.1
        strokeEndAnimation.toValue = 1.05
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 10
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        shapeLayer.add(animationGroup, forKey: "drawLineAnimation")
        
        
        
        
        circleLayer.backgroundColor = UIColor.red.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.cornerRadius = 10
        circleLayer.position = CGPoint(x: 50.5, y: 108.5)
        
        self.layer.addSublayer(circleLayer)
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = bezierPath.cgPath
        followPathAnimation.duration = 5
        followPathAnimation.repeatCount = .infinity
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        circleLayer.add(followPathAnimation, forKey: nil)
        
    }
    
    func stopAnimation(){
        self.shapeLayer.removeAllAnimations()
        self.circleLayer.removeAllAnimations()
        self.isHidden = true
    }
    
    
}

