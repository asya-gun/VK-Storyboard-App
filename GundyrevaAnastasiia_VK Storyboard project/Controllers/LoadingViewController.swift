//
//  LoadingViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 12.01.2023.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var figureView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureView.backgroundColor = UIColor.clear

        let timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { timer in
            self.performSegue(withIdentifier: "Login", sender: nil)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadSandClock()
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
    
    func loadSandClock() {
        
        let underlayer = CAShapeLayer()
        underlayer.path = combPath.cgPath
        underlayer.lineWidth = 15
        underlayer.strokeColor = UIColor.white.cgColor
        underlayer.opacity = 0.5
        underlayer.fillColor = UIColor.clear.cgColor
        underlayer.strokeEnd = 1
        underlayer.strokeStart = 0

        let layer = CAShapeLayer()
        layer.path = combPath.cgPath
        layer.lineWidth = 10
        layer.strokeColor = UIColor.magenta.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.opacity = 0.4
        
        layer.strokeEnd = 1
        layer.strokeStart = 0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        strokeEndAnimation.fromValue = -0.1
        strokeEndAnimation.toValue = 0.9
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        
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
    }

}
