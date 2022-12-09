//
//  FriendsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    let friends = [
        Friend(image: UIImage(named: "krombopulos_michael"), name: "Krombopulos Michael"),
        Friend(image: UIImage(named: "revolio_clockberg_jr"), name: "Revolio Clockberg Jr."),
        Friend(image: UIImage(named: "mr_frundles"), name: "Mr. Frundles"),
        Friend(image: UIImage(named: "mr_meseeks"), name: "Mr. Meeseeks"),
        Friend(image: UIImage(named: "flippy_nips"), name: "King Flippy Nips"),
        Friend(image: UIImage(named: "lucius_needful"), name: "Lucius Needful"),
        Friend(image: UIImage(named: "shleemypants"), name: "Shleemypants"),
        Friend(image: UIImage(named: "ants_in_my_eyes_johnson"), name: "Ants in my Eyes Johnson"),
        Friend(image: UIImage(named: "dr_xenon_bloom"), name: "Dr. Xenon Bloom"),
        Friend(image: UIImage(named: "unity"), name: "Unity"),
        Friend(image: UIImage(named: "water_t"), name: "Water T"),
        Friend(image: UIImage(named: "eyehole_man"), name: "Eyehole Man"),
        Friend(image: UIImage(named: "talking_cat"), name: "Talking Cat"),
        Friend(image: UIImage(named: "elon_tusk"), name: "Elon Tusk"),
        Friend(image: UIImage(named: "squanchy"), name: "Squanchy"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            preconditionFailure("FriendCell cannot")
        }
        
        cell.labelFriendCell.text = friends[indexPath.row].name
        cell.imageFriendCell.image = friends[indexPath.row].image

        print(indexPath.section)
        print(indexPath.row)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsSegue",
           let destinationVC = segue.destination as? PhotosViewController,
           let indexPath = tableView.indexPathForSelectedRow
        {
            let friendsNames = friends[indexPath.row].name
            destinationVC.title = friendsNames
        }
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
