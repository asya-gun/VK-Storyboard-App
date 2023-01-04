//
//  AvatarCircleView.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 22.12.2022.
//

import UIKit

//@IBDesignable
class AvatarCircleView: UIView {

   
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.7 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    
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
        
        self.layer.add(animation, forKey: nil)
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
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
        
        self.layer.add(animation, forKey: nil)
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
