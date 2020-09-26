//
//  AvatarView.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 24.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
//import Kingfisher



class AvatarView: UIView {
    
    //weak var delegate: AvatarViewDelegate?
    
    var avatarImage: UIImage? {
        didSet {
            imageView.image = avatarImage
            //imageButton.setImage(avatarImage, for: .normal )
            
        }
    }
    
    var imageURL: String?
    
    // {
    //        didSet{
    //            if let imageURL = imageURL, let url = URL(string: imageURL) {
    //                imageView.kf.setImage(with: url)
    //            } else {
    //                imageView.image = nil
    //                imageView.kf.cancelDownloadTask()
    //            }
    //        }
    //    }
    
    lazy var imageView = UIImageView()
    
    
    var imageRadius: CGFloat = 20
    var widthShadow: CGFloat = 5
    var shadowOpacity: Float = 1.0
    
    var shadowColor: CGColor = UIColor.black.cgColor
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    
    private func setup() {
        self.layer.cornerRadius = imageRadius;
        self.layer.shadowColor = shadowColor;
        self.layer.shadowOpacity = shadowOpacity;
        self.layer.shadowRadius = widthShadow;
        self.layer.shadowOffset = CGSize (width: 5, height: 5)
        
        
        
        
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
        
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        imageButton.layer.cornerRadius = imageButton.frame.width / 2
        //        imageButton.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    //    @objc func buttonAction(_ sender: UIButton) {
    //        //print (#function)
    //        delegate?.buttonTapped(button: sender)
    //        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func avatarTapped(_ recognizer: UITapGestureRecognizer) {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.8
        pulse.toValue = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        imageView.layer.add(pulse, forKey: nil)
        
        
    }
    
    
}
