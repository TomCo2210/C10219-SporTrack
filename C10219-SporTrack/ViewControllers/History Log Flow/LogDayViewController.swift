//
//  LogDayViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit
import MapKit

class LogDayViewController: UIViewController {
    //MARK:- Members
    var selectedDate : String!
    var records = [Record]()
    
    //MARK: - View Components
    @IBOutlet weak var day_TV_records: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.day_TV_records.dataSource = self
        title = selectedDate
        
        //Load Exercises of that day
        FirebaseFunctions.getExercise(day: selectedDate, callBack: { (exercises) in
            for exercise in exercises{
                self.records.append(exercise)
                self.records.sort (by: self.sorter)
                self.day_TV_records.reloadData()
            }
        })
        //Load Endurances of that day
        FirebaseFunctions.getEndurance(day: selectedDate, callBack: { (endurances) in
            for endurance in endurances{
                self.records.append(endurance)
                self.records.sort (by: self.sorter)
                self.day_TV_records.reloadData()
            }
        })
        
    }
    func sorter(a:Record, b:Record) -> Bool {
        if let first = a as? ExerciseToSave, let second = b as? ExerciseToSave
        {
            return first.timestamp! < second.timestamp!
        }
        if let first = a as? ExerciseToSave, let second = b as? Endurance
        {
            return first.timestamp! < second.timestamp!
        }
        if let first = a as? Endurance, let second = b as? ExerciseToSave
        {
            return first.timestamp! < second.timestamp!
        }
        if let first = a as? Endurance, let second = b as? Endurance
        {
            return first.timestamp! < second.timestamp!
        }
        return false
    }
}
//MARK: - TableView Protocols
extension LogDayViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        if records[indexPath.row] is Endurance {
            let record = records[indexPath.row] as? Endurance
            let workingCell = self.day_TV_records.dequeueReusableCell(withIdentifier: K.enduranceLogTVCell, for: indexPath) as? EnduranceEntryTableViewCell
            workingCell?.enduranceEntry_Label_Icon.text = K.Endurance.types[(record?.type)!]
            workingCell?.enduranceEntry_Label_time.text = "\(K.History.timeLabel) \(dateFormatter.string(from: (record?.timestamp)!))"
            workingCell?.enduranceEntry_Label_duration.text = "\(K.History.durationLabel) \(FormatDisplay.time((record?.duration)!))"
            workingCell?.enduranceEntry_Label_distance.text = "\(K.History.distanceLabel) \(FormatDisplay.distance((record?.distance)!))"
            workingCell?.enduranceEntry_MapView_map.delegate = self
            loadMap( mapView: (workingCell?.enduranceEntry_MapView_map)!, record: record!)
            cell = workingCell
        }
        else {
            let record = records[indexPath.row] as? ExerciseToSave
            let workingCell = self.day_TV_records.dequeueReusableCell(withIdentifier: K.exerciseLogTVCell, for: indexPath) as? ExerciseEntryTableViewCell
            workingCell?.exerciseEntry_Label_Title.text = record?.title
            workingCell?.exerciseEntry_Label_Category.text = record?.category
            workingCell?.exerciseEntry_Label_Time.text = "\(K.History.timeLabel) \(dateFormatter.string(from: (record?.timestamp)!))"
            workingCell?.exerciseEntry_Label_Sets.text = "\(K.History.setsTitle) \((record?.sets)!)"
            workingCell?.exerciseEntry_Label_Returns.text = "\(K.History.returnsTitle) \((record?.returns)!)"
            cell = workingCell
        }
        
        return cell!
    }
    
    
}

//MARK: - MapView Extension
extension LogDayViewController {
    //Region
    private func mapRegion(record:Endurance) -> MKCoordinateRegion? {
        let latitudes = record.locations.map { location -> Double in
            return location.latitude!
        }
        let longitudes = record.locations.map { location -> Double in
            return location.longitude!
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                            longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                    longitudeDelta: (maxLong - minLong) * 1.3)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    //Path
    private func polyLine(record:Endurance) -> MKPolyline {
        let locations = record.locations
        var coordinates: [CLLocationCoordinate2D] = []
        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            coordinates.append(coordinate)
        }
        return MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
    
    private func loadMap(mapView:MKMapView, record:Endurance){
        if record.locations.count > 0 {
            let region = mapRegion(record: record)!
            mapView.setRegion(region, animated: true)
            mapView.addOverlay(polyLine(record: record))
        }
    }
}

// MARK: - Map View Delegate
extension LogDayViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }
}
