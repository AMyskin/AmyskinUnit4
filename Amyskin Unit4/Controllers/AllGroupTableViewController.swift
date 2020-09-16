//
//  AllGroupTableViewController.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class AllGroupTableViewController: UITableViewController, GroupCellDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    

     lazy var service = ServiceNetwork()
    
    
    var allGroupList: [GroupData] = []
                            

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        searchBar.delegate = self
        searchGroups()
        
   
    }
    
    func searchGroups(_ text: String = "Swift") {
        service.searchGroups(q: text, quantity: 50 , {[weak self](group) in
               guard let self = self else {return}
               self.allGroupList = group
               
               self.tableView.reloadData()
               
           })
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
           searchGroups("IOS")
        }  else {
            searchGroups(searchText)
        }
            
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
 

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroupList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell

        cell.name.text = allGroupList[indexPath.row].name
       // cell.avatarView.avatarImage = allGroupList[indexPath.row].image
         cell.avatarView.imageURL = allGroupList[indexPath.row].imageUrl
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               allGroupList.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    

    

  func buttonTapped(cell: GroupCell, button: UIButton) {
       //guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        
            
                      let pulse = CASpringAnimation(keyPath: "transform.scale")
                      pulse.duration = 0.6
                      pulse.fromValue = 0.8
                      pulse.toValue = 1
                      pulse.initialVelocity = 0.5
                      pulse.damping = 1
                      
                      button.layer.add(pulse, forKey: nil)
             
          
   }

}
