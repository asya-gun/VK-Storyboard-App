//
//  AllGroupsController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    private var groupSearchBar = UISearchBar()
    
//    let groups = [
//        Group(image: UIImage(named: "citadel_morning_news"),name: "Citadel Morning News"),
//        Group(image: UIImage(named: "ball_fondlers"),name: "Ball-Fondlers Fans"),
//        Group(image: UIImage(named: "vindicators"),name: "Vindicators Trivia"),
//        Group(image: UIImage(named: "meseeks_overhear"),name: "Meseeks Overhear"),
//        Group(image: UIImage(named: "good_morty"), name: "The Good Morty"),
//        Group(image: UIImage(named: "beta_seven"), name: "Beta-Seven"),
//        Group(image: UIImage(named: "anatomy_park"), name: "Anatomy Park Exclusive"),
//        Group(image: UIImage(named: "show_me_what_you_got"), name: "Show Me What You Got"),
//        Group(image: UIImage(named: "heist_con"), name: "Heist-Con"),
//    ]
    
    var groups = [Group]()
    
    var filteredGroups = [Group]()
    var selectedGroup: Group?

    override func viewDidLoad() {
        super.viewDidLoad()
        groupSearchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        self.groupSearchBar.delegate = self
        tableView.tableHeaderView = groupSearchBar
        filterGroups()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as? AllGroupsCell else {
            preconditionFailure("AllGroupCell cannot")
        }
        let group = filteredGroups[indexPath.row]
        cell.labelAllGroupsCell.text = group.name
//        cell.imageAllGroupsCell.image = group.image

        return cell
    }
    
    private func filterGroups() {
        let searchText = (groupSearchBar.text ?? "").lowercased()
        if searchText == "" || searchText == " " || searchText.isEmpty {
            filteredGroups = groups
        } else {
        
            for group in groups {
                filteredGroups = groups.filter { (group) -> Bool in
                    group.name.lowercased().contains(searchText)
                }
            }
        }
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroup = filteredGroups[indexPath.row]
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}

extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredGroups.removeAll()
        filterGroups()
       
    }
}
