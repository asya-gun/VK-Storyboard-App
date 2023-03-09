//
//  Newsfeed Model.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.03.2023.
//

import Foundation

struct NewsfeedResponse: Decodable {
    var groups: [NewsGroups]
    var items: [NewsItems]
}

struct NewsGroups: Decodable {
    var id: Int
    var name: String
    var photo: String
    
}

struct NewsItems: Decodable {
    var attachments: Attachment
    var comments: String
    var date: Int
    var likes: Likes
    var reposts: Reposts
    var text: String
    
    
}

struct Attachment: Decodable {
    var type: String?
    var object: String?
}

struct Likes: Decodable {
    var count: Int
    var userLikes: Bool
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

struct Reposts: Decodable {
    var count: Int
    var userReposted: Bool
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}
