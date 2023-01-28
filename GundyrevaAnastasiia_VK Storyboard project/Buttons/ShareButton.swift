//
//  ShareButton.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 29.12.2022.
//

import UIKit

class ShareButton: UIControl {

    @IBOutlet var shareImage: UIImageView! {
        didSet {
            shareImage.image = UIImage(systemName: "arrowshape.turn.up.right")
            shareImage.tintColor = .black
        }
    }

    private var shareLabel: UILabel!
    private var shareNumber: Int = 0
    private var stackView: UIStackView!

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
        stackView.frame = bounds
    }

    private func setupView() {
        shareImage = UIImageView()
        shareImage.contentMode = .scaleAspectFit

        shareLabel = UILabel()
        shareLabel.textAlignment = .left
        stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [shareLabel])

        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        layer.cornerRadius = bounds.width/4

        let tap = UITapGestureRecognizer(target: self, action: #selector(updateShareState(_ :)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        updateShareNumber()

    }

    private func updateShareNumber() {
        if isSelected {
            shareLabel.text = "\(shareNumber + 1)"
            shareLabel.textColor = .systemBlue
        } else {
            shareLabel.text = "\(shareNumber)"
            shareLabel.textColor = .black
        }
    }

    @objc private func updateShareState(_ tap: UITapGestureRecognizer) {
        isSelected.toggle()
        if isSelected {
            shareImage.image = UIImage(systemName: "arrowshape.turn.up.right.fill")
            shareImage.tintColor = .systemBlue
        } else {
            shareImage.image = UIImage(systemName: "arrowshape.turn.up.right")
            shareImage.tintColor = .black
        }
        updateShareNumber()
    }
    

}
