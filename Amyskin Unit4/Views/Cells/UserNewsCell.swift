//
//  NewsCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 01.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

protocol NewsDelegate: class {
    func errorFunc()
    func likeNews(isLiked: Bool)
    func buttonTapped(cell: UserNewsCell, button : UIButton)
    func buttonTappedLike(cell: UserNewsCell)
}

class UserNewsCell: UITableViewCell, LikeDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
  
    @IBOutlet weak var likeControl: LikeView!
    @IBOutlet weak var countOfViewsLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsText: UITextView!
    
    weak var delegate: NewsDelegate?
    
    
    func likeEnabled(isLiked: Bool) {
         //print("news \(isLiked)")
        delegate?.likeNews(isLiked: isLiked )
        self.delegate?.buttonTappedLike(cell: self )
        likeControl.likesCount = isLiked ? likeControl.likesCount + 1 : likeControl.likesCount - 1
        
    }
    
    
    
   // var imageView2 = UIImageView()
    
    @IBAction func replyButtonPushed(_ sender: UIButton) {
        self.delegate?.buttonTapped(cell: self , button : sender)
    }
    
    
    @IBAction func comentButtonPushed(_ sender: UIButton) {
    
        self.delegate?.buttonTapped(cell: self , button : sender)
 
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
            userNameLabel.text = nil
            newsDateLabel.text = nil
            newsTextLabel.text = nil
            countOfViewsLabel.text = nil
            avatarView.avatarImage = nil
            likeControl.likesCount = 0
            likeControl.isLiked = false
            //newsImageView.image = nil

  
    }
    
    func configure(model: NewsOfUser, dateFormatter: DateFormatter) {
        userNameLabel.text = model.author
        newsDateLabel.text = dateFormatter.string(from: model.date)
        newsTextLabel.text = model.newsTest
        countOfViewsLabel.text = String(model.countOfViews)
        avatarView.imageURL = model.avatarUrl
        likeControl.likesCount = model.countOfLike
        //print(String(model.countOfLike))
        likeControl.isLiked = model.isLiked
       // newsImageView.image = model.image.first
        
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")

    }
    
    func setCollectionDelegate(_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    

    

    
    override func layoutSubviews() {
            super.layoutSubviews()
             likeControl.delegate = self
        }

}

