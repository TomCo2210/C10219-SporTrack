//
//  User.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation

class User : Codable {
    
    var fullname : String
    var weight : Double
    var height : Double
    var birthDate : Date
    
    init (fullname : String, height : Double, weight : Double, birthDate : Date){
        self.fullname = fullname
        self.height = height
        self.weight = weight
        self.birthDate = birthDate
    }
}
