//
//  Session.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 29.01.2023.
//

import Foundation


class Session {

    private init (){}

    static let shared = Session()
// 3. Сохранить токен в синглтоне Session
    var token: String = ""
//    "vk1.a.6nAZQyPma4fTt2hrXjVOFssbCzVf0tjLmvkUgSOyMGs0wXuybRwgeB3IG_oAjtHZwOsNyTqVkG4FbxY0YACl5_uRCbvE7xDyQ71FiR5TRJTwdt16xnQsyTnULd0APIxUogsyyitvn3aTQSVl-MvaSXN2-WO4bU-ZNXEugjY31HAepIms3HoqrNNx0pJakZyU"
    var userId: Int = 0
}


