//
//  NewsCell.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit
import Kingfisher

final class NewsCell: UITableViewCell {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!

    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    

    
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var repostsButton: UIButton!
    
    var imageURL: String? {
        didSet{
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                photoImageView.kf.setImage(with: url)
            } else {
                photoImageView.image = nil
                photoImageView.kf.cancelDownloadTask()
            }
        }
    }
    var avatarURL: String? {
          didSet{
              if let avatarURL = avatarURL, let url = URL(string: avatarURL) {
                  authorImageView.kf.setImage(with: url)
              } else {
                  authorImageView.image = nil
                  authorImageView.kf.cancelDownloadTask()
              }
          }
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView?.makeCircle()
    }
    
    func configure(item: NewsOfUser, dateFormatter: DateFormatter) {
        
        authorNameLabel.text = item.author
        publishedDateLabel.text = dateFormatter.string(from: item.date)

        newsText.text = item.newsTest
        
        if item.imageUrl == nil || item.imageUrl == [""] {
            photoImageView.isHidden = true
        } else {
            photoImageView.isHidden = false
        }

        imageURL = item.imageUrl?.first
        avatarURL = item.avatarUrl
 
        viewsButton.titleLabel?.text = item.countOfViews.getStringOfCount()
        likeButton.titleLabel?.text = item.countOfLike.getStringOfCount()
        commentsButton.titleLabel?.text = item.countOfComents.getStringOfCount()
        repostsButton.titleLabel?.text = item.countOfReposts.getStringOfCount()
        
        
      
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
    
}
