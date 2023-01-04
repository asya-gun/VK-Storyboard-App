//
//  ViewController.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 29.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var dotOne: UIView!
    
    @IBOutlet weak var dotTwo: UIView!
    
    @IBOutlet weak var dotThree: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateTitle()
        animateTitleLabels()
        animateTextFields()
        animateLoginButton()
        setUpDots()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGR)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
        
        @objc func willShowKeyboard(_ notification: Notification) {
            
            guard let info = notification.userInfo as NSDictionary?,
                  let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
            let keyboardHeight = keyboardSize.cgRectValue.size.height
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    @objc func willHideKeyboard(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
        let keyboardHeight = keyboardSize.cgRectValue.size.height
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardHeight, right: 0)
    }
    
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              username == "",
              password == "" else {
            
            show(message: "Error wrong password")
            return
            
        }
        loadDots()
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { timer in
            self.performSegue(withIdentifier: "Login", sender: nil)
        })
        
    }
    
    private func setUpDots() {
        dotOne.layer.cornerRadius = dotOne.layer.bounds.width/2
        dotOne.layer.backgroundColor = UIColor.clear.cgColor
        
        dotTwo.layer.cornerRadius = dotOne.layer.bounds.width/2
        dotTwo.layer.backgroundColor = UIColor.clear.cgColor
        
        dotThree.layer.cornerRadius = dotOne.layer.bounds.width/2
        dotThree.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    private func loadDots() {
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.2,
                                options: [.autoreverse, .repeat],
                                animations: {
            self.dotOne.frame.origin.y -= 10
            self.dotOne.alpha = 1
            self.dotOne.backgroundColor = .systemPurple
        })
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.5,
                                options: [.autoreverse, .repeat],
                                animations: {
            self.dotTwo.frame.origin.y -= 10
            self.dotTwo.alpha = 1
            self.dotTwo.backgroundColor = .systemPurple
        })
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.8,
                                options: [.autoreverse, .repeat],
                                animations: {
            self.dotThree.frame.origin.y -= 10
            self.dotThree.alpha = 1
            self.dotThree.backgroundColor = .systemPurple
        })
    }
    
    func animateTitleLabels() {
        let offset = view.bounds.width
        usernameLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
            self.usernameLabel.transform = .identity
            self.passwordLabel.transform = .identity
        }, completion: nil)
    }
    
    func animateTitle() {
        self.titleImage.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
        self.titleText.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.titleImage.transform = .identity
            self.titleText.transform = .identity
        }, completion: nil)
    }
    
    func animateTextFields() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.usernameTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateLoginButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
}

