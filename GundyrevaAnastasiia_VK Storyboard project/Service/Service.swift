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
    
    func getFriends(token: String) {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "fields" : "bdate, last_seen"
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {response in
            print(response)
        })
        
        
//            .responseData(completionHandler: {response in
//            guard let data = response.data else { return }
//            print(response)
//        })
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
