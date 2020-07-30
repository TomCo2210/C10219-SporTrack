//
//  SignInViewController.swift
//  C10219-SporTrack
//
//  Created by user167774 on 22/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    //MARK: - Members
    @IBOutlet weak var signIn_ET_Email: UITextField!
    @IBOutlet weak var signIn_LBL_Error: UILabel!
    @IBOutlet weak var signIn_ET_password: UITextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signIn_LBL_Error.alpha = 0
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - SignIn onClick()
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = signIn_ET_Email.text, let password = signIn_ET_password.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showError(e.localizedDescription)
                } else{
                    self.performSegue(withIdentifier: K.Segues.logInSegue, sender: self)
                }
            }
        }
    }
    
    //MARK: - Error Message
    func showError(_ message:String) {
        
        signIn_LBL_Error.text = message
        signIn_LBL_Error.alpha = 1
    }
}
