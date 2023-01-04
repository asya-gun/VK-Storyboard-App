//
//  LikeButton.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 23.12.2022.
//

import UIKit

//@IBDesignable
class LikeButton: UIControl {
    
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
//        layer.cornerRadius = 5
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
        likeLabel.textAlignment = .left
        stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [likeLabel])

        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        layer.cornerRadius = bounds.width/4

//        heartButton.addTarget(self, action: #selector(updateLikeState(_ :)), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(updateLikeState(_ :)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        updateLikeNumber()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateLikeButton()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.heartImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.heartImage.tintColor = .red
                    })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.heartImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.heartImage.tintColor = .black
        })
    }

    private func updateLikeNumber() {
        if isSelected {
            
            UIView.transition(with: likeLabel, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.likeLabel.text = "\(self.likeNumber + 1)"
                self.likeLabel.textColor = .red
            })
        } else {
            UIView.transition(with: likeLabel, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.likeLabel.text = "\(self.likeNumber)"
                self.likeLabel.textColor = .black
            })
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
    
    private func animateLikeButton() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveEaseIn, .autoreverse, .repeat], animations: {
            self.heartImage.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            self.heartImage.tintColor = .blue

        })
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isSelected = !isSelected
//        updateLikeState()
//        sendActions(for: .valueChanged)
//    }

}
