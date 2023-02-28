//
//  Photo.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.02.2023.
//

import UIKit
import RealmSwift

class PhotoResponse: Decodable {
    var response: PhotoItems
}

class PhotoItems: Decodable {
    var items: [Photo]
}

class Photo: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var ownerId: Int = 0
//    var date: String
    @Persisted var sizes = List<Sizes>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
//        case date
        case sizes
    }
   
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        self.sizes = try values.decode(List<Sizes>.self, forKey: .sizes)
    }
    
}

class Sizes: Object, Decodable {
    @Persisted var height: Int = 0
    @Persisted var width: Int = 0
    @Persisted var type: String = ""
    @Persisted var url: String = ""
    
    enum SizesKeys: String, CodingKey {
        case height
        case width
        case type
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: SizesKeys.self)
        self.height = try values.decode(Int.self, forKey: .height)
        self.width = try values.decode(Int.self, forKey: .width)
        self.type = try values.decode(String.self, forKey: .type)
        self.url = try values.decode(String.self, forKey: .url)
        
    }
}



//struct PhotoResponse: Decodable {
//    var response: PhotoItems
//}
//
//struct PhotoItems: Decodable {
//    var items: [Photo]
//}
//
//struct Photo:  Decodable {
//    var id: Int = 0
//    var ownerId: Int = 0
//    //    var date: String
//        var sizes: [Sizes]
//    var height: Int = 0
//    var width: Int = 0
//    var type: String = ""
//    var url: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerId = "owner_id"
//        //        case date
//        case sizes
//    }
//
//}
//    enum SizesKeys: String, CodingKey {
//        case height
//        case width
//        case type
//        case url
//    }
//
//    struct Sizes: Decodable {
//        var height: Int
//        var width: Int
//        var type: String
//        var url: String
//
//    }
