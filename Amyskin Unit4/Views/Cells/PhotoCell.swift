//
//  PhotoCell.swift
//  lessson 3
//
//  Created by Alexander Myskin on 02.08.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import Kingfisher


final class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
 
    
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
    
}
