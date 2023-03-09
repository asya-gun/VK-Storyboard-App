//
//  NewsViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.12.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let session = Session.shared
    let service = NewsService()
    
    let postedUsers: [User] = [
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
        
        
        print("View did load, here shall be news")
        service.getNews(token: session.token)
        print("end news")
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsPieces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsViewCell else {
            return UITableViewCell()
            
        }
        
        cell.userImage.image = postedUsers[indexPath.row].image
        cell.userNameLabel.text = postedUsers[indexPath.row].name
        cell.userOnlineLabel.text = "Today"

        cell.newsTextLabel.text = newsPieces[indexPath.row].newsText
        cell.newsImageView.image = newsPieces[indexPath.row].image

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
