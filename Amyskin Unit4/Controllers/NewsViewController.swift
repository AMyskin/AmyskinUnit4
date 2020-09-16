//
//  NewsViewController.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit

final class NewsViewController: UITableViewController {
    

    let loadingView = UIView()
    

    let spinner = UIActivityIndicatorView()
    

    let loadingLabel = UILabel()
    
    lazy var service = ServiceNetwork()
    
    var news: [NewsOfUser] = []
    
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
        
        
        self.setLoadingScreen()
        
        getUserFeed()
 
        
        refreshControl = UIRefreshControl()
           refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl!.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    func getUserFeed(){
        
        service.getUserNewsFeed(newQuery : true){[weak self](newsIn) in
            guard let self = self else {return}
            self.news = newsIn
            
                self.tableView.reloadData()
                self.removeLoadingScreen()
                self.refreshControl?.endRefreshing()
            
        }
    }
    
    @objc func handleRefreshControl() {
         // Update your content…
        getUserFeed()
//        DispatchQueue.main.async {
//            self.refreshControl?.endRefreshing()
//         }
      }
    
 
    
    // MARK: - Navigation
    
    
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postNews = news[indexPath.row]
        if postNews.type == .wallPhoto {
            //print("wall_photo")
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoNewsCell
            cell.configure(item: news[indexPath.row], dateFormatter: dateFormatter)
            
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! NewsCell
        cell.configure(item: news[indexPath.row], dateFormatter: dateFormatter)
        
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == news.count - 1 {
            fetchData(lastRow)
        }
    }
    
    private func fetchData(_ lastRow: Int){
        

            self.service.getUserNewsFeed({(newsIn) in
                
//                if self.news.count > 30 {
//                    self.news = self.news.suffix(20)
//                }
            self.news.append(contentsOf: newsIn)
            
                print(self.news.count)
                
                
                self.tableView.reloadData()
               
            })
    
    }
    
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
