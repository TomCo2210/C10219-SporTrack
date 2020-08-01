//
//  ProfileViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit
import Firebase
import FirebaseFirestoreSwift

class ProfileViewController: UIViewController {
    
    //MARK: - View Components
    @IBOutlet weak var profile_IV_image: UIImageView!
    @IBOutlet weak var profile_Label_Name: UILabel!
    @IBOutlet weak var profile_Label_Birthdate: UILabel!
    @IBOutlet weak var profile_Label_Height: UILabel!
    @IBOutlet weak var profile_Label_weight: UILabel!
    
    //MARK: - Members
    var user : User!
    
    //MARK:- LifyCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let i = (navigationController?.viewControllers.count)!
        let previousViewController = navigationController?.viewControllers[i-1]
        previousViewController?.navigationItem.title = K.Titles.ProfileScreenTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseFunctions.getUserInfo { (user) in
            self.user = user
            self.updateProfileView()
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Update View
    func updateProfileView () {
        //profile_IV_image
        profile_Label_Name.text = user.fullname
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        profile_Label_Birthdate.text = "\(K.Profile.BirthDateLabel) \(dateFormatter.string(from: user.birthDate))"
        profile_Label_Height.text = "\(K.Profile.HeightLabel) \(user.height)"
        profile_Label_weight.text = "\(K.Profile.WeightLabel) \(user.weight)"
    }
    
    // MARK: - Navigation
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
