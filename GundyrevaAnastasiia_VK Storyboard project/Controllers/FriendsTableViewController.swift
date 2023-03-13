//
//  FriendsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
// добавить: поиск по друзьям

import UIKit
import SDWebImage
import RealmSwift

class FriendsTableViewController: UITableViewController {

    let friends1: [User] = [
        User(id: 01, image: UIImage(named: "krombopulos_michael"), name: "Krombopulos Michael", userPhoto: ["krombopulos_michael", "krom1", "krom2", "krom3", "krom4", "krom5"]),
        User(id: 02, image: UIImage(named: "revolio_clockberg_jr"), name: "Revolio Clockberg Jr.", userPhoto: ["revolio_clockberg_jr", "rev1", "rev2"]),
        User(id: 03, image: UIImage(named: "mr_frundles"), name: "Mr. Frundles", userPhoto: ["mr_frundles"]),
        User(id: 04, image: UIImage(named: "mr_meseeks"), name: "Mr. Meeseeks", userPhoto: ["mr_meseeks"]),
        User(id: 05, image: UIImage(named: "flippy_nips"), name: "King Flippy Nips", userPhoto: ["flippy_nips"]),
        User(id: 06, image: UIImage(named: "lucius_needful"), name: "Lucius Needful", userPhoto: ["lucius_needful"]),
        User(id: 07, image: UIImage(named: "shleemypants"), name: "Shleemypants", userPhoto: ["shleemypants"]),
        User(id: 08, image: UIImage(named: "ants_in_my_eyes_johnson"), name: "Ants in my Eyes Johnson", userPhoto: ["ants_in_my_eyes_johnson"]),
        User(id: 09, image: UIImage(named: "dr_xenon_bloom"), name: "Dr. Xenon Bloom", userPhoto: ["dr_xenon_bloom"]),
        User(id: 10, image: UIImage(named: "unity"), name: "Unity", userPhoto: ["unity"]),
        User(id: 11, image: UIImage(named: "water_t"), name: "Water T", userPhoto: ["water_t", "water1", "water2", "water3"]),
        User(id: 12, image: UIImage(named: "eyehole_man"), name: "Eyehole Man", userPhoto: ["eyehole_man"]),
        User(id: 13, image: UIImage(named: "talking_cat"), name: "Talking Cat", userPhoto: ["talking_cat"]),
        User(id: 14, image: UIImage(named: "elon_tusk"), name: "Elon Tusk", userPhoto: ["elon_tusk"]),
        User(id: 15, image: UIImage(named: "squanchy"), name: "Squanchy", userPhoto: ["squanchy"])
        
    ]
    
    let session = Session.shared
    let service = Service()
    var users: Results<Friend>?
    var users1: Results<Friend>?
    
    let realm = try! Realm()
    var token: NotificationToken?
    
    
    var usersVK = [Friend]()
    var friendsNew = [Friend]()
    var friendsToDelete = [Friend]()
    
    var selectedFriend: Friend?
    var sortedFriends = [Character: [Friend]]()
    
//    var selectedFriend: User?
//    var sortedFriends = [Character: [User]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(UINib(nibName: "FriendXIBCell", bundle: nil), forCellReuseIdentifier: "FriendXIBCell")
//        navigationController?.delegate = self
        
        service.getFriends(token: session.token, completion: {friends in
            let arrayFriends = Array(friends)
            self.usersVK = arrayFriends
            print("users vk updated to realm")
            self.updateFriendsInRealm()

//            self.tableView.reloadData()
//
//            self.sortedFriends = self.sort(friends: self.users)
//
//            self.tableView.reloadData()
//
//            self.saveFriends()
        })
        
        tableView.register(UINib(nibName: "FriendsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "FriendsHeader")
        
        getFriendsFromRealm()
        let arrayFriends = users?.toArray()
        sortedFriends = sort(friends: arrayFriends ?? [Friend]())
        self.tableView.reloadData()

        print(realm.configuration.fileURL)
    }
    
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendsDict = [Character: [Friend]]()
        
        let arrayFriends = users?.toArray()
        
        arrayFriends!.forEach() {friend in
            
            guard let firstChar = friend.lastName.first else {return}
            
            if var thisCharFriends = friendsDict[firstChar] {
                thisCharFriends.append(friend)
                friendsDict[firstChar] = thisCharFriends
            } else {
                friendsDict[firstChar] = [friend]
            }
            
        }
        return friendsDict
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let keySorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keySorted[section]]?.count ?? 0
        return friends
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXIBCell", for: indexPath) as? FriendXIBCell else {
            return UITableViewCell()
        }
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: Friend = friends[indexPath.row]
        
        selectedFriend = friend
        cell.labelFriendCell.text = (selectedFriend?.lastName ?? "") + " " + (selectedFriend?.firstName ?? "")
        if let image = selectedFriend?.photo {
            cell.imageFriendCell.sd_setImage(with: URL(string: image))
        }
