//
//  GroupsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var groups = [
        Group(image: UIImage(named: "citadel_morning_news"),name: "Citadel Morning News"),
        Group(image: UIImage(named: "ball_fondlers"),name: "Ball-Fondlers Fans"),
        Group(image: UIImage(named: "vindicators"),name: "Vindicators Trivia"),
        Group(image: UIImage(named: "human_music"),name: "Human Music"),
        Group(image: UIImage(named: "meseeks_overhear"),name: "Meseeks Overhear"),
    ]
    
    var selectedGroup: Group?

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
        return groups.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("GroupCell cannot")
        }
        
        cell.labelGroupCell.text = groups[indexPath.row].name
        cell.imageGroupCell.image = groups[indexPath.row].image

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AllGroupsSegue",
           let destinationVC = segue.destination as? AllGroupsController
        {
            destinationVC.title = "All Groups"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroup = groups[indexPath.row]
    }
    
    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AllGroupsController,
           segue.identifier == "addGroup",
           let indexPath = sourceVC.tableView.indexPathForSelectedRow,
           let selectedGroup = sourceVC.selectedGroup {
            
            if !groups.contains(where: {$0.name == selectedGroup.name}) {
                groups.append(selectedGroup)
                
                tableView.reloadData()
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }/* else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    */
    }
    
    

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
