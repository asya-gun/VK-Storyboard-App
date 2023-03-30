//
//  PostTextCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 01.03.2023.
//

import UIKit

class PostTextCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
//    private var showButton: ShowMoreButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        postText.addSubview(showButton)
//        contentView.addSubview(showButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let buttonWidth: CGFloat = 100
//        let buttonHeight = postText.frame.size.height/4
//        showButton.frame = CGRect(x: postText.frame.size.width - buttonWidth,
//                                  y: postText.frame.size.height - buttonHeight,
//                                  width: buttonWidth,
//                                  height: buttonHeight)
//
//
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(text: String) {
        postText.text = text
    }

}
