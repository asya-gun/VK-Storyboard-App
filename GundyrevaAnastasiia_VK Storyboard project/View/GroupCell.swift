//
//  GroupCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var imageGroupCell: UIImageView!
    
    @IBOutlet weak var labelGroupCell: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateSmallerSpringImage()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateBiggerSpringImage()
        
//        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
//            self.transform = .identity
//        })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animateBiggerSpringImage()
//        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
//            self.transform = .identity
//        })
    }
    
    private func animateSmallerSpringImage() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.8
        animation.stiffness = 200
        animation.mass = 1
        animation.duration = 1.5
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        imageGroupCell.layer.add(animation, forKey: nil)
        imageGroupCell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    private func animateBiggerSpringImage() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 1
        animation.duration = 1.5
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        imageGroupCell.layer.add(animation, forKey: nil)
        imageGroupCell.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    func configure(image: UIImage) {
        imageGroupCell.image = image
    }
    func configure(imageUrl: String) {
        imageGroupCell.sd_setImage(with: URL(string: imageUrl))
    }
    func configure(text: String) {
        labelGroupCell.text = text
    }
    
}
