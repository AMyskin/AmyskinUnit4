//
//  PhotoNewsCell.swift
//  lessson 3
//
//  Created by Alexander Myskin on 01.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
//import Kingfisher

final class PhotoNewsCell: UITableViewCell {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
           sender.isSelected.toggle()
       }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView?.makeCircle()
    }
    
    func configure(item: NewsItem, dateFormatter: DateFormatter) {
        
        authorNameLabel.text = item.profile?.name
        publishedDateLabel.text = dateFormatter.string(from: item.date)
        imageURL = item.photo?.imageUrl
        avatarURL = item.profile?.imageUrl
        
        viewsButton.titleLabel?.text = String(item.photo?.viewsCount ?? 0)
        likeButton.titleLabel?.text = String(item.photo?.likesCount ?? 0)
        commentsButton.titleLabel?.text = String(item.photo?.commentCount ?? 0)
        repostsButton.titleLabel?.text = String(item.photo?.repostsCount ?? 0)

    }
    

    
}
