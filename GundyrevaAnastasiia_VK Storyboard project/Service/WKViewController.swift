//
//  WKViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 01.02.2023.
//

import UIKit
import Alamofire
import WebKit

//1. Зарегистрировать приложение в ВК;
//2. Заменить форму входа на WKWebView для авторизации в ВК

class WKViewController: UIViewController {
    
    let session = Session.shared
    var secondVC: SecondViewController?
    var friendsTestTVC: FriendsTestViewController?
    var loadingVC: LoadingViewController?
    
    @IBOutlet weak var webView: WKWebView!
    
//    let key = ""
//    let baseUrl = ""
//    let path = ""
    let appId = "51541045"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
        URLQueryItem(name: "client_id", value: appId),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "scope", value: "friends, wall"),
        URLQueryItem(name: "response_type", value: "token")
        ]
        let url = urlComponent.url
        if UIApplication.shared.canOpenURL(url!) {
            
            let request = URLRequest(url: url!)
            webView.load(request)
        }

//        let parameters = [
//            "":""
//        ]
//        let url = baseUrl + path
//
//        AF.request(url, method: .get, parameters: parameters).responseDecodable(completionHandler: { res in
//            print(res)
//        })
    }
    



}

extension WKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map({$0.components(separatedBy: "=")})
            .reduce([String: String](), {res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })
        
        if let token = params["access_token"] {
            self.session.token = token
            
//            friendsTestTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendsTestTVC") as? FriendsTestViewController
//            secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController
            loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingScreen") as? LoadingViewController
            
            self.view.insertSubview((loadingVC?.view)!, at: 9)
        }
        decisionHandler(.cancel)
    }
    
}
