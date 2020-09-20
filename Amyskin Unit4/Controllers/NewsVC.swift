//
//  NewsVC.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 01.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NewsDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter
    }()
    
    lazy var service = ServiceNetwork()
    lazy var photoService = PhotoService(container: self.tableView)
    
    var selectedCell = UICollectionViewCell()
    
    
    let transitionController = TransitionController()
    
    var newsTest : [NewsOfUser] = []
    //var user : User!
    var friend : FriendData!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getUserWall(friend: friend.id, {[weak self] (news) in
            guard let self = self else {return}
            
            self.newsTest = news
          
            self.tableView.reloadData()
                
            
           // print(self.friend ?? "")
            
        })
        
        
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Foto", style: .plain, target: self, action: #selector(addTapped))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addTapped(_ sender: UIButton) {
        
        
        
        guard  let photoVC = PhotosViewController.storyboardInstance() else {return}
        
        photoVC.userId = friend.id
        
        navigationController?.pushViewController(photoVC, animated: true)
        
        
    }
    
    static func storyboardInstance() -> NewsVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cell = storyboard.instantiateViewController(withIdentifier: "NewsVC") as? NewsVC
        
        return cell
    }
    
    private func setupTableView() {
        
        
        
        tableView.register(UINib(nibName: "UserNewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.allowsSelection = false
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsTest.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
        guard let cell = cell as? UserNewsCell else {return}
        cell.setCollectionDelegate(self, for: indexPath.row)
        
        let lastRow = indexPath.row
             if lastRow == newsTest.count - 1 {
                 fetchData(lastRow)
             }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! UserNewsCell
        
        var news = newsTest[indexPath.row]
        news.author = "\(friend.firstName) \(friend.lastName)"
        news.avatarUrl = friend.avatar
        
        
        
        cell.configure(model: news, dateFormatter: dateFormatter)
        
        cell.avatarView.avatarImage = photoService.photo(
                            at: indexPath,
                            url: news.avatarUrl
                        )
   
        
        
        cell.delegate = self
        
        
        
        return cell
    }
    
    
    
    
    
    private func fetchData(_ lastRow: Int){
        

            service.getUserWall(friend: friend.id,{(newsIn) in
                
             
            self.newsTest.append(contentsOf: newsIn)
            
                
                
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            })
    
    }
    
    
    //
    
    
    
    
    func buttonTapped(cell: UserNewsCell, button: UIButton){
        
        
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.8
        pulse.toValue = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        button.layer.add(pulse, forKey: nil)
        
        print("\(button) tapped on row \(indexPath.row) new countOfLike = \(newsTest[indexPath.row].countOfLike)")
        
        showErrorAlert()
        
        
    }
    
    
    
    
    
    func buttonTappedLike(cell: UserNewsCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        
        
        newsTest[indexPath.row].isLiked.toggle()
        
        let likesCount = newsTest[indexPath.row].countOfLike
        
        newsTest[indexPath.row].countOfLike = newsTest[indexPath.row].isLiked ? likesCount + 1 : likesCount - 1
        
        print("Like tapped on row \(indexPath.row) new countOfLike = \(newsTest[indexPath.row].countOfLike)")
        
        
    }
    
    
    
    func errorFunc() {
        //print(#function)
        showErrorAlert()
    }
    func likeNews(isLiked: Bool) {
        //print("like \(isLiked)")
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Under Conctruction",
            message: "Данный функционал в разработке",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Collection view data source
    
    enum Constants {
        static let maxPhotos = 4
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //       guard let cell = cell as? PhotoCollectionViewCell else {return}
    
    //        cell.alpha = 1
    //
    //        let animation = CABasicAnimation(keyPath: "opacity")
    //        animation.fromValue = 0
    //        animation.toValue = 1
    //        animation.duration = 1
    //        animation.beginTime = CACurrentMediaTime() + 0.1 * Double(indexPath.row)
    //        cell.layer.add(animation, forKey: nil)
    //
    //        let fromValue = CGRect(x: cell.layer.bounds.origin.x, y: cell.layer.bounds.origin.y,   width: cell.layer.bounds.width/3, height: cell.layer.bounds.height/3)
    //        let toValue = CGRect(x: cell.layer.bounds.origin.x, y: cell.layer.bounds.origin.y,   width: cell.layer.bounds.width, height: cell.layer.bounds.height)
    //
    //        let animation2 = CABasicAnimation(keyPath: "bounds")
    //        animation2.fromValue = fromValue
    //        animation2.toValue = toValue
    //        animation2.duration = 0.5
    //        cell.layer.add(animation2, forKey: nil)
    
    
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imagesCount = newsTest[collectionView.tag].imageUrl?.count else {return 1}
        return (imagesCount > Constants.maxPhotos ? Constants.maxPhotos : imagesCount) 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        // let newsModel = newsTest[collectionView.tag]
        if newsTest[collectionView.tag].imageUrl?.count == 0 {
            //        let image = newsTest[collectionView.tag].imageUrl
            return cell
            
        }
        cell.photoURL = newsTest[collectionView.tag].imageUrl?[indexPath.row]
        cell.photoImageView.image = photoService.photo(
            at: indexPath,
            url: cell.photoURL
        )
        
        
        
        if indexPath.row == Constants.maxPhotos - 1 {
            let count = (newsTest[collectionView.tag].imageUrl?.count ?? 1) - Constants.maxPhotos
            cell.countLabel.text = "+\(count)"
            cell.containerView.isHidden = count == 0
        }
        //
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if newsTest[collectionView.tag].imageUrl?.count ?? 1 > 1 {
            return CGSize(
                width: collectionView.bounds.width / 2,
                height: collectionView.bounds.height / 2
            )
        } else {
            return CGSize(
                width: collectionView.bounds.width ,
                height: collectionView.bounds.height
            )
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //       let collectionPhotoVC = CollectionViewController.storyboardInstance()
        //
        //        collectionPhotoVC?.userImage = user.newsTest[collectionView.tag].image
        //        navigationController?.pushViewController(collectionPhotoVC!, animated: true)
        
        
        
        guard  let collectionPhotoVC = SwipeVC.storyboardInstance(),
            let selectedcell2 = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            else {return}
        collectionPhotoVC.transitioningDelegate = self
        
        
        
       
        collectionPhotoVC.userImageUrl = newsTest[collectionView.tag].imageUrl ?? []
        collectionPhotoVC.userImage = reloadPhotos(collectionPhotoVC.userImageUrl)
        
        selectedCell = selectedcell2
        
        
        
        collectionPhotoVC.indexOfImage = indexPath.row
        //        navigationController?.pushViewController(collectionPhotoVC!, animated: true)
        //
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let secondViewController = storyboard.instantiateViewController(identifier: "SwipeVC")
        collectionPhotoVC.modalPresentationStyle = .fullScreen
        
        
        collectionPhotoVC.transitioningDelegate = transitionController
        transitionController.startView = selectedcell2.photoImageView
        
        self.present(collectionPhotoVC, animated: true, completion: nil)
    }
    
    private func reloadPhotos(_ url: [String]) -> [UIImage]{
        var photos : [UIImage] = []
        for (index, photoUrl) in url.enumerated(){
            let imageView: UIImageView = UIImageView()
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            imageView.image = photoService.photo(at: indexPath, url: photoUrl)
            if let image = imageView.image {
                photos.append(image)
            }
        }
        return photos
    }
    
    
    
    
    
    
    
    
    
    
    
}



extension NewsVC: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController, source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            
            return PopAnimator(startImage: selectedCell, presenting: true, interactionController: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            guard let swipeVC = dismissed as? SwipeVC else {
                return nil}
            
            return PopAnimator(startImage: selectedCell, presenting: false,interactionController: swipeVC.swipeInteractionController)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        guard let animator = animator as? PopAnimator,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            guard let animator = animator as? PopAnimator,
                let interactionController = animator.interactionController,
                interactionController.interactionInProgress
                else {
                    return nil
            }
            return interactionController
    }
    
    
}

