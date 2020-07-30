//
//  Constants.swift
//  C10219-SporTrack
//
//  Created by user167774 on 22/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

struct K {
    
    //MARK: - Main App Details
    static let titleEmojis = "🏋🏻‍♀️🏊🏼🏈🤼‍♂️⚽🤸🏽‍♂️⛹🏿🤺🏐🤾🏼‍♂️🧘🏼‍♂️⚾🏄🏼🏀🚣🏿‍♀️🧗🏽‍♀️🎾🚴🏽🏃🏾🏃🏼‍♀️🏋🏼"
    static let appName = "🏋🏼SporTrack!"
    
    //MARK: - Segue names
    struct Segues{
        static let registerSegue = "UserRegisterDone"
        static let logInSegue = "UserLogInDone"
        static let skipSegue = "UserAleadyLoggedIn"
        static let logToDateSegue = "dateSelected"
        static let workoutMenuToTimerSegue = "workoutTypeSelected"
    }
    
    //MARK: - Reuse IDs
    static let exerciseMenuCell = "ExerciseMenuCollectionViewCell"
    
    //MARK: - SignUp Window
    struct SignUp {
        static let insufficientData = "Please Fill In All Requested Details."
    }
    
    //MARK: - DB References
    struct FStore {
        static let UserCollection = "UserProfiles"
        static let ExerciseCollection = "ExercisesLogs"
        static let EnduranceCollection = "EnduranceLogs"
        static let WeightCollection = "WeightsLogs"
    }
    
    //MARK: - Endurance Exercises
    struct Endurance {
        static let distanceLabel =  "🗺 Distance:   "
        static let timeLabel =      "⏱ Time:        "
        static let paceLabel =      "👟 Pace:        "
        static let StartButton = "Start Tracking"
        static let StopButton = "Stop Tracking"
        static let types = ["Walk","Run","Cycle"]
    }
    
    //MARK: - Exercises base data
    static let baseRoundNumber = 3
    static let baseReturnNumber = 15
    
    static let workoutMenuItems : [Workout] = [
        Exercise(title: "Full Body", imageName: "Exe_FullBody", laps: baseRoundNumber, returns: baseReturnNumber),
        Exercise(title: "Core Strength", imageName: "Exe_CoreStrength", laps: baseRoundNumber, returns: baseReturnNumber),
        Exercise(title: "Shoulders & Back", imageName: "Exe_ShouldersBack", laps: baseRoundNumber, returns: baseReturnNumber),
        Exercise(title: "Upper Body", imageName: "Exe_UpperBody", laps: baseRoundNumber, returns: baseReturnNumber),
        Exercise(title: "Lower Body", imageName: "Exe_LowerBody", laps: baseRoundNumber, returns: baseReturnNumber)
    ]
    
}
