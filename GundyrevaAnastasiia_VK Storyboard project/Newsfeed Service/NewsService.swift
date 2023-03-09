//
//  NewsService.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 08.03.2023.
//

import Foundation
import Alamofire

class NewsService {
    let baseUrl = "https://api.vk.com/method"
    
    func getNews(token: String) {
        let url = baseUrl + "/newsfeed.get"
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post, note",
            "source_ids" : "groups",
            "count" : 3,
            "v" : "5.131"
        ]
        
        let req = AF.request(url, method: .post, parameters: parameters).responseJSON(completionHandler: { result in
                print(result)
        })
        print("url here: \(req)")
    }
    
}
