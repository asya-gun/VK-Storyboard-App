//
//  UIViewController + extension.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
//

import UIKit

extension UIViewController {
    func show(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
        
    }
}
