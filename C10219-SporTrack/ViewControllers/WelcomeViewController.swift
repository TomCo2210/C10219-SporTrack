//
//  ViewController.swift
//  C10219-SporTrack
//
//  Created by user167774 on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
  
    //MARK: - Members
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var main_BTN_signIn: UIButton!
    @IBOutlet weak var main_BTN_signUp: UIButton!
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if (FirebaseAuth.Auth.auth().currentUser != nil) {
            main_BTN_signIn.isHidden = true
            main_BTN_signUp.isHidden = true
        }
        else {
            main_BTN_signIn.isHidden = false
            main_BTN_signUp.isHidden = false
        }
        animateIcons(delay: 0.7)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FirebaseAuth.Auth.auth().currentUser != nil) {
            Timer.scheduledTimer(
                withTimeInterval: 4,
                repeats: false) {
                    (timer) in
                    self.performSegue(withIdentifier: K.Segues.skipSegue, sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    //MARK: - Animation
    func animateIcons( delay:Double = 0) {
        var titleIndex = 0.0
        titleLable.text = ""
        for emoji in K.titleEmojis {
            Timer.scheduledTimer(
                withTimeInterval: delay + (0.2 * titleIndex),
                repeats: false) {
                    (timer) in
                    self.titleLable.text?.removeAll()
                    self.titleLable.text?.append(emoji)
            }
            titleIndex+=1
        }
    }
}

//MARK: - Keyboard Dismiss Ext.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

