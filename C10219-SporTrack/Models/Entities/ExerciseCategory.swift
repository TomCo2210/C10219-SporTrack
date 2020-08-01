//
//  ExerciseCategory.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation
//for the hardcoded categories
class ExerciseCategory : Codable {
    
    var title :String = ""
    var imageName :String = ""
    var exercises : [Exercise]?
    init(){}
    
    init(title : String, imageName : String, exercises: [Exercise]){
        self.title = title
        self.imageName = imageName
        self.exercises = exercises
    }
}
