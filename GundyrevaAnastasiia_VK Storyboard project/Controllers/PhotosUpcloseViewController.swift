//
//  PhotosUpcloseViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 04.01.2023.
//

import UIKit
import SDWebImage

class PhotosUpcloseViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    let session = Session.shared
    let service = Service()
    
    var friend: Friend?
    var photos: [Photo]?
    var selectedIndex: Int = 0
    var nextPhoto = UIImageView()
//    var propertyAnimate = UIViewPropertyAnimator()
//    var propertyAnimateLeft = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedPhoto = photos?[selectedIndex].sizes.last?.url
        photo.sd_setImage(with: URL(string: selectedPhoto ?? ""))
        print(selectedIndex)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipePictureRight(_ :)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipePictureLeft(_ :)))
        swipeRight.direction = .right
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(panPhoto(_:)))
//        view.addGestureRecognizer(pan)
    }
    
    @objc func swipePictureRight(_ swipe: UISwipeGestureRecognizer) {
        let selectedPhoto = photos?[selectedIndex].sizes.last?.url
        if selectedIndex - 1 >= 0 {
//            selectedIndex -= 1
//            selectedPhoto = photos[selectedIndex]
            nextPhoto.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: nextPhoto.bounds.width, y: 0))
            nextPhoto.sd_setImage(with: URL(string: photos?[selectedIndex - 1].sizes.last?.url ?? ""))
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.photo.transform = CGAffineTransform(translationX: self.photo.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.7, y: 0.7))
                self.nextPhoto.transform = .identity
            }, completion: {_ in
                self.selectedIndex -= 1
                self.photo.sd_setImage(with: URL(string: self.photos?[self.selectedIndex].sizes.last?.url ?? ""))
                self.photo.transform = .identity
            })
            photo.sd_setImage(with: URL(string: selectedPhoto ?? ""))
        } else {
//            selectedIndex = photos.count - 1
//            selectedPhoto = photos[selectedIndex]
            nextPhoto.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: nextPhoto.bounds.width, y: 0))
            nextPhoto.sd_setImage(with: URL(string: photos?[(photos?.count ?? 0) - 1].sizes.last?.url ?? ""))
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.photo.transform = CGAffineTransform(translationX: self.photo.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.7, y: 0.7))
                self.nextPhoto.transform = .identity
            }, completion: {_ in
                self.selectedIndex = (self.photos?.count ?? 1) - 1
                self.photo.sd_setImage(with: URL(string: self.photos?[self.selectedIndex].sizes.last?.url ?? ""))
                self.photo.transform = .identity
            })
            photo.sd_setImage(with: URL(string: selectedPhoto ?? ""))
        }

        print("right")
    }
    @objc func swipePictureLeft(_ swipe: UISwipeGestureRecognizer) {
        let selectedPhoto = photos?[selectedIndex].sizes.last?.url

        if selectedIndex + 1 < photos?.count ?? 0 {
//            selectedIndex += 1
//            selectedPhoto = photos[selectedIndex]
            
            nextPhoto.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: nextPhoto.bounds.width, y: 0))
            nextPhoto.sd_setImage(with: URL(string: photos?[selectedIndex + 1].sizes.last?.url ?? ""))
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.photo.transform = CGAffineTransform(translationX: -self.photo.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.7, y: 0.7))
                self.nextPhoto.transform = .identity
            }, completion: {_ in
                self.selectedIndex += 1
                self.photo.sd_setImage(with: URL(string: self.photos?[self.selectedIndex].sizes.last?.url ?? ""))
                self.photo.transform = .identity
            })
            
            photo.sd_setImage(with: URL(string: selectedPhoto ?? ""))
        } else {
//            selectedIndex = 0
//            selectedPhoto = photos[selectedIndex]
            nextPhoto.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: nextPhoto.bounds.width, y: 0))
            nextPhoto.sd_setImage(with: URL(string: photos?.first?.sizes.last?.url ?? ""))
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.photo.transform = CGAffineTransform(translationX: -self.photo.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.7, y: 0.7))
                self.nextPhoto.transform = .identity
            }, completion: {_ in
                self.selectedIndex = 0
                self.photo.sd_setImage(with: URL(string: self.photos?[self.selectedIndex].sizes.last?.url ?? ""))
                self.photo.transform = .identity
            })
            
            photo.sd_setImage(with: URL(string: selectedPhoto ?? ""))
        }
        print("left")
    }
    
//    @objc func panPhoto(_ recognizer: UIPanGestureRecognizer) {
//
//        var isLeft = false
//        switch recognizer.state {
//        case .began:
//            propertyAnimate = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
//                self.photo.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width/2, y: 0)
//            })
//            propertyAnimate.addCompletion({ position in
//                switch position {
//                case .end:
//                    print("end")
//                case .start:
//                    print("start")
//                case .current:
//                    print("current")
//                default:
//                    print("error")
//                }
//                self.photo.transform = .identity
//                print("began")
//            })
//
//            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
//                self.photo.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            })
//
//        case .changed:
//            var percent = recognizer.translation(in: view).x / 200
//            if percent < 0 {
//                percent = -(percent)
//                isLeft = true
//
//            } else {
//
//                propertyAnimate.fractionComplete = min(max(0, percent), 1)
//            }
//            print(percent)
//            print("changed")
//
//        case .ended:
//            if !isLeft {
//                if propertyAnimate.fractionComplete > 0.5 {
//                    propertyAnimate.continueAnimation(withTimingParameters: nil, durationFactor: 0.4)
//                    print("ended more than 50%")
//
//                    //            } else if propertyAnimate.fractionComplete <= 0 {
//                    //                propertyAnimate.stopAnimation(false)
//                    //                print("wtf")
//                } else //if propertyAnimate.fractionComplete <= 0.5 {
//                {
//                    propertyAnimate.isReversed = true
//                    propertyAnimate.continueAnimation(withTimingParameters: nil, durationFactor: 0.4)
//                    print("ended less than 50%")
//                }
//            }
//            print("ended")
//            //photo.transform = CGAffineTransform(scaleX: 1, y: 1)
//        default:
//            break
//        }
//    }
    
 //   private func animatePicture() {
//        photo.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: 0)
//            photo.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: recognizer.translation(in: view).y)
//        let animator = UIViewPropertyAnimator(duration: 2, dampingRatio: 0.5, animations: {
//
//        })
 //   }
    
}

//extension PhotosUpcloseViewController: UIViewControllerTransitioningDelegate {
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        <#code#>
//    }
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        <#code#>
//    }
//}
