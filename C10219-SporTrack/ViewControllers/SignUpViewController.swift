//
//  SignUpViewController.swift
//  C10219-SporTrack
//
//  Created by user167774 on 22/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
    //MARK: - Members
    @IBOutlet weak var signUp_ET_Email: UITextField!
    @IBOutlet weak var signUp_ET_Password: UITextField!
    @IBOutlet weak var signUp_ET_Fullname: UITextField!
    @IBOutlet weak var signUp_ET_height: UITextField!
    @IBOutlet weak var signUp_ET_weight: UITextField!
    @IBOutlet weak var signUp_DATEPICKER_birthDate: UIDatePicker!
    @IBOutlet weak var signUp_LBL_Error: UILabel!
    let db = Firestore.firestore()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp_LBL_Error.alpha = 0
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - SignUpButton onClick()
    @IBAction func signUpPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var user : User!
        
        if let fullname = signUp_ET_Fullname.text, let height = Double(signUp_ET_height.text!), let weight = Double(signUp_ET_weight.text!)
        {
            user = User(fullname: fullname, height: height, weight: weight, birthDate: self.signUp_DATEPICKER_birthDate.date )
            if let email = signUp_ET_Email.text, let password = signUp_ET_Password.text
            {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.showError(e.localizedDescription)
                    } else {
                        //create user in Firestore
                        do{
                            try self.db.collection(K.FStore.UserCollection).document(Auth.auth().currentUser!.uid).setData(from: user)
                        } catch{
                            self.showError(error.localizedDescription)
                        }
                        //Navigate to App
                        self.performSegue(withIdentifier: K.Segues.registerSegue, sender: self)
                    }
                }
            }
        } else {
            showError(K.SignUp.insufficientData)
        }
    }
    
    //MARK: - Error Message
    func showError(_ message:String) {
        signUp_LBL_Error.text = message
        signUp_LBL_Error.alpha = 1
    }
}
