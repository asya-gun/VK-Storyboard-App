//
//  SessionViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 30.01.2023.
//

import UIKit

class SessionViewController: UIViewController {
    
    let url = URL(string: "http://google.com")
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlCons = URLComponents()
        urlCons.scheme = "http"
        urlCons.host = "sample.org"
        urlCons.path = "/sample/samples"
        
        urlCons.queryItems = [
        URLQueryItem(name: "q", value: "Munchen,de"),
        URLQueryItem(name: "appid", value: "b1b8e88f")
        ]
        let config = URLSessionConfiguration.default
        var request = URLRequest(url: urlCons.url!)
        request.httpMethod = "POST"
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { data, res, err in
            if let err = err {
                print(err.localizedDescription)
                
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(json)
            }
            
        })
        
        task.resume()

    }
    

  
}

//extension SessionViewController: WKNavigationDelegate {
//    
//}
