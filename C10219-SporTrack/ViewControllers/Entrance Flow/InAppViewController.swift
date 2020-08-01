//
//  InAppViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit

class InAppViewController: UITabBarController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(
                descriptor: UIFontDescriptor(
                    name : "Marker Felt Thin",
                    size: 20),
                size: 20)
        ]
        navigationItem.hidesBackButton = true
    }
    func setTitle(_ newTitle : String){
        title = newTitle
    }
}

