//
//  NewsCell.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit
//import Kingfisher



final class NewsCell: UITableViewCell {
    

    
    let insets: CGFloat = 10
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!

    @IBOutlet weak var newsText: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    

    
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var repostsButton: UIButton!
    
    var imageURL: String?
//    {
//        didSet{
//            if let imageURL = imageURL, let url = URL(string: imageURL) {
//                photoImageView.kf.setImage(with: url)
//            } else {
//                photoImageView.image = nil
//                photoImageView.kf.cancelDownloadTask()
//            }
//        }
//    }
    var avatarURL: String?
//    {
//          didSet{
//              if let avatarURL = avatarURL, let url = URL(string: avatarURL) {
//                  authorImageView.kf.setImage(with: url)
//              } else {
//                  authorImageView.image = nil
//                  authorImageView.kf.cancelDownloadTask()
//              }
//          }
//      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView?.makeCircle()
    }
    
    func configure(item: NewsItem, dateFormatter: DateFormatter) {
        
        authorNameLabel.text = item.profile?.name
        publishedDateLabel.text = dateFormatter.string(from: item.date)

        newsText.text = item.text
        
        if  item.photo?.imageUrl == "" {
            photoImageView.isHidden = true
        } else {
            photoImageView.isHidden = false
        }

        imageURL = item.photo?.imageUrl
        avatarURL = item.profile?.imageUrl
 
        viewsButton.titleLabel?.text = String(item.viewsCount)
        likeButton.titleLabel?.text = String(item.likesCount)
        commentsButton.titleLabel?.text = String(item.commentCount)
        repostsButton.titleLabel?.text = String(item.repostsCount)
        
        
      
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorNameLabel.text = nil
        publishedDateLabel.text = nil
        newsText.text = nil
        //newsTextLabel.text = nil
        photoImageView.image = nil
        authorImageView.image = nil
        imageURL = nil
        avatarURL = nil
        //countOfViewLabel.text = nil
        // countOfLikeLabel.text = nil
    }
    
     func getLabelSize(text: String, font: UIFont) -> CGSize {
            let maxWidth = bounds.width - insets * 2
            let textBlock = CGSize(width: maxWidth,
                                   height: CGFloat.greatestFiniteMagnitude)
            
            let rect = text.boundingRect(
                with: textBlock,
                options: .usesLineFragmentOrigin,
                attributes: [.font: font],
                context: nil
            )
            
            let width = Double(rect.width)
            let height = Double(rect.height)
            
            let size = CGSize(width: ceil(width), height: ceil(height))
    //        let size = CGSize(width: width, height: height)

            return size
        }
    
}
