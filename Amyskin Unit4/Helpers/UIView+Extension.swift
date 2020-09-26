//
//  UIView+Extension.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 23.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        //print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
