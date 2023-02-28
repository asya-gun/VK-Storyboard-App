//
//  GroupsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit
import SDWebImage

class GroupsTableViewController: UITableViewController {
    
    private var searchBar = UISearchBar()
    
    @IBOutlet weak var AddButton: UIBarButtonItem!
//    var groups = [
//        Group(image: UIImage(named: "human_music"),name: "Human Music")
//    ]
    
    let session = Session.shared
    let service = Service()
    
    var groups = [Group]()
    var selectedGroup: Group?
    var sortedGroups = [Character: [Group]]()
    var filteredGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        self.searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        service.getGroups(token: session.token, completion: {groups in
            self.groups = groups
            
            self.sortedGroups = self.sort(groups: groups)
            self.filterGroups()
            
            self.tableView.reloadData()
        })
        
        tableView.register(UINib(nibName: "GroupsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "GroupsHeader")
    
    }
    
    private func sort(groups: [Group]) -> [Character: [Group]] {
        var groupDict = [Character: [Group]]()
        
        groups.forEach() {group in
            guard let firstChar = group.name.first else {return}
            
            if var thisCharGroups = groupDict[firstChar] {
                thisCharGroups.append(group)
                groupDict[firstChar] = thisCharGroups
            } else {
                groupDict[firstChar] = [group]
            }
        }
        return groupDict
    }
    
    private func filterGroups() {
        let searchText = (searchBar.text ?? "").lowercased()
        if searchText == "" || searchText == " " || searchText.isEmpty {
            filteredGroups = groups
        } else {
        
            for group in groups {
                filteredGroups = groups.filter { (group) -> Bool in
                    group.name.lowercased().contains(searchText)
                }
            }
        }
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortedGroups.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedGroups.keys.sorted()
        let groups = sortedGroups[keysSorted[section]]?.count ?? 0
        return groups
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("GroupCell cannot")
        }
        
        let firstChar = sortedGroups.keys.sorted()[indexPath.section]
        let groups = sortedGroups[firstChar]!
        
        let group: Group = groups[indexPath.row]
        
        selectedGroup = group
        
        cell.labelGroupCell.text = selectedGroup?.name
        if let image = selectedGroup?.photo {
            cell.imageGroupCell.sd_setImage(with: URL(string: image))
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "GroupsHeader") as? GroupsHeader else {
            preconditionFailure()
        }
        header.groupNameLabel.text = String(sortedGroups.keys.sorted()[section])

        return header
    }
    
    @IBAction func tapAddButton(_ sender: Any?) {
        let allGroupsVC = storyboard?.instantiateViewController(withIdentifier: "AllGroupsController") as! AllGroupsController
        navigationController?.pushViewController(allGroupsVC, animated: true)
        allGroupsVC.title = "All Groups"
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
        let firstChar = sortedGroups.keys.sorted()[indexPath.section]
        let groups = sortedGroups[firstChar]!
        
        let group: Group = groups[indexPath.row]
        
        selectedGroup = group
    }
    
//    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
//        let allGroupsControllerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllGroupsController") as! AllGroupsController
//        
//        allGroupsControllerVC.transitioningDelegate = allGroupsControllerVC as! any UIViewControllerTransitioningDelegate 
//        self.present(allGroupsControllerVC, animated: true)
//    }
    
    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AllGroupsController,
           segue.identifier == "addGroup",
           let selectedGroup = sourceVC.selectedGroup {
            print("heyy")
            if !groups.contains(where: {$0.name == selectedGroup.name}) {
                groups.append(selectedGroup)
                sortedGroups = sort(groups: groups)
                
                tableView.reloadData()
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       // UNRESOLVED BUG: if my groups are searched and then deleted, throws invalid number of rows exception

            let initialSectionsCount = sortedGroups.keys.count
            
            let firstChar = sortedGroups.keys.sorted()[indexPath.section]
   //         let groupsSorted = sortedGroups[firstChar]!
            let group: Group = groups[indexPath.row]
            
            groups.removeAll { $0.name == group.name }
            let searchText = (searchBar.text ?? "").lowercased()
            if searchText == "" || searchText == " " || searchText.isEmpty {
                filteredGroups = groups
            } else {
            
                for group in groups {
                    filteredGroups = groups.filter { (group) -> Bool in
                        group.name.lowercased().contains(searchText)
                        
                    }
                }
            }
            
            sortedGroups = sort(groups: filteredGroups)
            
            if initialSectionsCount - sortedGroups.keys.count == 0 {
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                tableView.deleteSections(IndexSet([indexPath.section]), with: .fade)
            }
        }
    }
    

}
extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredGroups.removeAll()
        filterGroups()
        
        sortedGroups = sort(groups: filteredGroups)
        tableView.reloadData()
    }
}
