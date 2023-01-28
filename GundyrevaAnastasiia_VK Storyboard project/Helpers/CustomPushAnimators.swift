//
//  CustomPushAnimator.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 09.01.2023.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1.2
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        
        source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
     
        
        let rotation = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        let translation = CGAffineTransform(translationX: source.view.bounds.width/2, y: -source.view.bounds.height/2)
        destination.view.transform = CATransform3DGetAffineTransform(rotation).concatenating(translation)
        source.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height/2)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {

                let translation = CGAffineTransform(translationX: 10, y: -100)
                let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                let rotation = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
                destination.view.transform = translation
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                let rotation = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                let translation = CGAffineTransform(translationX: 200, y: -source.view.bounds.height/2)
                source.view.transform = CATransform3DGetAffineTransform(rotation).concatenating(scale).concatenating(translation)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.6, animations: {

                destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width/2, y: -source.view.bounds.height/2)
                destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                destination.view.transform = .identity
            })
        }, completion: {finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
    }
}

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: TimeInterval = 1.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        source.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height/2)
        
        let rotation = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        let translation = CGAffineTransform(translationX: -source.view.bounds.width/2, y: -source.view.bounds.height/2)
        destination.view.transform = CATransform3DGetAffineTransform(rotation).concatenating(translation)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                let rotation = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
                let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                let translation = CGAffineTransform(translationX: 200, y: -source.view.bounds.height/2)
                source.view.transform = CATransform3DGetAffineTransform(rotation).concatenating(translation)
            })
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
//                let translation = CGAffineTransform(translationX: source.view.bounds.width/2, y: 0)
//                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                source.view.transform = translation.concatenating(scale)
//            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width/2, y: -source.view.bounds.height/2)
                destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                destination.view.transform = .identity
            })
        }, completion: {finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
    }
    
}

class SimpleOver: NSObject, UIViewControllerAnimatedTransitioning {
        
        var popStyle: Bool = false
        
        func transitionDuration(
            using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 1
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            if popStyle {
                
                animatePop(using: transitionContext)
                return
            }
            
            let source = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let destination = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            
            let finalFrame = transitionContext.finalFrame(for: destination)
            
            let frameOffset = finalFrame.offsetBy(dx: finalFrame.width, dy: 55)
            destination.view.frame = frameOffset
            let rotation = CATransform3DMakeRotation(0.5, 0, 1, 0)
            
            transitionContext.containerView.insertSubview(destination.view, aboveSubview: source.view)
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    destination.view.frame = finalFrame
                    destination.view.transform = CATransform3DGetAffineTransform(rotation)
            }, completion: {_ in
                    transitionContext.completeTransition(true)
            })
        }
        
        func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
            
            let source = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let destination = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            
            let finalFrame = transitionContext.initialFrame(for: source)
            let frameOffsetPop = finalFrame.offsetBy(dx: finalFrame.width, dy: 70)
            let rotation = CATransform3DMakeRotation(0.5, 1, 0, 0)
            
            transitionContext.containerView.insertSubview(destination.view, belowSubview: source.view)
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    source.view.transform = CATransform3DGetAffineTransform(rotation)
                    source.view.frame = frameOffsetPop
                    
            }, completion: {_ in
                    transitionContext.completeTransition(true)
            })
        }
    }
