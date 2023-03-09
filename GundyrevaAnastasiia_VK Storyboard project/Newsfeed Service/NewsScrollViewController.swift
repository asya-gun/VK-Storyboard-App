//
//  NewsScrollViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.02.2023.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("View did load, here shall be news")
        service.getNews(token: session.token)
        print("end news")
        
//        tableView.register(PosterCell.self, forCellReuseIdentifier: "posterCell")
//        tableView.register(PostTextCell.self, forCellReuseIdentifier: "postTextCell")
//        tableView.register(PostImageCell.self, forCellReuseIdentifier: "picturesCell")
//        tableView.register(PostButtonsCell.self, forCellReuseIdentifier: "buttonsCell")
    }
    


}

extension NewsScrollViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newsPieces.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        //posters.count + newsPieces.count*3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row%4 == 0 {
            
//            return posterCell
//        }
        
//        if indexPath.row%4 == 1 {
        if indexPath.row == 1 {
            print("postTextCell значение index path \(indexPath.row) результат операции \(indexPath.row%4)")
            print("news: \(newsPieces.count)")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTextCell", for: indexPath) as? PostTextCell else {
                print("something went wrong")
                return UITableViewCell()
            }
            
            //1 = 0, 5 = 1, 9 = 2
            cell.postText.text = newsPieces[indexPath.section].newsText
            
//            if indexPath.row == 1 {
//                cell.postText.text = newsPieces[0].newsText
//
//            } else {
//
//            cell.postText.text = newsPieces[indexPath.row/4].newsText
//
//            }
            
            return cell
        }
        
//        if indexPath.row%4 == 2 {
        if indexPath.row == 2 {
            print("picturesCell значение index path \(indexPath.row) результат операции \(indexPath.row%4)")
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picturesCell", for: indexPath) as? PostImageCell else {
                return UITableViewCell()
            }
            
            cell.postImage.image = newsPieces[indexPath.section].image
            // 2 = 0, 6 = 1, 10 = 2
//            if indexPath.row == 2 {
//                cell.postImage.image = newsPieces[0].image
//
//            } else {
//
//                cell.postImage.image = newsPieces[indexPath.row/4].image
//            }
            return cell
        }
        
//        if indexPath.row%4 == 3 {
        if indexPath.row == 3 {
            print("buttonsCell значение index path \(indexPath.row) результат операции \(indexPath.row%4)")
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? PostButtonsCell else {
                return UITableViewCell()
            }
            //3, 7, 11
            
            return cell
        }
        
        print("posterCell значение index path \(indexPath.row) результат операции \(indexPath.row%4)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath) as? PosterCell else {
            return UITableViewCell()
        }
        
        // 0 = 0, 4 = 1, 8 = 2
        
        cell.posterImage.image = newsPieces[indexPath.section].poster.image
        cell.posterName.text = newsPieces[indexPath.section].poster.name
        
//        cell.posterImage.image = newsPieces[indexPath.row/4].poster.image
//        cell.posterName.text = newsPieces[indexPath.row/4].poster.name
        cell.posterLastSeenLabel.text = "Today"
        
        return cell
    }
    
    
}
