//
//  PostButtonsCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 01.03.2023.
//

import UIKit

class PostButtonsCell: UITableViewCell {
    
    
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var shareButton: ShareButton!
    @IBOutlet weak var commentButton: CommentButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
