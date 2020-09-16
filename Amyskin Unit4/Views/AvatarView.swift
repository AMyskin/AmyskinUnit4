//
//  AvatarView.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 24.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import Kingfisher

//protocol AvatarViewDelegate: class {
//
//    func buttonTapped( button : UIButton)
//
//}

 class AvatarView: UIView {
    
    //weak var delegate: AvatarViewDelegate?
    
    var avatarImage: UIImage? = nil {
        didSet {
            imageView.image = avatarImage
            //imageButton.setImage(avatarImage, for: .normal )

        }
    }
    
    var imageURL: String? {
        didSet{
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                imageView.kf.setImage(with: url)
            } else {
                imageView.image = nil
                imageView.kf.cancelDownloadTask()
            }
        }
    }
    
    lazy var imageView = UIImageView()
//    var imageButton = UIButton(){
//    didSet{
//        imageButton.layer.cornerRadius = 0.5 * imageButton.bounds.size.height
//        imageButton.layer.shadowOffset = CGSize(width: 5, height: 5)
//        imageButton.layer.borderColor = UIColor.white.cgColor
//        imageButton.layer.borderWidth = 2
//        imageButton.clipsToBounds = true
//    }
//    }
    
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
        
//        imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        addSubview(imageButton)
//
//        imageButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//
//            imageButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            imageButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//            imageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
//            imageButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
//        ])
//
//        imageButton.layer.borderColor = UIColor.white.cgColor
//        imageButton.layer.borderWidth = 2
        
        
        
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
        
        
//        imageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
//            self.imageView.transform = .identity
//        }, completion: { _ in
//
//        })
    }
    
    
}
