//
//  InAppViewController.swift
//  C10219-SporTrack
//
//  Created by user167774 on 27/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import UIKit

class InAppViewController: UITabBarController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(
                descriptor: UIFontDescriptor(
                    name : "Marker Felt Thin",
                    size: 20),
                size: 20)
        ]
        navigationItem.hidesBackButton = true
    }
}
