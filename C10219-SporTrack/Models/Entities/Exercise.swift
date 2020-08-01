//
//  Exercise.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation

//for the hardcoded exercises in categories
class Exercise : Codable {
    var title : String = ""
    var imageName : String = ""
    var description : String = ""
    var difficulty : Int?
    var sets : Int = K.baseSetsNumber
    var returns : Int = K.baseReturnNumber
    
    init() {}
    
    init(title: String, imageName:String ,description:String, difficulty:Int ,sets:Int, returns:Int){
        self.title = title
        self.imageName = imageName
        self.description = description
        self.difficulty = difficulty
        self.sets = sets
        self.returns = returns
    }
    
}
