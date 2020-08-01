//
//  FirebaseFunctions.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import Foundation
import FirebaseFirestoreSwift
import Firebase

class FirebaseFunctions {
    
    private static let db = Firestore.firestore()
    
    public static func getDbRef() -> Firestore {
        return db
    }
    //MARK: - Exercise Days List
    public static func getExerciseDays(callBack: @escaping (_ daysArray:[Date])->Void) {
        let exercisesRef = db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid)
        var daysArray:[String]!
        var timestamps = [Date]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        exercisesRef.getDocument { (documentSnapshot, error) in
            if error == nil {
                if documentSnapshot != nil {
                    daysArray = documentSnapshot!.get(K.FStore.datesArray) as? [String]
                    for day in daysArray{
                        timestamps.append(dateFormatter.date(from:day)!)
                    }
                    callBack(timestamps)
                }
            }
        }
    }
    
    //MARK: - Exercises for specific day
    public static func getExercise(day:String, callBack: @escaping (_ exerciseEntries:[ExerciseToSave])->Void) {
        let exercisesRef = db.collection(K.FStore.ExerciseCollection).document(Auth.auth().currentUser!.uid).collection(day)
        exercisesRef.getDocuments { (documentSnapshot, error) in
            if error == nil {
                let exercises = documentSnapshot?.documents.compactMap({ (document) -> ExerciseToSave? in
                    var x: ExerciseToSave? = nil
                    do {
                        x = try document.data(as: ExerciseToSave.self)
                    }catch{
                        
                    }
                    return x
                })
                callBack(exercises!)
            }
        }
    }
    
    //MARK: - Endurance Days List
    public static func getEnduranceDays(callBack: @escaping (_ daysArray:[Date])->Void) {
        let enduranceRef = db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid)
        var daysArray:[String]!
        var timestamps = [Date]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        enduranceRef.getDocument { (documentSnapshot, error) in
            if error == nil {
                if documentSnapshot != nil {
                    daysArray = documentSnapshot!.get(K.FStore.datesArray) as? [String]
                    for day in daysArray{
                        timestamps.append(dateFormatter.date(from:day)!)
                    }
                    callBack(timestamps)
                }
            }
        }
    }
    
    //MARK: - Endurance for specific day
    public static func getEndurance(day:String, callBack: @escaping (_ enduranceEntries:[Endurance])->Void) {
        let enduranceRef = db.collection(K.FStore.EnduranceCollection).document(Auth.auth().currentUser!.uid).collection(day)
        enduranceRef.getDocuments { (documentSnapshot, error) in
            if error == nil {
                let endurances = documentSnapshot?.documents.compactMap({ (document) -> Endurance? in
                    var x: Endurance? = nil
                    do {
                        x = try document.data(as: Endurance.self)
                    }catch{
                        
                    }
                    return x
                })
                callBack(endurances!)
            }
        }
    }
    
    //MARK: - User info
    public static func getUserInfo(callBack: @escaping (_ user: User) -> Void ) {
        //get user profile by his\her userUID and return its' dictionary in a call back when completed
        let usersRef = db.collection(K.FStore.UserCollection).document(Auth.auth().currentUser!.uid)
        var user :User!
        
        usersRef.getDocument { (documentSnapshot, error) in
            if error == nil {
                if documentSnapshot != nil && documentSnapshot!.exists {
                    do{
                        try user = documentSnapshot!.data(as: User.self)
                        callBack(user)
                    } catch {
                        
                    }
                }
            }
        }
    }
}
