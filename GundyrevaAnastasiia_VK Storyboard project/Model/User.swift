//
//  Friend.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit
import RealmSwift

class User {
    let id: Int
    let image: UIImage?
    let name: String
    let userPhoto: [String]?
    
    init(id: Int, image: UIImage? = nil, name: String, userPhoto: [String]? = nil) {
        self.id = id
        self.image = image
        self.name = name
        self.userPhoto = userPhoto
    }
}


//struct Response: Decodable {
//    var response: Friends
//}
//
//struct Friends: Decodable {
//    var items: [Friend]
//}
//
//struct Friend: Decodable {
//    var id: Int
//    var firstName: String
//    var lastName: String
////    var lastSeen: String
//    var photo: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
////        case lastSeen = "last_seen"
//        case photo = "photo_100"
//    }
//}

class Response: Decodable {
    var response: Friends
}

class Friends: Decodable {
    var items: [Friend]
}

class Friend: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
//    var lastSeen: String
    @Persisted var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
//        case lastSeen = "last_seen"
        case photo = "photo_100"
    }
}


