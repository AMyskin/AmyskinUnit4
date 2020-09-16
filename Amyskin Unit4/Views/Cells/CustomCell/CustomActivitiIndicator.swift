//
//  CustomActivitiIndicator.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 03.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class CustomActivitiIndicator: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    let circleView = UIView()
    let circleView2 = UIView()
    let circleView3 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
    
        // Этот метод для себя оставил чтобы не забыть, фукционала в данном случае тут нет
        Bundle.main.loadNibNamed("CustomActivitiIndicator", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = .clear
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        
        // Чтобы не забыть как добавлять UIView из кода решил для примера сделать тут
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .gray
        circleView.layer.cornerRadius = 10
        
        
        circleView2.translatesAutoresizingMaskIntoConstraints = false
        circleView2.backgroundColor = .gray
        circleView2.layer.cornerRadius = 10
        
        
        circleView3.translatesAutoresizingMaskIntoConstraints = false
        circleView3.backgroundColor = .gray
        circleView3.layer.cornerRadius = 10
        
        
        addSubview(circleView)
        addSubview(circleView2)
        addSubview(circleView3)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView2.translatesAutoresizingMaskIntoConstraints = false
        circleView3.translatesAutoresizingMaskIntoConstraints = false
        
        circleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30).isActive =     true
        circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive =     true
        
        circleView2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        circleView2.widthAnchor.constraint(equalToConstant: 20).isActive = true
        circleView2.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive =     true
        circleView2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive =     true
        
        circleView3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        circleView3.widthAnchor.constraint(equalToConstant: 20).isActive = true
        circleView3.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30).isActive =     true
        circleView3.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive =     true
        
        startAnimate()
        
        
    }
    
    func startAnimate(){
        
        circleView.backgroundColor = .gray
        circleView.layer.cornerRadius = 10
        circleView.isHidden = false
        circleView2.isHidden = false
        circleView3.isHidden = false
        circleView.alpha = 1
        circleView2.alpha = 1
        circleView3.alpha = 1
        
        let duration = 0.7
        UIView.animate(withDuration: duration, delay: 0,options: [.repeat,.autoreverse], animations: {
            self.circleView.alpha = 0
            self.circleView.frame.origin.y -= 3
        })
        UIView.animate(withDuration: duration,delay: duration*2/3, options: [.repeat,.autoreverse], animations: {
            self.circleView2.alpha = 0
            self.circleView2.frame.origin.y -= 3
        })
        UIView.animate(withDuration: duration,delay: duration*4/3, options: [.repeat,.autoreverse], animations: {
            self.circleView3.alpha = 0
            self.circleView3.frame.origin.y -= 3
        })
   
    }
    
     func stopAnimate(){
         
        circleView.layer.removeAllAnimations()
        circleView2.layer.removeAllAnimations()
        circleView3.layer.removeAllAnimations()
        circleView.alpha = 1
        circleView2.alpha = 1
        circleView3.alpha = 1
        circleView.isHidden = true
        circleView2.isHidden = true
        circleView3.isHidden = true
    }
    

    
    
}
