//
//  Group.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class Group1 {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}

struct GroupResponse: Decodable {
    var response: GroupItems
    
}

struct GroupItems: Decodable {
    
    var items: [Group]
    
}

struct Group: Decodable {
    var id: Int
    var name: String
    var photo: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case photo = "photo_100"
        case description
    }
    
//    enum MainKeys: String, CodingKey {
//        case sampleMain
//    }
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try values.decode(String.self, forKey: .name)
//
//
//        //down the hierarchy
//        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
//        self.sample = try mainValues.decode(String.self, forKey: .sampleMain)
        
        //массив данных
//        var weatherValues = try values.nestedUnkeyedContainer(forKey: .weather)
//        let firstValue = try weatherValues.nestedContainer(keyedBy: WeatherKeyes.self)
//        self.weatherName = try firstValue.decode(String.self, forKey: .main)
//    }
}
