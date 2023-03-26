//
//  NewsScrollViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.02.2023.
//

import UIKit
import SDWebImage
import PromiseKit

class NewsScrollViewController: UIViewController {
    
    let session = Session.shared
    let service = NewsService()

    @IBOutlet weak var tableView: UITableView!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter
    }()
   
    var news = [NewsItems]()
    var newsGroups = [NewsGroups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        service.getNewsOld(token: session.token)
        service.getNews(token: session.token, completion: {news, groups in
            self.news = news
            self.newsGroups = groups
            print("the last news \(self.news.last?.text)")
            self.tableView.reloadData()
        })
        print("news count \(news.count)")
        
//        tableView.register(PosterCell.self, forCellReuseIdentifier: "posterCell")
//        tableView.register(PostTextCell.self, forCellReuseIdentifier: "postTextCell")
//        tableView.register(PostImageCell.self, forCellReuseIdentifier: "picturesCell")
//        tableView.register(PostButtonsCell.self, forCellReuseIdentifier: "buttonsCell")
    }
    


}

extension NewsScrollViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTextCell", for: indexPath) as? PostTextCell else {
                print("something went wrong")
                return UITableViewCell()
            }

            cell.postText.text = news[indexPath.section].text
            
            return cell
        }
        
        if indexPath.row == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picturesCell", for: indexPath) as? PostImageCell else {
                return UITableViewCell()
            }
            
            if let picUrl = news[indexPath.section].attachments?.first(where: {$0.type == "photo"})?.photo?.sizes.last?.url {
                cell.configure(url: picUrl)
            }
            return cell
        }
        
        if indexPath.row == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? PostButtonsCell else {
                return UITableViewCell()
            }
            
            cell.likeButton.likeNumber = news[indexPath.section].likes.count
            cell.shareButton.shareNumber = news[indexPath.section].reposts.count
            cell.commentButton.commentNumber = news[indexPath.section].comments.count
            

            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath) as? PosterCell else {
            return UITableViewCell()
        }
        
        let pic = newsGroups[indexPath.section].photo
        cell.configure(imageUrl: pic)
        cell.configure(name: newsGroups[indexPath.section].name)
        let date = news[indexPath.section].date
        cell.configure(lastSeenText: dateFormatter.string(from: date))
        
        return cell
    }
    
    func configure(imageUrl: String) {
        
    }
    
}
