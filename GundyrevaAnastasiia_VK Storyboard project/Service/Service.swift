//
//  Service.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 02.02.2023.
//

import Foundation
import Alamofire

class Service {
    //https://api.vk.com/method/<METHOD>?<PARAMS> HTTP/1.1
    //v=5.131
    let baseUrl = "https://api.vk.com/method"
    
    func getFriends(token: String, completion: @escaping ([Friend]) -> ()) {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "fields" : "last_seen, photo_100"
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { result in
            if let data = result.data {
                if let friends = try? JSONDecoder().decode(Response.self, from: data).response.items {
//                    print(friends.first?.firstName)
                    completion(friends)
                    
                }
            }
        }
        

    }
    
    func getPhotos(token: String) {
        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "album_id" : "profile",
            "extended" : 1
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {response in
            print(response)
        })
    }
    
    func getGroups(token: String) {
        let url = baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "filter" : "groups"
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {response in
            print(response)
        })
    }
    
    func getFilteredGroups(token: String) {
        let url = baseUrl + "/groups.search"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "type" : "group",
            "q" : "morty"
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {response in
            print(response)
        })
    }
}
