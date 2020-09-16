//
//  FriendsHeaderCell.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 01.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class FriendsHeaderCell: UITableViewHeaderFooterView {

   
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerTitle: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
         super.awakeFromNib()
        
        // let color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        //self.addGradientBackground(firstColor: .systemFill, secondColor: color)
        //let color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.5)
        //self.backgroundColor = color
     }

}
