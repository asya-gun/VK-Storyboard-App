//
//  NewsScrollViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.02.2023.
//
//refreshControl
//infiniteScrolling
//доработать poster: сделать по id
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
    private var photoService: PhotoService?
    
    var lastDate: Date?
    var nextFrom = ""
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        photoService = PhotoService(container: tableView)
        setupRefreshControl()
        
//        service.getNewsOld(token: session.token)
        service.getNews(token: session.token, completion: {news, groups, str in
            self.news = news
            self.newsGroups = groups
            self.lastDate = news.first?.date
            self.nextFrom = str
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
    
    @objc func buttonAction(_ sender: UIControl!) {
        let row = sender.tag
        print("buttonRow \(row)")
    }
    
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

            guard let text = news[indexPath.section].text else { return UITableViewCell() }
            cell.postText.text = text
//            let textSize = cell.postText.font.pointSize * (CGFloat(text.count)/38)
//            print(textSize)
//            cell.showButton.addTarget(self, action: #selector(NewsScrollViewController.buttonAction(_:)), for: .touchUpInside)
//            cell.showButton.tag = indexPath.section
//            print("indexPath section button: \(indexPath.section)")
//            print("cell.showButton.tag button: \(cell.showButton.tag)")
            cell.delegate = self
            
            cell.tapShow = { [weak self] cell in
                guard let self = self,
                      let indexPath = tableView.indexPath(for: cell) else { return }
                if cell.showButton.isSelected {
                    print("button selected")
    //                cell.postText.lineBreakMode = .byWordWrapping
    //                cell.postText.numberOfLines = 0
    //                tableView.reloadData()
                } else if !cell.showButton.isSelected {
                    print("button not selected")
                }
                
            }
            
            return cell
        }
        
        if indexPath.row == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picturesCell", for: indexPath) as? PostImageCell else {
                return UITableViewCell()
            }
            
            if let picUrl = news[indexPath.section].attachments?.first(where: {$0.type == "photo"})?.photo?.sizes.last?.url {
                cell.configure(url: picUrl)
            } else {
                return UITableViewCell()
            }
            return cell
        }
        
        if indexPath.row == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? PostButtonsCell else {
                return UITableViewCell()
            }
            
//            cell.likeButton.likeNumber = news[indexPath.section].likes.count
            cell.likeButton.setLikeNumber(number: news[indexPath.section].likes.count)
            cell.shareButton.setShareNumber(number: news[indexPath.section].reposts.count)
            cell.commentButton.setCommentNumber(number: news[indexPath.section].comments.count)
            cell.commentButton.commentNumber = news[indexPath.section].comments.count
            

            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath) as? PosterCell else {
            return UITableViewCell()
        }
        
        guard let posterGroup = newsGroups.first(where: {$0.id == abs(news[indexPath.section].ownerId) }) else { return UITableViewCell() }
//        print(posterGroup.name)
        
        let picUrl = posterGroup.photo
        let pic = photoService?.photo(atIndexPath: indexPath, byUrl: picUrl)
//        cell.configure(imageUrl: picUrl)
        cell.configure(image: pic ?? UIImage())
        
        cell.configure(name: posterGroup.name)
        let date = news[indexPath.section].date
        cell.configure(lastSeenText: dateFormatter.string(from: date))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            guard let text = news[indexPath.section].text,
                  text.count > 0 else {
                return 0
            }
//            if text.count > 152 {
//                return 150
//            }
            return UITableView.automaticDimension
        case 2:
            guard let photo = news[indexPath.section].attachments?.first(where: {$0.type == "photo"})?.photo,
                    let url = photo.sizes.last?.url, !url.isEmpty else { return 0 }
            let width = view.frame.width
            let post = news[indexPath.section]
            let cellHeight = width * (photo.sizes.last?.aspectRatio ?? 0)
            return cellHeight
        case 3:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 1 {
//            if cell.showButton.isSelected {
//                print("button selected")
//                                cell.postText.lineBreakMode = .byWordWrapping
//                                cell.postText.numberOfLines = 0
//                                tableView.reloadData()
//            }
//        }
//    }
    
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        tableView.refreshControl?.tintColor = .systemMint
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        tableView.refreshControl?.beginRefreshing()
        guard let date = lastDate else {
            tableView.refreshControl?.endRefreshing()
            return
        }
        service.getNews(token: session.token, startTime: date, completion: { [weak self] news, groups in
            guard let self = self else { return }
            guard news.count > 0 else
            { print("no newnews")
                self.tableView.refreshControl?.endRefreshing()
                return
            }
            print("newnews count \(news.count)")
            print(groups.first?.name)
            print(self.lastDate)
            self.news.insert(contentsOf:news, at: 0)
            self.newsGroups += groups
            self.lastDate = news.first?.date
//
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        })
        
    }
}

extension NewsScrollViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > news.count - 3,
           !isLoading {
            isLoading = true
            service.getNews(token: session.token, nextFrom: nextFrom, completion: {[weak self] news, groups, str in
                guard let self = self else { return }
                let indexSet = IndexSet(integersIn: self.news.count..<self.news.count + news.count)
                self.news.append(contentsOf: news)
                self.tableView.insertSections(indexSet, with: .fade)
                self.newsGroups += groups
                self.nextFrom = str
                self.tableView.reloadData()
                self.isLoading = false
            })
        }
    }
    
    
}

extension NewsScrollViewController: PostTextCellDelegate {
    func didTapButton(atSection section: Int) {
        print(section)
    }
    
    
}
