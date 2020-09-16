//
//  UserCollectionViewCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell, LikeDelegate {
    func likeEnabled(isLiked: Bool) {
        //print(#function)
        //print(isLiked)
    }
    
    
    
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var likeControl: LikeView!
    
    
    
    override func layoutSubviews() {
           super.layoutSubviews()
            likeControl.delegate = self
       }
    
    
    
    
}

