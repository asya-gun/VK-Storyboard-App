//
//  ViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 11.01.2023.
//

import UIKit

class SquareViewController: UIViewController {

    @IBOutlet weak var SquareView: UIView!
    
    @IBOutlet weak var squareButton: UIButton!
    
    @IBOutlet weak var Purpler: UIButton!
    var viewIsShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SquareView.anchorPoint = CGPoint(x: 1, y: 0)

    }
    
    func setInitialViewTransform() {
        let rotation = CATransform3DMakeRotation(.pi, 0, 0, 1)
    let scale = CATransform3DScale(CATransform3DIdentity, 0.8, 0.8, 0)
    let transform = CATransform3DConcat(rotation, scale)
    self.SquareView.transform = CATransform3DGetAffineTransform(transform)
    }
    
    @IBAction func toggleViewVisibility() {
        UIView.animate(withDuration: 1, animations: {
            if self.viewIsShown {
                self.setInitialViewTransform()
            } else {
                self.SquareView.transform = .identity
            }
        }, completion: { _ in
            self.viewIsShown = !self.viewIsShown
        })
    }
    


    @IBAction func showPurpleScreen() {
        let purpleVC = storyboard?.instantiateViewController(withIdentifier: "PurpleViewController") as! PurpleViewController
        
        purpleVC.transitioningDelegate = purpleVC
        
        self.present(purpleVC, animated: true)
    }

}
