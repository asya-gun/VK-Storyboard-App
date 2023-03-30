//
//  NewsService.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 08.03.2023.
//поставить запросы на глобальную очередь

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
    
    func getNews(token: String, completion: @escaping ([NewsItems], [NewsGroups], String) -> ()) {
        let url = baseUrl + "/newsfeed.get"
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post, note",
            "source_ids" : "groups",
            "count" : 10,
            "v" : "5.131"
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { result in
            if let data = result.data {
                if let news = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.items,
                    let groups = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.groups,
                    let str = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.nextFrom
                {
                    print("news first success \(news.first?.text)")
                    print("groups first success \(groups.first?.name)")
                    print(("nextFrom \(str)"))
                    completion(news, groups, str)
                }
            }
        }
    }
        
    func getNews(token: String, startTime: Date, completion: @escaping ([NewsItems], [NewsGroups]) -> ()) {
            let url = baseUrl + "/newsfeed.get"
        let date = startTime.timeIntervalSince1970
            let parameters: Parameters = [
                "access_token" : token,
                "filters" : "post, note",
                "source_ids" : "groups",
                "start_time" : date,
                "count" : 10,
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
    
    func getNews(token: String, nextFrom: String, completion: @escaping ([NewsItems], [NewsGroups], String) -> ()) {
            let url = baseUrl + "/newsfeed.get"
            let parameters: Parameters = [
                "access_token" : token,
                "filters" : "post, note",
                "source_ids" : "groups",
                "start_from" : nextFrom,
                "count" : 10,
                "v" : "5.131"
            ]

            AF.request(url, method: .post, parameters: parameters).response { result in
                if let data = result.data {
                    if let news = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.items,
                        let groups = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.groups,
                       let str = try? JSONDecoder().decode(NewsfeedResponse.self, from: data).response.nextFrom {
                        print("news first success \(news.first?.text)")
                        print("groups first success \(groups.first?.name)")
                        print("next from \(str)")
                        completion(news, groups, str)
                    }
                }
            }

    }

    
    
}
