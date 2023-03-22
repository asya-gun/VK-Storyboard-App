//
//  Service.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 02.02.2023.
//

import Foundation
import Alamofire
import RealmSwift
import PromiseKit

class Service {
    //https://api.vk.com/method/<METHOD>?<PARAMS> HTTP/1.1
    //v=5.131
    let baseUrl = "https://api.vk.com/method"
    
    func getFriends(token: String, completion: @escaping (List<Friend>) -> ()) {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
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
    
    func getPhotos(token: String, completion: @escaping (List<Photo>) -> ()) {
        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "album_id" : "profile"
        ]
        
        AF.request(url, method: .get, parameters: parameters).response(completionHandler: {result in
            if let data = result.data {
                if let photos = try? JSONDecoder().decode(PhotoResponse.self, from: data).response.items {
                    completion(photos)
                }
            }
        })
        
//        AF.request(url, method: .get, parameters: parameters).response { result in
//            if let data = result.data {
//                if let photos = try? JSONDecoder().decode(PhotoResponse.self, from: data).response.items {
//                    completion(photos)
//                }
//            }
//        }
    }
    func getPhotosOf(token: String, ownerId: Int, completion: @escaping (List<Photo>) -> ()) {
        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
//            "count" : 40,
            "owner_id" : ownerId,
            "album_id" : "profile"
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { result in
            if let data = result.data {
                if let photos = try? JSONDecoder().decode(PhotoResponse.self, from: data).response.items {
                    completion(photos)
                }
            }
        }
    }
    
    func getGroups(token: String, completion: @escaping (List<Group>) -> ()) {
        let url = baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "count" : 40,
            "filter" : "groups",
            "extended" : 1,
            "fields" : "description"
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { result in
            if let data = result.data {
                if let groups = try? JSONDecoder().decode(GroupResponse.self, from: data).response.items {
                    completion(groups)
                }
            }
        }
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
    
    func getWeatherData() {
        let url = "https://api.openweathermap.org/data/2.5/forecast"
        let parameters: Parameters = [
            "lat" : "33.44",
            "lon" : "-94.04",
            "appid" : "3bac95acee0100fbb9484fd5aa0e90d3"
        ]
        AF.request(url, parameters: parameters).responseJSON(completionHandler: {response in
            if let data = response.data {
                let json = try! JSONDecoder().decode(WeatherResponse.self, from: data)
                
                print(json.list.first?.date)
                print(json.list.first?.feelsLike)
            }
        })
    }
    
    func saveToRealm(friends: [Friend]) {
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(friends)
        })
    }
    
    func readRealm() {
        let realm = try! Realm()
        
        let friends = realm.objects(Friend.self)
        print(friends)
    }
    
    
    func getFriendsData(token: String) -> Promise<Data> {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token" : token,
            "v" : "5.131",
            "fields" : "last_seen, photo_100"
        ]
        return Promise { resolver in
        AF.request(url, method: .post, parameters: parameters).response { result in
            guard let data = result.data else {
                resolver.reject(AppError.badRequest as! Error)
                return
            }
            
            resolver.fulfill(data)
        }
        }
    }
    
    func getFriendsDataParsed(_ data: Data) -> Promise<List<Friend>> {
        
        return Promise { resolver in
            do {
                let response = try JSONDecoder().decode(Response.self, from: data).response.items
                resolver.fulfill(response)
            } catch let error {
                    resolver.reject(error)
                }
        }
    }
    
    func getFriends(friends: List<Friend>) -> Promise<[Friend]> {
        return Promise { resolver in
            let arrayFriends = Array(friends)
            resolver.fulfill(arrayFriends)
        }
    }
    
}



