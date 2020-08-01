//
//  ExerciseToSave.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation

class ExerciseToSave : Record, Codable {
    var timestamp : Date?
    var title : String?
    var sets : Int?
    var returns : Int?
    var category : String?
}
