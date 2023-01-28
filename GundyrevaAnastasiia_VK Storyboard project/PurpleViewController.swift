//
//  PurpleViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 12.01.2023.
//

import UIKit

class PurpleViewController: UIViewController {
    
    @IBOutlet weak var figureView: UIView!
    
    let interactiveTransition = SwipeDownAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    let combPath: UIBezierPath = {
        let path = UIBezierPath()
        //honeycomb
        path.move(to: CGPoint(x: 30, y: 15))
        path.addLine(to: CGPoint(x: 140, y: 15))
        path.addLine(to: CGPoint(x: 90, y: 85))
        path.addLine(to: CGPoint(x: 140, y: 155))
        path.addLine(to: CGPoint(x: 30, y: 155))
        path.addLine(to: CGPoint(x: 80, y: 85))
        path.close()
        path.stroke()
        
        return path
    }()
    

    @IBAction func PopPurple(_ sender: Any) {
        
        self.dismiss(animated: true)
    }

    @IBAction func animateComb(_ sender: Any) {
        
        let underlayer = CAShapeLayer()
        underlayer.path = combPath.cgPath
        underlayer.lineWidth = 15
        underlayer.strokeColor = UIColor.lightGray.cgColor
        underlayer.opacity = 0.5
        underlayer.fillColor = UIColor.white.cgColor
        underlayer.strokeEnd = 1
        underlayer.strokeStart = 0

        let layer = CAShapeLayer()
        layer.path = combPath.cgPath
        layer.lineWidth = 10
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.opacity = 0.4
        
        layer.strokeEnd = 1
        layer.strokeStart = 0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        strokeEndAnimation.fromValue = -0.1
        strokeEndAnimation.toValue = 0.9
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
//        strokeEndAnimation.duration = 4
//        layer.add(strokeEndAnimation, forKey: nil)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        
        strokeStartAnimation.fromValue = -0.25
        strokeStartAnimation.toValue = 0.95
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        animationGroup.duration = 3
        
        animationGroup.repeatCount = .infinity
        layer.add(animationGroup, forKey: nil)
        
        figureView.layer.addSublayer(underlayer)
        figureView.layer.addSublayer(layer)
        
//        let pointLayer = CAShapeLayer()
//        pointLayer.backgroundColor = UIColor.systemGray4.cgColor
//        pointLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//        pointLayer.cornerRadius = pointLayer.bounds.width/2
//
//        figureView.layer.addSublayer(pointLayer)
//
//        let followAnimation = CAKeyframeAnimation(keyPath: #keyPath(CAScrollLayer.position))
//        followAnimation.path = combPath.cgPath
//        followAnimation.calculationMode = .paced
//        followAnimation.duration = 2
//        followAnimation.repeatCount = .infinity
//
//        pointLayer.add(followAnimation, forKey: nil)
        
    }
    
    
    


}

extension PurpleViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}
