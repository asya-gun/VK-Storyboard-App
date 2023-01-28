//
//  GroupsHeader.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 13.01.2023.
//

import UIKit

class GroupsHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var groupNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = GradientView()
        
        view.startColor = .magenta
        view.endColor = .systemGray6
        view.startPoint = .zero
        view.endPoint = .init(x: 1, y: 0)
        backgroundView = view
        
        backgroundView?.layer.opacity = 0.4
        
        groupNameLabel.textColor = .black
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
}
