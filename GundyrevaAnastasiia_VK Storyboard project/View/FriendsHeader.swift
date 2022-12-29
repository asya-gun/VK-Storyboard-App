//
//  FriendsHeader.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 29.12.2022.
//

import UIKit

class FriendsHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var friendsHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = GradientView()
        
        view.startColor = .systemMint
        view.endColor = .systemGray6
        view.startPoint = .zero
        view.endPoint = .init(x: 1, y: 0)
        backgroundView = view
        
        backgroundView?.layer.opacity = 0.4
        
        friendsHeaderLabel.textColor = .black
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}
