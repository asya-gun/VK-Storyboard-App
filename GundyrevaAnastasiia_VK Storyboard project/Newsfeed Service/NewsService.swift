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
    
    func getNewsOld(token: String) {
        let url = baseUrl + "/newsfeed.get"
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post, note",
            "source_ids" : "groups",
            "count" : 3,
            "v" : "5.131"
        ]
        
        AF.request(url, method: .post, parameters: parameters).responseJSON(completionHandler: { result in
            print(result)
        })
    }
    
    func getNews(token: String, completion: @escaping ([NewsItems], [NewsGroups]) -> ()) {
        let url = baseUrl + "/newsfeed.get"
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post, note",
            "source_ids" : "groups",
            "count" : 3,
            "v" : "5.131"
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { result in
            if let data = result.data {
                if let news = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.items, let groups = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.groups {
                    print("news first success \(news.first?.text)")
                    print("groups first success \(groups.first?.name)")
                    completion(news, groups)
                }
            }
        }
        
    }
    
    func getNewsOwners(token: String, completion: @escaping ([NewsGroups]) -> ()) {
        let url = baseUrl + "/newsfeed.get"
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post, note",
            "source_ids" : "groups",
            "count" : 3,
            "v" : "5.131"
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { result in
            if let data = result.data {
                if let groups = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.groups {
                    print("groups first success")
                    print(groups.first?.name)
                }
            }
        }
        
    }
    
}
