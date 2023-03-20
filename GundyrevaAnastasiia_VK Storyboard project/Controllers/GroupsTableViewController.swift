//
//  GroupsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//
// исправить: удаление групп

import UIKit
import SDWebImage
import RealmSwift
import Alamofire

class GroupsTableViewController: UITableViewController {
    
    private var searchBar = UISearchBar()
    
    @IBOutlet weak var AddButton: UIBarButtonItem!
//    var groups = [
//        Group(image: UIImage(named: "human_music"),name: "Human Music")
//    ]
    
    let session = Session.shared
    let service = Service()
    let realm = try! Realm()
    
    var groups: Results<Group>?
    var token: NotificationToken?
    var groupsArray = [Group]()
    
    var groupsVK = [Group]()
    var groupsNew = [Group]()
    var groupsToDelete = [Group]()
    
    var selectedGroup: Group?
    var sortedGroups = [Character: [Group]]()
    var filteredGroups = [Group]()
    
    let opq = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        self.searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "access_token" : session.token,
            "v" : "5.131",
            "count" : 40,
            "filter" : "groups",
            "extended" : 1,
            "fields" : "description"
        ]
        
        let request = AF.request(url, method: .get, parameters: parameters)
        let getDataOp = GetGroupsOperation(request: request)
        getDataOp.completionBlock = {
            print("Here's op.data \(getDataOp.data)")
        }
        let parseGroupsOp = ParseGroupsOperation()
        parseGroupsOp.completionBlock = {
            print("Here's outputData \(parseGroupsOp.outputData)")
            self.groupsVK = parseGroupsOp.outputData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        let saveGroupsToRealmOp = SaveGroupsToRealmOperation(realm: realm, groups: groupsVK)
        parseGroupsOp.addDependency(getDataOp)
        saveGroupsToRealmOp.addDependency(parseGroupsOp)
        opq.addOperation(getDataOp)
        opq.addOperation(parseGroupsOp)
        opq.addOperation(saveGroupsToRealmOp)
//        OperationQueue.main.addOperation(parseGroups)
        
//        service.getGroups(token: session.token, completion: {groups in
//            let arrayGroups = Array(groups)
//            self.groupsVK = arrayGroups
//
//            self.updateGroupsInRealm()
//
////            self.sortedGroups = self.sort(groups: self.groups)
////            self.filterGroups()
//
////            self.saveGroups()
//
//            self.tableView.reloadData()
//        })
        
        tableView.register(UINib(nibName: "GroupsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "GroupsHeader")
        
        getGroupsFromRealm()
        groupsArray = groups?.toArray() ?? [Group]()
        sortedGroups = sort(groups: groupsArray)
        filterGroups()
        self.tableView.reloadData()
        
    
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
            filteredGroups = groupsArray
        } else {
        
            for group in groupsArray {
                filteredGroups = groupsArray.filter { (group) -> Bool in
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
            if !groupsArray.contains(where: {$0.name == selectedGroup.name}) {
                groupsArray.append(selectedGroup)
                sortedGroups = sort(groups: groupsArray)
                
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
            let group: Group = groupsArray[indexPath.row]
            
            groupsArray.removeAll { $0.name == group.name }
            let searchText = (searchBar.text ?? "").lowercased()
            if searchText == "" || searchText == " " || searchText.isEmpty {
                filteredGroups = groupsArray
            } else {
            
                for group in groupsArray {
                    filteredGroups = groupsArray.filter { (group) -> Bool in
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
    
    func saveGroups() {
        let allGroups = realm.objects(GroupItems.self)
        var groupItems = GroupItems()
        
        for i in groupsVK.indices {
            let oneGroup = Group()
            oneGroup.id = groupsVK[i].id
            oneGroup.name = groupsVK[i].name
            oneGroup.photo = groupsVK[i].photo
            oneGroup.groupDescription = groupsVK[i].groupDescription
            groupItems.items.append(oneGroup)
//            print(oneGroup.name)
        }
//        print(groupItems.items)
        
        if allGroups.isEmpty {
            try! realm.write {
                realm.add(groupItems)
            }
        }
    }
    
    func getGroupsFromRealm() {
        groups = realm.objects(Group.self)
        token = groups!.observe{ (changes: RealmCollectionChange) in
            switch changes {
                
            case .initial(_):
                print("initialized successfully")
                self.tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                self.tableView.beginUpdates()
                
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                
                self.tableView.endUpdates()
                
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateGroupsInRealm() {
        let allGroups = realm.objects(GroupItems.self)
        
        if let groupItems = allGroups.first?.items {
            
            groupsNew = Array(groupsVK)
            print("groupsNew initial count  = \(groupsNew.count)")
            
            for newGroup in groupsVK {
                for oldGroup in groupItems {
                    if newGroup.id == oldGroup.id {
                        if let index = groupsNew.firstIndex(where: { $0.id == newGroup.id }) {
                            groupsNew.remove(at: index)
//                            print("newGroup deleted from the array of new groups = \(newGroup.id)")
                        }
                    }
                }
            }
            print("groupsNew final  = \(groupsNew.count)")
            
            groupsToDelete = Array(groupItems)
            print("groupsToDelete initial count  = \(groupsToDelete.count)")
            
            for oldGroup in groupsToDelete {
                for newGroup in groupsVK {
                    if newGroup.id == oldGroup.id {
                        if let index = groupsToDelete.firstIndex(where: { $0.id == newGroup.id }) {
                            groupsToDelete.remove(at: index)
//                            print("group is true to reality = \(newGroup.id)")
                        }
                    }
                }
            }
            print("groupsToDelete final  = \(groupsToDelete.count)")
            
            if !groupsNew.isEmpty || !groupsToDelete.isEmpty {
                print("Here we shall write in realm")
                
//                try! realm.write {
//                    allGroups.first?.items.append(objectsIn: groupsNew)
//                }
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
