//
//  NewsHeaderView.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import Kingfisher

final class NewsHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    var authorImageUrl: String?     {
        didSet{
            if let authorImageUrl = authorImageUrl, let url = URL(string: authorImageUrl) {
                authorImageView.kf.setImage(with: url)
            } else {
                authorImageView.image = nil
                authorImageView.kf.cancelDownloadTask()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NewsHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView?.makeCircle()
    }
    
    func configure(item: NewsItem, dateFormatter: DateFormatter) {
        

        authorNameLabel.text = item.profile?.name
        publishedDateLabel.text = dateFormatter.string(from: item.date)
        
        authorImageUrl = item.profile?.imageUrl

    
        //avatarURL = item.profile?.imageUrl
    }
    
}
