//
//  FriendsTableViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
//

import UIKit
import SDWebImage

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
        User(id: 15, image: UIImage(named: "squanchy"), name: "Squanchy", userPhoto: ["squanchy"]),
        
    ]
    
    let session = Session.shared
    let service = Service()
    var users = [Friend]()
    
    var selectedFriend: Friend?
    var sortedFriends = [Character: [Friend]]()
    
//    var selectedFriend: User?
//    var sortedFriends = [Character: [User]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(UINib(nibName: "FriendXIBCell", bundle: nil), forCellReuseIdentifier: "FriendXIBCell")
//        navigationController?.delegate = self
        
        service.getFriends(token: session.token, completion: {friends in
            self.users = friends
            
            self.tableView.reloadData()
            
            self.sortedFriends = self.sort(friends: friends)
            
            self.tableView.reloadData()
        })
        
        tableView.register(UINib(nibName: "FriendsHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "FriendsHeader")

        
    }
    
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendsDict = [Character: [Friend]]()
        
        users.forEach() {friend in
            
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
//        photosViewControllerVC.friend = selectedFriend
        
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

}

