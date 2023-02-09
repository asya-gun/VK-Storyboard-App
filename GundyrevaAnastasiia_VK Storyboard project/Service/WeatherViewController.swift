//
//  WeatherViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 08.02.2023.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    
    let service = Service()
    
    let session = Session.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getWeatherData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
