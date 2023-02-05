//
//  Group.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class Group {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}

class GroupClient: Decodable {
    var name: String = ""
    var sample = ""
    var main = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sample
        case main
    }
    
    enum MainKeys: String, CodingKey {
        case sampleMain
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        
        
        //down the hierarchy
        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        self.sample = try mainValues.decode(String.self, forKey: .sampleMain)
        
        //массив данных
//        var weatherValues = try values.nestedUnkeyedContainer(forKey: .weather)
//        let firstValue = try weatherValues.nestedContainer(keyedBy: WeatherKeyes.self)
//        self.weatherName = try firstValue.decode(String.self, forKey: .main)
    }
}
