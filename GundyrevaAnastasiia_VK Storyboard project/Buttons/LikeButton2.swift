//
//  LikeButton2.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 27.12.2022.
//

import UIKit


class LikeButton2: UIControl {
    
    @IBOutlet var heartImage: UIImageView! {
        didSet {
            heartImage.image = UIImage(systemName: "heart")
            heartImage.tintColor = .black
        }
    }

    private var likeLabel: UILabel!
    private var likeNumber: Int = 0
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
        heartImage = UIImageView()
        heartImage.contentMode = .scaleAspectFit

        likeLabel = UILabel()
        likeLabel.textAlignment = .center
        stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [likeLabel])

        self.addSubview(stackView)
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill

//        heartButton.addTarget(self, action: #selector(updateLikeState(_ :)), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(updateLikeState(_ :)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        updateLikeNumber()

    }

    private func updateLikeNumber() {
        if isSelected {
            likeLabel.text = "\(likeNumber + 1)"
            likeLabel.textColor = .red
        } else {
            likeLabel.text = "\(likeNumber)"
            likeLabel.textColor = .black
        }
    }

    @objc private func updateLikeState(_ tap: UITapGestureRecognizer) {
        isSelected.toggle()
        if isSelected {
 //           heartButton.setImage(UIImage(named: "heart_fill"), for: .normal)
            heartImage.image = UIImage(systemName: "heart.fill")
            heartImage.tintColor = .red
        } else {
//            heartButton.setImage(UIImage(named: "heart"), for: .normal)
            heartImage.image = UIImage(systemName: "heart")
            heartImage.tintColor = .black
        }
        updateLikeNumber()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isSelected = !isSelected
//        updateLikeState()
//        sendActions(for: .valueChanged)
//    }
}
