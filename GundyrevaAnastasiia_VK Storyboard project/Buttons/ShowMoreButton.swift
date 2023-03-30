//
//  ShowMoreButton.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 30.03.2023.
//

import Foundation
import UIKit

class ShowMoreButton: UIControl {
    private var showLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        return label
    }()
//    private let underlineAttribute = [NSAttributedString.Key.underlineStyle]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        showLabel.frame = bounds
    }
    private func setupView() {
        showLabel = UILabel()
        showLabel.textAlignment = .left
        
        self.addSubview(showLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(updateTextState(_ :)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        
    }
   @objc private func updateTextState(_ tap: UITapGestureRecognizer) {
        isSelected.toggle()
        if isSelected {
//            let attributedText = NSAttributedString(string: "Show less", attributes: underlineAttribute)
            showLabel.text = "Show less"
            showLabel.textColor = .black
        } else {
            showLabel.text = "Show more"
            showLabel.textColor = .systemMint
        }
    }
}
