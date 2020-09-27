//
//  NewsViewController.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

final class NewsViewController: UITableViewController, UITableViewDataSourcePrefetching {
    

    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    lazy var service = ServiceNetwork()
    lazy var photoService = PhotoService(container: self.tableView)
    var news: [NewsItem] = []
    var isLoading = false
    //var nextFromId = ""
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //news = (1...5).map { _ in NewsOfUser.randomOne }
        //service.getUserWall()
        
        setupTable()
        
        self.setLoadingScreen()
        tableView.prefetchDataSource = self
        
        getUserFeed()
        
        setupRefreshControl()
 

    }
    
    private func setupTable(){
        tableView.register(NewsPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(NewsPhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        
    }
    
    
    private func setupRefreshControl(){
        refreshControl = UIRefreshControl()
        let attr: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue
        ]
           refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
           refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    func getUserFeed(){
        
        service.getUserNewsFeed(){[weak self](newsIn) in
            guard let self = self else {return}
            self.news = newsIn
            //self.nextFromId = next
                self.tableView.reloadData()
                self.removeLoadingScreen()
                
            
        }
    }
    
    @objc func handleRefreshControl() {
         // Update your content…
        let mostFreshNewsDate = (self.news.first?.date ?? Date()).timeIntervalSince1970
        service.getUserNewsFeed(from: mostFreshNewsDate + 1){ [weak self](freshNews) in
            guard let self = self else {return}
            self.refreshControl?.endRefreshing()
            guard freshNews.count > 0 else {return}
            
            self.news = freshNews + self.news
             //self.nextFromId = next
            
            let indexPaths = (0..<freshNews.count)
                .map {IndexPath(item: $0, section: 0)}
            
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            
        }
      }
    
    @objc func expandCollapse(sender:UIButton) {
        
        self.tableView.reloadData()
    }

    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
 
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        
        switch item.type {
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! NewsPostCell
            //cell.button.isUserInteractionEnabled = tableView.isEditing
            cell.button.addTarget(self, action: #selector(NewsViewController.expandCollapse(sender:)), for: .touchUpInside)
            cell.configure(item: news[indexPath.row], dateFormatter: dateFormatter)
            return cell
        case .photo:
             let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! NewsPhotoCell
            cell.configure(item: news[indexPath.row], dateFormatter: dateFormatter)
            return cell
        }

    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let item = news[indexPath.row]
        // guard let cell = tableView.cellForRow(at: indexPath) as? NewsBaseCell
        //                     else {return UITableView.automaticDimension}
        let headerHeight = CGFloat(40)
        let footerHeight = CGFloat(24)
      
        let cellInset = NewsBaseCell.inset * 2
        
         switch item.type {
         case .photo:
                
                 let containerWidth = tableView.frame.width

                 let imageHeight = containerWidth * (item.photo?.aspectRatio ?? 1)
                 
             
           //  print("aspectRatio = \(item.photo?.aspectRatio) /n hight= \(imageHeight + cellInset) ")
                 return headerHeight + imageHeight + footerHeight + cellInset
        case .post:
//             guard let cell = tableView.cellForRow(at: indexPath) as? NewsPostCell
//                 else {return UITableView.automaticDimension}
//
//             let cellHight = cell.stackTextView.frame.height
             //let textHight = cell.textView.frame.height
            
            //let textSize = getTextSize(text: item.text ?? "", font: UIFont(name: "system", size: 12) ?? UIFont())
            //let textHeight = textSize.height
             //let cellHight = size.height > 200 ? 200 + cellInset : size.height + cellInset
             
             //print("Высота теста равна = \(textHight)")
             
             //return headerHeight + textHeight + footerHeight + cellInset
            
            return UITableView.automaticDimension
         }
     }

//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastRow = indexPath.row
//        if lastRow == news.count - 1 {
//            fetchData(lastRow)
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]){
        
        
        guard let maxRow = indexPaths.map({ $0.row }).max(),
                maxRow > news.count - 4,
                isLoading == false
            else { return }
        isLoading = true
        self.service.getUserNewsFeed(){[weak self](freshNews) in
            guard let self = self else {return}
            
            let newsCount = self.news.count
            
            self.news.append(contentsOf: freshNews)
            //self.nextFromId = next
            
            let indexPaths = (newsCount..<(newsCount + freshNews.count))
                .map {IndexPath(item: $0, section: 0)}
            
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.isLoading = false
            
            print("Количество новостей = \(self.news.count)")
            
        }
        

    }
    
    
//    private func fetchData(_ lastRow: Int){
//
//
//            self.service.getUserNewsFeed({(newsIn) in
//
////                if self.news.count > 30 {
////                    self.news = self.news.suffix(20)
////                }
//            self.news.append(contentsOf: newsIn)
//
//                print(self.news.count)
//                self.tableView.reloadData()
//
//            })
//
//    }
    
    // MARK: - Activiti Indicator
    
    // Set the activity indicator into the main view
    private func setLoadingScreen() {

        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)

        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)

        // Sets spinner
        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()

        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)

        tableView.addSubview(loadingView)

    }

    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {

        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true

    }
    
}
