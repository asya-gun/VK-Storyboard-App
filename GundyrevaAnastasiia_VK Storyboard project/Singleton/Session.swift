//
//  Session.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 29.01.2023.
//

import Foundation


class Session {
    
    private init (){}
    
    static let session = Session()
    
    var token: String = ""
    var userId: Int = 0
}
