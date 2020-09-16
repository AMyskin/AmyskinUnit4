//
//  UserCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

 class UserCell: UITableViewCell {
    
   

    @IBOutlet weak var name: UILabel!{
        didSet {
                   self.name.textColor = UIColor.yellow
               }
    }
    

    @IBOutlet weak var avatarView: AvatarView!
    
    

    func configure(name: String, emblem: UIImage) {
        self.name.text = name
        self.avatarView.avatarImage = emblem
        
        self.backgroundColor = UIColor.black
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        self.avatarView.avatarImage = nil
    }
    


    
}
