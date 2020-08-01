//
//  ExerciseTimerViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit
import Firebase
import FirebaseFirestoreSwift
import AVFoundation

class ExerciseTimerViewController: UIViewController {
    //MARK: - Members
    var selectedCategoryIndex : IndexPath?
    var selectedExerciseIndex : IndexPath?
    var timestamp : Date?
    var restTimes : Int?
    var timer : Timer?
    var timerTime : Int!
    var audioPlayer : AVAudioPlayer?
    
    //MARK: - View Components
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var Exercise_ImageView_Image: UIImageView!
    @IBOutlet weak var Exercise_Label_name: UILabel!
    @IBOutlet weak var Exercise_Label_description: UILabel!
    @IBOutlet weak var Exercise_ET_sets: UITextField!
    @IBOutlet weak var Exercise_ET_times: UITextField!
    @IBOutlet weak var Exercise_Label_difficulty: UILabel!
    @IBOutlet weak var Exercise_Label_Timer: UILabel!
    @IBOutlet weak var Exercise_Button_Done: UIButton!
    @IBOutlet weak var Exercise_Button_Start: UIButton!
    @IBOutlet weak var Exercise_Button_Stop: UIButton!
    @IBOutlet weak var Exercise_BarButton_Done: UIBarButtonItem!
    
    @IBOutlet weak var Exercise_Label_RestTimes: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        inflateExerciseToView()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Buttons onClick()
    @IBAction func stopButtonPressed(_ sender: Any) {
        //hide stop show start
        Exercise_Button_Start.isHidden = false
        Exercise_Button_Stop.isHidden = true
        timer!.invalidate()
        restTimes!+=1
        Exercise_Label_RestTimes.text = "\(K.lapCounter)\(restTimes!+1)"
        updateView(K.RestTimeInSeconds)
        //reset timer
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if (restTimes!+1 < Int(Exercise_ET_sets.text!)!){
            //hide start show stop
            Exercise_Button_Start.isHidden = true
            Exercise_Button_Stop.isHidden = false
            //starting timer
            timerTime = K.RestTimeInSeconds
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .common)
        }
        else{
            let alert = UIAlertController(title: "Oops!", message: "You have Finished Your Sets For This Exercise!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert,animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "End Exercise?",
                                                message: "Do you wish to end your workout?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.saveExercise()
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alertController, animated: true)
    }
    
    //MARK: - Timer
    @objc func timerCountDown() {
        timerTime -= 1
        updateView(timerTime)
        
        if timerTime <= 0 {
            timer?.invalidate()
            //PLAY BEEP!
            let pathToSound = Bundle.main.path(forResource: "Honk", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                print("BEEP!")
            } catch {
                print("ERROR")
            }
            Exercise_Button_Start.isHidden = false
            Exercise_Button_Stop.isHidden = true
            restTimes!+=1
            Exercise_Label_RestTimes.text = "\(K.lapCounter)\(restTimes!+1)"
            updateView(K.RestTimeInSeconds)
        }
    }
    
    func updateView(_ timeTitle : Int){
        let seconds = String(format: "%02d", (timeTitle%60))
        let minutes = String(format: "%02d", timeTitle/60)
        Exercise_Label_Timer.text = "\(minutes):\(seconds)"
    }
    
    
    //MARK: - View Inflation
    func inflateExerciseToView() {
        self.timestamp = Date()
        self.restTimes = 0
        Exercise_ImageView_Image.image = UIImage(named: K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].imageName)
        Exercise_Label_name.text = K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].title
        Exercise_ET_sets.text = "\(K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].sets)"
        Exercise_ET_times.text = "\(K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].returns)"
        Exercise_Label_description.text = K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].description
        Exercise_Label_difficulty.text = K.Levels[K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].difficulty!]
        Exercise_Label_difficulty.textColor = K.LevelColors[K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].difficulty!]
        Exercise_Label_RestTimes.text = "\(K.lapCounter)\(restTimes!+1)"
        Exercise_Button_Stop.isHidden = true
        updateView(K.RestTimeInSeconds)
    }
    
    //MARK: - FireStore Saving
    func saveExercise(){
        let newExercise = ExerciseToSave()
        newExercise.title = K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![selectedExerciseIndex!.row].title
        newExercise.category = K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].title
        newExercise.sets = restTimes!+1
        newExercise.returns = Int(Exercise_ET_times.text!)
        newExercise.timestamp = self.timestamp
        
        let db = FirebaseFunctions.getDbRef()
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            try db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid).collection(dateFormatter.string(from: newExercise.timestamp!)).document().setData(from: newExercise)
            dateFormatter.dateStyle = .short
            db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid).getDocument { (documentSnapshot, error) in
                if error == nil {
                    if documentSnapshot != nil {
                        if (documentSnapshot?.get(K.FStore.datesArray) != nil){
                            db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid).updateData([K.FStore.datesArray : FieldValue.arrayUnion([dateFormatter.string(from: newExercise.timestamp!)])])
                        }
                        else {
                            db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid).setData([K.FStore.datesArray : FieldValue.arrayUnion([dateFormatter.string(from: newExercise.timestamp!)])])
                        }
                    }
                }
            }
        } catch {
            // handle the error here
        }
    }
}
