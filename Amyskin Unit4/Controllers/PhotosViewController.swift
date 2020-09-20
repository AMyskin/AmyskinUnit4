//
//  PhotosViewController.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit
import RealmSwift

final class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var service = ServiceNetwork()
    lazy var photoService = PhotoService(container: self.collectionView)
    
    lazy var realm: Realm = {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        print(realm.configuration.fileURL ?? "")
        return realm
    }()
    var notificationToken: NotificationToken?

    lazy var fotos = List<Foto>()
    var photos: [UIImage] = []
    var userId: Int = 0
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        subscribeToNotificationsWithRealm()
        loadFromNetwork()
        
     
    }
    
    private func reloadPhotos(){
        
        for (index, photo) in fotos.enumerated(){
            let imageView: UIImageView = UIImageView()
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            imageView.image = photoService.photo(at: indexPath, url: photo.photosUrl)
            if let image = imageView.image {
                photos.append(image)
            }
        }
        
    }
    
    
    private func subscribeToNotificationsWithRealm() {
        guard let object = realm.object(ofType: FriendData.self, forPrimaryKey: userId) else {
                  return
              }
        //fotos = realm.objects(Foto.self).filter("friendId == %@", userId)
           
        fotos = object.foto
        
        
        notificationToken = fotos.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.collectionView.reloadData()
                
            case let .update(_, deletions, insertions, modifications):
                //print(deletions, insertions, modifications)
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.deleteItems(at: deletions.mapToIndexPaths())
                    self?.collectionView.insertItems(at: insertions.mapToIndexPaths())
                    self?.collectionView.reloadItems(at: modifications.mapToIndexPaths())
                }, completion: nil)
                
            case let .error(error):
                print(error)
            }
            self?.reloadPhotos()
        }
    }
    

    
    func loadFromNetwork() {
        service.getFriendsPhoto(friend: userId)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? SliderViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first
        {
            controller.title = title
            controller.photosUrl = Array(fotos)
            controller.photos = photos
            controller.currentIndex = indexPath.row
        }
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        cell.imageURL = fotos[indexPath.row].photosUrl
        cell.imageView.image = photoService.photo(at: indexPath, url: cell.imageURL)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    enum Layout {
        static let columns: CGFloat = 3
        static let spacing: CGFloat = 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - Layout.spacing * (Layout.columns - 1)) / Layout.columns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spacing
    }
    
    static func storyboardInstance() -> PhotosViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController
    }
    
}
