//
//  TableViewCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 01.03.2023.
//

import UIKit
import SDWebImage

class PosterCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var posterLastSeenLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(imageUrl: String) {
        posterImage.sd_setImage(with: URL(string: imageUrl))
    }
    func configure(image: UIImage) {
        posterImage.image = image
    }
    func configure(name: String) {
        posterName.text = name
    }
    func configure(lastSeenText: String) {
        posterLastSeenLabel.text = lastSeenText
    }

}
