//
//  LikeButton.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 23.12.2022.
//

import UIKit

//@IBDesignable
class LikeButton: UIControl {
    
    @IBOutlet var likeImage: UIImageView? {
        didSet {
            likeImage?.image = UIImage(named: "heart")
        }
    }

    private var likeLabel: UILabel!
    private var likeNumber: Int = 0
    private var stackView: UIStackView!
    private var heartButton: UIButton!

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
        heartButton = UIButton()
        heartButton.setImage(likeImage?.image, for: .normal)
        likeImage?.contentMode = .scaleAspectFit
//        heartButton.imageView?.contentMode = .scaleAspectFit
//        heartButton.contentMode = .scaleAspectFit
        likeLabel = UILabel()
        likeLabel.textAlignment = .center
        stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [likeLabel, heartButton])

        self.addSubview(stackView)
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill

        heartButton.addTarget(self, action: #selector(updateLikeState(_ :)), for: .touchUpInside)
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

    @objc private func updateLikeState(_ sender: Any) {
        isSelected.toggle()
        if isSelected {
 //           heartButton.setImage(UIImage(named: "heart_fill"), for: .normal)
            
        } else {
//            heartButton.setImage(UIImage(named: "heart"), for: .normal)
            
        }
        updateLikeNumber()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isSelected = !isSelected
//        updateLikeState()
//        sendActions(for: .valueChanged)
//    }
    


}
