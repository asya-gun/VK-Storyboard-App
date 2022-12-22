//
//  FriendsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    let friends: [User] = [
        User(id: 01, image: UIImage(named: "krombopulos_michael"), name: "Krombopulos Michael", userPhoto: ["krombopulos_michael"]),
        User(id: 02, image: UIImage(named: "revolio_clockberg_jr"), name: "Revolio Clockberg Jr.", userPhoto: ["revolio_clockberg_jr"]),
        User(id: 03, image: UIImage(named: "mr_frundles"), name: "Mr. Frundles", userPhoto: ["mr_frundles"]),
        User(id: 04, image: UIImage(named: "mr_meseeks"), name: "Mr. Meeseeks", userPhoto: ["mr_meseeks"]),
        User(id: 05, image: UIImage(named: "flippy_nips"), name: "King Flippy Nips", userPhoto: ["flippy_nips"]),
        User(id: 06, image: UIImage(named: "lucius_needful"), name: "Lucius Needful", userPhoto: ["lucius_needful"]),
        User(id: 07, image: UIImage(named: "shleemypants"), name: "Shleemypants", userPhoto: ["shleemypants"]),
        User(id: 08, image: UIImage(named: "ants_in_my_eyes_johnson"), name: "Ants in my Eyes Johnson", userPhoto: ["ants_in_my_eyes_johnson"]),
        User(id: 09, image: UIImage(named: "dr_xenon_bloom"), name: "Dr. Xenon Bloom", userPhoto: ["dr_xenon_bloom"]),
        User(id: 10, image: UIImage(named: "unity"), name: "Unity", userPhoto: ["unity"]),
        User(id: 11, image: UIImage(named: "water_t"), name: "Water T", userPhoto: ["water_t"]),
        User(id: 12, image: UIImage(named: "eyehole_man"), name: "Eyehole Man", userPhoto: ["eyehole_man"]),
        User(id: 13, image: UIImage(named: "talking_cat"), name: "Talking Cat", userPhoto: ["talking_cat"]),
        User(id: 14, image: UIImage(named: "elon_tusk"), name: "Elon Tusk", userPhoto: ["elon_tusk"]),
        User(id: 15, image: UIImage(named: "squanchy"), name: "Squanchy", userPhoto: ["squanchy"]),
        
    ]
    
    var selectedFriend: User?
    
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
            return UITableViewCell()
        }
        
        selectedFriend = friends[indexPath.row]
        cell.labelFriendCell.text = selectedFriend?.name
        cell.imageFriendCell.image = selectedFriend?.image
 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: "FriendsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "FriendsSegue",
           let destinationVC = segue.destination as? PhotosViewController {
            destinationVC.title = selectedFriend?.name
            destinationVC.friend = selectedFriend
         
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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

 

}
