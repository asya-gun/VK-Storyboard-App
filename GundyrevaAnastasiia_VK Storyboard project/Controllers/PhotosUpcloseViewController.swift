//
//  PhotosUpcloseViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 04.01.2023.
//

import UIKit

class PhotosUpcloseViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    var friend: User?
    var photos: [String] = []
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedPhoto = photos[selectedIndex]
        photo.image = UIImage(named: selectedPhoto)
        
        let swipeRight = UISwipeGestureRecognizer(target: photo, action: #selector(swipePictureRight(_ :)))
        let swipeLeft = UISwipeGestureRecognizer(target: photo, action: #selector(swipePictureLeft(_ :)))
        swipeRight.direction = .right
        swipeLeft.direction = .left
        photo.addGestureRecognizer(swipeRight)
        photo.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipePictureRight(_ swipe: UISwipeGestureRecognizer) {
        var selectedPhoto = photos[selectedIndex]
        if selectedIndex + 1 < photos.count {
            selectedIndex += 1
            selectedPhoto = photos[selectedIndex]
            photo.image = UIImage(named: selectedPhoto)
        } else {
            selectedIndex = 0
            selectedPhoto = photos[selectedIndex]
            photo.image = UIImage(named: selectedPhoto)
        }
    }
    @objc func swipePictureLeft(_ swipe: UISwipeGestureRecognizer) {
        var selectedPhoto = photos[selectedIndex]
        if selectedIndex - 1 >= 0 {
            selectedIndex -= 1
            selectedPhoto = photos[selectedIndex]
            photo.image = UIImage(named: selectedPhoto)
        } else {
            selectedIndex = photos.count - 1
            selectedPhoto = photos[selectedIndex]
            photo.image = UIImage(named: selectedPhoto)
        }
    }
    
    private func animatePicture() {
        let animator = UIViewPropertyAnimator(duration: 2, dampingRatio: 0.5, animations: {
            
        })
    }
    
}
