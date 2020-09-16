//
//  GroupCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

protocol GroupCellDelegate: class {

    func buttonTapped(cell: GroupCell, button : UIButton)
    
}

class GroupCell: UITableViewCell {
 
    
    
    weak var delegate: GroupCellDelegate?
    
    
    @IBOutlet weak var name: UILabel!
    
    
    
    @IBOutlet weak var avatarView: AvatarView!
    
    func buttonTapped(button: UIButton) {
       
          delegate?.buttonTapped(cell: self, button: button)
      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //avatarView.delegate = self
        // Configure the view for the selected state
    }
    
}
