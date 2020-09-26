//
//  VideoNewsCell.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 24.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import WebKit
//import Kingfisher

final class VideoNewsCell: UITableViewCell {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    @IBOutlet weak var videoWebView: WKWebView!
    
    
    @IBOutlet weak var viewsButton: UIButton!
     @IBOutlet weak var likeButton: UIButton!
     @IBOutlet weak var commentsButton: UIButton!
     @IBOutlet weak var repostsButton: UIButton!
    
    
    var imageURL: String?

    var avatarURL: String?

    
    @IBAction func buttonTapped(_ sender: UIButton) {
           sender.isSelected.toggle()
       }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView?.makeCircle()
    }
    
    func configure(item: NewsOfUser, dateFormatter: DateFormatter) {
        
        authorNameLabel.text = item.author
        publishedDateLabel.text = dateFormatter.string(from: item.date)
        imageURL = item.imageUrl?.first
        avatarURL = item.avatarUrl
        let url = item.videoUrl
        let request = URLRequest(url: URL(string: url ?? "")!)
        videoWebView.load(request)
        
        viewsButton.titleLabel?.text = item.countOfViews.getStringOfCount()
        likeButton.titleLabel?.text = item.countOfLike.getStringOfCount()
        commentsButton.titleLabel?.text = item.countOfComents.getStringOfCount()
        repostsButton.titleLabel?.text = item.countOfReposts.getStringOfCount()

    }
    

    
}

