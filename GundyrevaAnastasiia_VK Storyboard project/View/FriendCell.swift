//
//  FriendCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 06.12.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var imageFriendCell: UIImageView!
    
    @IBOutlet weak var labelFriendCell: UILabel!
    
    func configure(imageUrl: String) {
        imageFriendCell.sd_setImage(with: URL(string: imageUrl))
    }
    func configure(text: String) {
        labelFriendCell.text = text
    }
}