//        cell.imageFriendCell.image = selectedFriend?.image
 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsHeader") as? FriendsHeader else {
            preconditionFailure()
        }
        header.friendsHeaderLabel.text = String(sortedFriends.keys.sorted()[section])

        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: Friend = friends[indexPath.row]
        
        selectedFriend = friend
//        performSegue(withIdentifier: "FriendsSegue", sender: self)
//        let photosViewControllerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        let photosViewControllerVC = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
//        
//        photosViewControllerVC.modalTransitionStyle = .partialCurl
//        photosViewControllerVC.modalPresentationStyle = .fullScreen
//        photosViewControllerVC.transitioningDelegate = photosViewControllerVC
//        
//        self.present(photosViewControllerVC, animated: true)
        navigationController?.pushViewController(photosViewControllerVC, animated: true)
        photosViewControllerVC.title = (selectedFriend?.lastName ?? "") + " " + (selectedFriend?.firstName ?? "")
        photosViewControllerVC.friend = selectedFriend
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        if segue.identifier == "FriendsSegue",
//           let destinationVC = segue.destination as? PhotosViewController {
//
//
//            destinationVC.title = selectedFriend?.name
//            destinationVC.friend = selectedFriend
//
//        }
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func saveFriends() {
        let allFriends = realm.objects(Friends.self)
        var friends = Friends()
        
        
        for i in usersVK.indices {
            let oneFriend = Friend()
            oneFriend.id = usersVK[i].id
            oneFriend.firstName = usersVK[i].firstName
            oneFriend.lastName = usersVK[i].lastName
            oneFriend.photo = usersVK[i].photo
            friends.items.append(oneFriend)
            print("\(oneFriend.firstName) \(oneFriend.lastName)")
        }
//        print(friends.items)
        if allFriends.isEmpty {
            
            try! realm.write {
                realm.add(friends)
            }
        }
    }
    
    func getFriendsFromRealm() {
        users = realm.objects(Friend.self)
        token = users!.observe { (changes: RealmCollectionChange) in
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
        
//        if let friends = allFriends.first?.items {
//             self.users = Array(friends)
//             self.tableView.reloadData()
//        }
    }
    
    func updateFriendsInRealm() {
        let allFriends = realm.objects(Friends.self)
        
        if let friendsItems = allFriends.first?.items {
            
            friendsNew = Array(usersVK)
            print("friendsNew initial count  = \(friendsNew.count)")
            
            for newFriend in usersVK {
                for oldFriend in friendsItems {
                    if newFriend.id == oldFriend.id {
                        if let index = friendsNew.firstIndex(where: { $0.id == newFriend.id }) {
                            friendsNew.remove(at: index)
//                            print("newFriend deleted from the array of new friends = \(newFriend.id)")
                        }
                    }
                }
            }
            print("friendsNew final  = \(friendsNew.count)")
            
            friendsToDelete = Array(friendsItems)
            print("friendsToDelete initial count  = \(friendsToDelete.count)")
            
            for oldFriend in friendsToDelete {
                for newFriend in usersVK {
                    if newFriend.id == oldFriend.id {
                        if let index = friendsToDelete.firstIndex(where: { $0.id == newFriend.id }) {
                            friendsToDelete.remove(at: index)
//                            print("friend is true to reality = \(newFriend.id)")
                        }
                    }
                }
            }
            print("friendsToDelete final  = \(friendsToDelete.count)")
            
            if !friendsNew.isEmpty || !friendsToDelete.isEmpty {
                print("Here we shall write in realm")
                
//                try! realm.write {
//                    allFriends.first?.items.append(objectsIn: friendsNew)
//                }
            }
        }
    }

}


extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
