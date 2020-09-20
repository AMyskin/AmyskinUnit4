//
//  FreindsCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 01.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit




class FreindsCell: UITableViewCell {

 
    
    //weak var delegate: FreindsCellDelegate?
    
    @IBOutlet weak var friendCellView: UIView!
    
    
    @IBOutlet weak var name: UILabel!{
        didSet {
                   self.name.textColor = UIColor.red
               }
    }
    
 
    
    @IBOutlet weak var avatarView: AvatarView!
    

    
//    func buttonTapped(button: UIButton) {
//        //print("FreindsCell")
//        delegate?.buttonTapped(cell: self, button: button)
//    }
    

    func configure(friend: FriendData) {
        
        self.name.text = "\(friend.firstName) \(friend.lastName)"
        //self.avatarView.imageURL = friend.avatar
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        //self.avatarView.avatarImage = nil
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.addGradientBackground(firstColor: color, secondColor: .systemBackground)
        //print("-----asd----- \(self.bounds) --------- \(bounds.size)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // avatarView.delegate = self
        // Configure the view for the selected state
    }
    
  
    
}
