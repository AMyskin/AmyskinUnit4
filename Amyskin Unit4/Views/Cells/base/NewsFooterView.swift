//
//  NewsFooterView.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

final class NewsFooterView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    
    
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var repostsButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NewsFooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
      func configure(item: NewsItem) {
        
        
        //testLabel.text = String(item.likesCount)
       
        
        viewsButton.setTitle(String(item.viewsCount), for: .normal)
        likeButton.setTitle(String(item.likesCount), for: .normal)
        commentsButton.setTitle(String(item.commentCount), for: .normal)
        repostsButton.setTitle(String(item.repostsCount), for: .normal)

        
        

       }
    
    @IBAction func buttonTapped( _ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
}
