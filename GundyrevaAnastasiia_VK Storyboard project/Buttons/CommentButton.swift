//
//  CommentButton.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 30.12.2022.
//

import UIKit

class CommentButton: UIControl {

    @IBOutlet var commentImage: UIImageView! {
        didSet {
            commentImage.image = UIImage(systemName: "message")
            commentImage.tintColor = .black
        }
    }

    private var commentLabel: UILabel!
    private var commentNumber: Int = 0
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
        commentImage = UIImageView()
        commentImage.contentMode = .scaleAspectFit

        commentLabel = UILabel()
        commentLabel.textAlignment = .left
        stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [commentLabel])

        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        layer.cornerRadius = bounds.width/4

        let tap = UITapGestureRecognizer(target: self, action: #selector(updateCommentState(_ :)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        updateCommentNumber()

    }

    private func updateCommentNumber() {
        if isSelected {
            commentLabel.text = "\(commentNumber + 1)"
            commentLabel.textColor = .systemBlue
        } else {
            commentLabel.text = "\(commentNumber)"
            commentLabel.textColor = .black
        }
    }

    @objc private func updateCommentState(_ tap: UITapGestureRecognizer) {
        isSelected.toggle()
        if isSelected {
            commentImage.image = UIImage(systemName: "message.fill")
            commentImage.tintColor = .systemBlue
        } else {
            commentImage.image = UIImage(systemName: "message")
            commentImage.tintColor = .black
        }
        updateCommentNumber()
    }
}
