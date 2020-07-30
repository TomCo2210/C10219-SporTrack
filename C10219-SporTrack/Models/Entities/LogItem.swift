//
//  LogItem.swift
//  C10219-SporTrack
//
//  Created by user167774 on 30/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import Foundation

class LogItem : Codable {
    var type : String = ""
    var workout : Workout = Workout()
}
