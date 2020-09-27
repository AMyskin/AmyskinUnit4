//
//  NewsPhotoCell.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import Kingfisher

final class NewsPhotoCell: NewsBaseCell {
    
    lazy var newsImageView = UIImageView()
    var imageURL: String?
    
     {
            didSet{
                if let imageURL = imageURL, let url = URL(string: imageURL) {
                    newsImageView.kf.setImage(with: url)
                } else {
                    newsImageView.image = nil
                    newsImageView.kf.cancelDownloadTask()
                }
            }
        }
    
    override func setup() {
        super.setup()
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.contentMode = .scaleAspectFill
        
        
        containerView.addSubview(newsImageView)
        
        newsImageView.anchor(in: containerView)
        

    }
    
    override func configure(item: NewsItem, dateFormatter: DateFormatter) {
        super.configure(item: item, dateFormatter: dateFormatter)
        imageURL = item.photo?.imageUrl
        //photo.images = item.text
      }
    
}
