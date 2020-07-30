//
//  Workout.swift
//  C10219-SporTrack
//
//  Created by user167774 on 27/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import Foundation

class Workout : Codable {
    
    var title :String = ""
    var imageName :String = ""
    
    init(){}
    
    init(title : String, imageName : String){
        self.title = title
        self.imageName = imageName
    }
}
