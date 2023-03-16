//
//  NewsScrollViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.02.2023.
//

import UIKit
import SDWebImage

class NewsScrollViewController: UIViewController {
    
    let session = Session.shared
    let service = NewsService()

    @IBOutlet weak var tableView: UITableView!
    
    let posters: [User] = [
    User(id: 30, image: UIImage(named: "morty_cop"), name: "Morty Cop"),
    User(id: 31, image: UIImage(named: "gear_cop"), name: "Greg Gearlickson"),
    User(id: 32, image: UIImage(named: "gromflomite"), name: "G-1531283")
    ]
    
    let newsPieces: [News] = [
        News(
            poster: User(id: 30, image: UIImage(named: "morty_cop"), name: "Morty Cop"),
        newsText: """
Staying Fit Under Earth’s Gravitational Pull

Ease of movement under Earth’s weak-ass gravitational field has many of us galactic tourists and transplants packing on the pounds. Follow these five fast fitness tips to keep your fleshy bile filled-bod in shleeng-shlaang-bleeng-blaaang-grin-graang-fraaaaaaaaalgf shape.

Shake it baby! Kick off your day with a tasty kale shake, and don’t forget to stir in some Dr. S’arpo’s Ultra-Dense Supermassive Black Hole Extract. Once that stuff hits your bloodstream you’ll be feelin’ HEAVY.
""",
         image: UIImage(named: "diet")),
        News(
            poster:  User(id: 31, image: UIImage(named: "gear_cop"), name: "Greg Gearlickson"),
        newsText: """
Choosing an Earth Religion That’s Right for You!
By Da’hou Ungherstahnk

If you are planning on visiting or moving to Earth, you may want to align yourself with a religion* to form a deeper bond with humans. While there are hundreds to choose from, here are some fast facts about the five most dominant religions on Earth.

There are many wacky quirks on Earth, but none are wackier than the concept of “religion.” Instead of distilling a code of ethics through Standard Galactic Protocol or the SovereignQUBE, humans take a more whimsical approach. They instead choose to worship vague ideas or deities as a way of framing the world around them.
""", image: UIImage(named: "religion")),
        News(
            poster: User(id: 32, image: UIImage(named: "gromflomite"), name: "G-1531283"),
        newsText: """
The #BasicHuman meme is TOO PERFECT!

Everyone in the Federation is LOSING IT over the galaxy’s hottest new meme, the #BasicHuman!
No one knows who he is or where he’s from, but he’s helping us all understand humans a little more.
""", image: UIImage(named: "basic_human"))
    ]
    
    var news = [NewsItems]()
    var newsGroups = [NewsGroups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("View did load, here shall be news")
        service.getNewsOld(token: session.token)
        service.getNews(token: session.token, completion: {news, groups in
            self.news = news
            self.newsGroups = groups
            print("the last news \(self.news.last?.text)")
            self.tableView.reloadData()
        })
        print("end news")
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
            
            if let pic = news[indexPath.section].attachments?.first(where: {$0.type == "photo"})?.photo?.sizes.last?.url {
                cell.postImage.sd_setImage(with: URL(string: pic))
                
            }
            

            return cell
        }
        
        if indexPath.row == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? PostButtonsCell else {
                return UITableViewCell()
            }
            
            // should be
            // cell.likeButton.likeInitial = news[indexPath.section].likes.count
            //and so on
            
            cell.likeButton.likeNumber = news[indexPath.section].likes.count
            cell.shareButton.shareNumber = news[indexPath.section].reposts.count
            cell.commentButton.commentNumber = news[indexPath.section].comments.count
            

            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath) as? PosterCell else {
            return UITableViewCell()
        }
        
        let pic = newsGroups[indexPath.section].photo
        cell.posterImage.sd_setImage(with: URL(string: pic))
        cell.posterName.text = newsGroups[indexPath.section].name
        
        let date = news[indexPath.section].date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        //new data
        
        cell.posterLastSeenLabel.text = dateFormatter.string(from: date)
        
        return cell
    }
    
    
}
