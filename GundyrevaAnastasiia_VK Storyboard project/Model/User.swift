//
//  Friend.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class User {
    let id: Int
    let image: UIImage?
    let name: String
    let userPhoto: [String]
    
    init(id: Int, image: UIImage? = nil, name: String, userPhoto: [String]) {
        self.id = id
        self.image = image
        self.name = name
        self.userPhoto = userPhoto
    }
}
