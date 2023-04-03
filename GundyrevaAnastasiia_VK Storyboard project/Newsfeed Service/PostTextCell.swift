//
//  PostTextCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 01.03.2023.
//

import UIKit

protocol PostTextCellDelegate: AnyObject {
    func didTapButton(section: Int)
}

class PostTextCell: UITableViewCell {
    
    weak var delegate: PostTextCellDelegate?
    private var title: String = ""
    private var section: Int = 0

    @IBOutlet weak var postText: UILabel!
//    private var showButton: ShowMoreButton!
    var tapShow: ((PostTextCell) -> ())?
    
    @IBOutlet weak var showButton: UIButton!
    
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
    


    @IBAction func didTapButton() {
        delegate?.didTapButton(section: section)
        //        tapShow?(self)
                isSelected.toggle()
                if isSelected {
                    self.postText.lineBreakMode = .byWordWrapping
                    self.postText.numberOfLines = 0
                    print("button tapped, full text should be shown")
                } else {
                    self.postText.lineBreakMode = .byTruncatingTail
                    self.postText.numberOfLines = 4
                    print("button not tapped, full text concealed")
                }
    }
    
    func configureButton(title: String) {
        self.title = title
        showButton.setTitle(title, for: .normal)
    }
    func configureButton(section: Int) {
        self.section = section
        showButton.tag = section
    }
    
    func setCellSection(sectionNumber: Int) {
//        self.section = sectionNumber
//        showButton.tag = section
    }
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
