//
//  MyGroupTableViewController.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import RealmSwift
//import FirebaseDatabase

class MyGroupTableViewController: UITableViewController {
 
    lazy var service = ServiceNetwork()
    lazy var photoService = PhotoService(container: self.tableView)
    
    
    lazy var realm: Realm = {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        print(realm.configuration.fileURL ?? "")
        return realm
    }()
    var notificationToken: NotificationToken?
    
    lazy var myGroupList: Results<GroupData> = {
        return realm.objects(GroupData.self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        
        subscribeToNotificationsWithRealm()
        
        loadFromNetwork()

        //  service.getMyGroupsAlamofire()
        
    }
    
    private func subscribeToNotificationsWithRealm() {
        notificationToken = myGroupList.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
                
            case let .update(_, deletions, insertions, modifications):
                self?.tableView.beginUpdates()
                
                self?.tableView.deleteRows(at: deletions.mapToIndexPaths(),
                                           with: .automatic)
                self?.tableView.insertRows(at: insertions.mapToIndexPaths(),
                                           with: .automatic)
                self?.tableView.reloadRows(at: modifications.mapToIndexPaths(),
                                           with: .automatic)
                
                self?.tableView.endUpdates()
                
            case let .error(error):
                print(error)
            }
        }
    }
    

    
    func loadFromNetwork() {
        service.getMyGroups()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroupList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell

        cell.name.text = myGroupList[indexPath.row].name
       // cell.avatarView.avatarImage = myGroupList[indexPath.row].image
        //cell.avatarView.imageURL = myGroupList[indexPath.row].imageUrl
        
        cell.avatarView.avatarImage = photoService.photo(
                 at: indexPath,
                 url: myGroupList[indexPath.row].imageUrl
             )
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            service.deleteMyGroup(myGroupList[indexPath.row])
         }
     }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
          guard
              let allGroupsController = segue.source as? AllGroupTableViewController,
              let indexPath = allGroupsController.tableView.indexPathForSelectedRow
              else { return }
          
          let group = allGroupsController.allGroupList[indexPath.row]
          
         guard !myGroupList.contains(group) else { return }
         
        service.addToMyGroup(group)
       // addGroupToUserInFirebase(group)
          
      }


    
     // MARK: - Firebase
    
//    func addGroupToUserInFirebase(_ group : GroupData) {
//        
//        let fireGroup = FirebaseGroup(id: group.id, name: group.name, imageUrl: group.imageUrl ?? "", userId: Session.instance.userId)
//            ref
//                .child("\(Session.instance.userId)") // храню группы внутри пользователя
//                .child("groups")
//                .child("\(group.id)")
//                .setValue(fireGroup.toDictionary())
//                
//            
//        
//    }
    
       

    

    
}
