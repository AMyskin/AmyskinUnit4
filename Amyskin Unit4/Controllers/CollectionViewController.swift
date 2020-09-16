//
//  CollectionViewController.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 20.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
    var userImage : [UIImage] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(userImage.count)
        
        
    }
    
    
    
    
    
    // MARK: UICollectionViewDataSource
    static func storyboardInstance() -> CollectionViewController? {
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             return storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController
         }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userImage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserCollectionViewCell
        

        cell.image.image = userImage[indexPath.row]
        
        
      print ("-------asdfasdfasdf------\(collectionView.bounds.minY) ------------\(collectionView.bounds)")
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  collectionView.bounds.width
        let height = collectionView.bounds.height + collectionView.bounds.minY*2
        
        //print ("-------asdfasdfasdf------collectionView \(height)")
        return CGSize(width: (width), height: (height))


    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 1

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.1 * Double(indexPath.row)
        cell.layer.add(animation, forKey: nil)

        let fromValue = CGRect(x: cell.layer.bounds.origin.x, y: cell.layer.bounds.origin.y,   width: cell.layer.bounds.width/1.3, height: cell.layer.bounds.height/1.3)
        let toValue = CGRect(x: cell.layer.bounds.origin.x, y: cell.layer.bounds.origin.y,   width: cell.layer.bounds.width, height: cell.layer.bounds.height)

        let animation2 = CABasicAnimation(keyPath: "bounds")
        animation2.fromValue = fromValue
        animation2.toValue = toValue
        animation2.duration = 0.5
        cell.layer.add(animation2, forKey: nil)
    }
    
    
   
    
    
    
  
    
 

    
    
}
