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
    var date: Date
    var likes: Likes
    var reposts: Reposts
    var text: String?
    
    enum CodingKeys: CodingKey {
        case attachments
        case comments
        case date
        case likes
        case reposts
        case text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attachments = try container.decodeIfPresent([Attachment].self, forKey: .attachments)
        self.comments = try container.decode(Comments.self, forKey: .comments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dat = try container.decode(Int.self, forKey: .date)
        self.date = formatter.date(from: String(dat)) ?? Date()
        
        self.likes = try container.decode(Likes.self, forKey: .likes)
        self.reposts = try container.decode(Reposts.self, forKey: .reposts)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
    }
    
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
