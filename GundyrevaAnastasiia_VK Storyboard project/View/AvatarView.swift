//
//  AvatarView.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 22.12.2022.
//

import UIKit

//@IBDesignable
class AvatarView: UIImageView {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }
    
}
