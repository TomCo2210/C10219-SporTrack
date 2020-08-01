//
//  EnduranceEntryTableViewCell.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit
import MapKit
class EnduranceEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var enduranceEntry_Label_Icon: UILabel!
    @IBOutlet weak var enduranceEntry_Label_time: UILabel!
    @IBOutlet weak var enduranceEntry_MapView_map: MKMapView!
    @IBOutlet weak var enduranceEntry_Label_distance: UILabel!
    @IBOutlet weak var enduranceEntry_Label_duration: UILabel!
}
