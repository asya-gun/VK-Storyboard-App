//
//  Photo.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.02.2023.
//

import UIKit

struct PhotoResponse: Decodable {
    var response: PhotoItems
}

struct PhotoItems: Decodable {
    var items: [Photo]
}

struct Photo: Decodable {
    var id: Int
    var ownerId: Int
    var sizes: [PhotoSize]
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
    
}

struct PhotoSize: Decodable {
    var height: Int
    var width: Int
    var type: String
    var url: String
    
    enum PhotoKeys: String, CodingKey {
        case height
        case width
        case type
        case url
    }
}
