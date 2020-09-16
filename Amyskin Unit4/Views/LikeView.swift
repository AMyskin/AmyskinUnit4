//
//  LikeView.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 27.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit



protocol LikeDelegate: class {
    func likeEnabled(isLiked: Bool)
      
}

class LikeView: UIView {

   weak var delegate: LikeDelegate?
        
        var isLiked: Bool = false {
            didSet {
                updateLike()
            }
        }
        
        var likesCount: Int = 99 {
            didSet {
                countLabel.text = "\(likesCount)"
            }
        }
        
        lazy var likeButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.tintColor = .red
            button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return button
        }()
        
        lazy var countLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .red
            label.text = "\(likesCount)"
            label.textAlignment = .left
            return label
        }()
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 4
            return stackView
        }()
        
        // MARK: - Init
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        private func setup() {
            
            
        
            addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
                stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
            ])
            
            stackView.addArrangedSubview(likeButton)
            stackView.addArrangedSubview(countLabel)
            
        }
        
        // MARK: - Actions
    
 

 
        
        @objc func likeButtonTapped(_ sender: UIButton) {
            isLiked.toggle()
            delegate?.likeEnabled(isLiked: isLiked)
        }
        
        private func updateLike() {
            let imageName = isLiked ? "heart.fill" : "heart"
            
            UIView.transition(with: likeButton,
                              duration: 0.4,
                              options: .transitionFlipFromTop,
                              animations: {
                                self.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
            })
            
            //likeButton.setImage(UIImage(systemName: imageName), for: .normal)
          //  likesCount = isLiked ? likesCount + 1 : likesCount - 1
//            print (self.frame)
//            if likesCount >= 1000 {
//               self.frame = CGRect(x: 135, y: 170, width: 70, height: self.frame.height)
//            } else {
//                self.frame = CGRect(x: 135, y: 170, width: 65, height: self.frame.height)
//                }
            }
        

}
