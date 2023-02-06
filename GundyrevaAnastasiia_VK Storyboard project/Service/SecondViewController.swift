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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getFriends(token: session.token)
//        service.getPhotos(token: session.token)
//        service.getGroups(token: session.token)
//        service.getFilteredGroups(token: session.token)
        let token = session.token
        print(token)

    }
    


}
