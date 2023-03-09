//
//  Newsfeed Model.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.03.2023.
//

import Foundation

struct NewsfeedResponse {
    var groups: [NewsGroups]
    var items: [NewsItems]
}

struct NewsGroups {
    var id: Int
    var name: String
    var photo: String
    
}

struct NewsItems {
    var attachments: Attachment
    var comments: String
    var date: Int
    var likes: Likes
    var reposts: Reposts
    var text: String
    
    
}

struct Attachment {
    var type: String?
    var object: String?
}

struct Likes {
    var count: Int
    var userLikes: Bool
}

struct Reposts {
    var count: Int
    var userReposted: Bool
}
