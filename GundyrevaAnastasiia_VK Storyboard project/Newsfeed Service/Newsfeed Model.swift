//
//  Newsfeed Model.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.03.2023.
//

import Foundation

struct NewsfeedResponse: Decodable {
    var response: Newsfeed
}

struct Newsfeed: Decodable {
    var groups: [NewsGroups]
    var items: [NewsItems]
}

struct NewsGroups: Decodable {
    var id: Int
    var name: String
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo = "photo_200"
    }
    
}

struct NewsItems: Decodable {
    var attachments: [Attachment]?
    var comments: Comments
//    var date: Int
    var likes: Likes
    var reposts: Reposts
    var text: String?
    
    
}

struct Attachment: Decodable {
    var type: String?
    var photo: NewsPhoto?
}

struct Comments: Decodable {
    var count: Int
}

struct Likes: Decodable {
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

struct Reposts: Decodable {
    var count: Int
    var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct NewsPhoto: Decodable {
    var accessKey: String
//    var date: Int
    var id: Int
    var sizes: [NewsPhotoSizes]
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case id, sizes
    }
}

struct NewsPhotoSizes: Decodable {
    var url: String
}
