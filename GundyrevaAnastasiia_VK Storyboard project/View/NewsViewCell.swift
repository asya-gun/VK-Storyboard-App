//
//  NewsViewCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 28.12.2022.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet var newsTextLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userOnlineLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.layer.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
