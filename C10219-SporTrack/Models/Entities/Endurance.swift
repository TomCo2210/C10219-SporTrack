//
//  Endurance.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation

class Endurance: Record, Codable {
    var type : Int?
    var distance : Double?
    var duration : Int?
    var timestamp : Date?
    var locations : [Location] = [Location]()
    
}
