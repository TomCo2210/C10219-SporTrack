//
//  EnduranceViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit
import CoreLocation
import MapKit
import FirebaseFirestoreSwift
import Firebase

class EnduranceViewController: UIViewController {
    
    //MARK: - View Components
    @IBOutlet weak var Endurance_SegCtrl_type: UISegmentedControl!
    @IBOutlet weak var Endurance_MKMapView_Map: MKMapView!
    @IBOutlet weak var Endurance_Label_Distance: UILabel!
    @IBOutlet weak var Endurance_Label_Time: UILabel!
    @IBOutlet weak var Endurance_Label_Pace: UILabel!
    @IBOutlet weak var Endurance_Button_Start: UIButton!
    @IBOutlet weak var Endurance_Button_Stop: UIButton!
    
    
    //MARK: - Members
    var endurance : Endurance?
    let LM = LocationManager.sharedLM
    var seconds = 0
    var timer :Timer?
    var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let i = (navigationController?.viewControllers.count)!
        let previousViewController = navigationController?.viewControllers[i-1]
        previousViewController?.navigationItem.title = K.Titles.EnduranceScreenTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Endurance_Button_Stop.isHidden = true
        Endurance_MKMapView_Map.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        LM.stopUpdatingLocation()
    }
    
    //MARK: - Start/Stop Buttons onClick()
    @IBAction func startButtonClicked(_ sender: Any) {
        startEndurance()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "End Endurance Workout?",
                                                message: "Do you wish to end your workout?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopEndurance()
            self.saveEndurance()
            //self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopEndurance()
            //_ = self.navigationController?.popToRootViewController(animated: true)
        })
        present(alertController, animated: true)
    }
    
    //MARK: - Start / Stop
    private func startEndurance() {
        Endurance_Button_Start.isHidden = true
        Endurance_Button_Stop.isHidden = false
        Endurance_MKMapView_Map.removeOverlays(Endurance_MKMapView_Map.overlays)
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
    }
    
    private func stopEndurance() {
        Endurance_Button_Start.isHidden = false
        Endurance_Button_Stop.isHidden = true
        LM.stopUpdatingLocation()
        timer?.invalidate()
        Endurance_MKMapView_Map.removeOverlays(Endurance_MKMapView_Map.overlays)
    }
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    //MARK: - Display Update
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerKilometer)
        
        Endurance_Label_Distance.text = "\(K.Endurance.distanceLabel) \(formattedDistance)"
        Endurance_Label_Time.text = "\(K.Endurance.timeLabel)  \(formattedTime)"
        Endurance_Label_Pace.text = "\(K.Endurance.paceLabel)  \(formattedPace)"
    }
    
    //MARK: - Location
    private func startLocationUpdates() {
        LM.delegate = self
        LM.activityType = .fitness
        LM.distanceFilter = 10
        LM.startUpdatingLocation()
    }
    
    //MARK: - Save Endurance
    private func saveEndurance() {
        let newEndurance = Endurance()
        newEndurance.type = Endurance_SegCtrl_type.selectedSegmentIndex
        newEndurance.distance = distance.value
        newEndurance.duration = seconds
        newEndurance.timestamp = locationList[0].timestamp
        
        for location in locationList {
            let locationObject = Location()
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newEndurance.locations.append(locationObject)
        }
        
        endurance = newEndurance
        let db = FirebaseFunctions.getDbRef()
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            try db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid).collection(dateFormatter.string(from: newEndurance.timestamp!)).document().setData(from: newEndurance)
            dateFormatter.dateStyle = .short
            //check if first time
            db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid).getDocument { (documentSnapshot, error) in
                if error == nil {
                    if documentSnapshot != nil {
                        if (documentSnapshot?.get(K.FStore.datesArray) != nil){
                            db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid).updateData([K.FStore.datesArray : FieldValue.arrayUnion([dateFormatter.string(from: newEndurance.timestamp!)])])
                        }
                        else {
                            db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid).setData([K.FStore.datesArray : FieldValue.arrayUnion([dateFormatter.string(from: newEndurance.timestamp!)])])
                        }
                    }
                }
            }
        } catch {
            // handle the error here
        }
    }
}

// MARK: - Location Manager Delegate
extension EnduranceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                Endurance_MKMapView_Map.addOverlay(polyline)
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                Endurance_MKMapView_Map.setRegion(region, animated: true)
            }
            print(newLocation)
            locationList.append(newLocation)
        }
    }
}

// MARK: - Map View Delegate
extension EnduranceViewController: MKMapViewDelegate {
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
