//
//  SecondViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 02.02.2023.
//

import UIKit

class SecondViewController: UIViewController {

    let session = Session.shared
    let service = Service()
    var photos = [Photo]()
    var friends = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        service.getFriends(token: session.token)
//        service.getPhotos(token: session.token)
//        service.getGroups(token: session.token)
//        service.getFilteredGroups(token: session.token)
        let token = session.token
        print(token)
        service.getPhotos(token: token, completion: {photos in
            let arrayPhotos = Array(photos)
            self.photos = arrayPhotos
            print("\(photos.count) photos")
            print(photos.first)
        })
        print(photos.count)
//        service.getFriends(token: token, completion: { friends in 
//            self.friends = friends
//            print("\(friends.count) friends")
//            print(friends.first)
//        })
        print(friends.count)

    }
    


}
