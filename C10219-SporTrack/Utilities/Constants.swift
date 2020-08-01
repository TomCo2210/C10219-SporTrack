//
//  Constants.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 22/07/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//

import UIKit

struct K {
    
    //MARK: - Main App Details
    struct Titles {
        static let AnimationEmojis = "🏋🏻‍♀️🏊🏼🏈🤼‍♂️⚽🤸🏽‍♂️⛹🏿🤺🏐🤾🏼‍♂️🧘🏼‍♂️⚾🏄🏼🏀🚣🏿‍♀️🧗🏽‍♀️🎾🚴🏽🏃🏾🏃🏼‍♀️🏋🏼"
        static let AppName = "🏋🏼SporTrack!"
        static let CategoryScreenTitle = "Categories"
        static let ExercisesScreenTitle = "Exercises"
        static let EnduranceScreenTitle = "Endurance"
        static let LogScreenTitle = "History"
        static let ProfileScreenTitle = "Profile"
    }
    
    //MARK: - Segue names
    struct Segues{
        static let registerSegue = "UserRegisterDone"
        static let logInSegue = "UserLogInDone"
        static let skipSegue = "UserAleadyLoggedIn"
        static let logToDateSegue = "dateSelected"
        static let exerciseMenuToTimerSegue = "exerciseSelected"
        static let exerciseCategoryToExerciseMenuSegue = "exerciseTypeSelected"
    }
    
    //MARK: - Reuse IDs
    static let exerciseCategoryMennuCell = "ExerciseCategoryCollectionViewCell"
    static let exerciseMenuCell = "ExerciseMenuCollectionViewCell"
    static let dayEntryCell = "DayEntryTableViewCell"
    static let enduranceLogTVCell = "EnduranceEntryTableViewCell"
    static let exerciseLogTVCell = "ExerciseEntryTableViewCell"
    
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
        static let datesArray = "dates"
    }
    //MARK: - Endurance Exercises
    struct Profile {
        static let BirthDateLabel =   "🎂 Birth Date:   "
        static let HeightLabel =      "📏 Height:        "
        static let WeightLabel =      "⚖️ Weight:        "
    }
    
    //MARK: - Endurance Exercises
    struct Endurance {
        static let distanceLabel =  "🗺 Distance:   "
        static let timeLabel =      "⏱ Time:        "
        static let paceLabel =      "👟 Pace:        "
        static let StartButton = "Start Tracking"
        static let StopButton = "Stop Tracking"
        static let types = ["🚶🏼","🏃🏽‍♂️","🚴🏾‍♂️"]
    }
    
    struct History{
        static let returnsTitle = "＃ Returns: "
        static let setsTitle = "↺ Sets: "
        static let timeLabel =      "⏱ "
        static let distanceLabel =      "🗺 Distance: "
        static let durationLabel =      "⌛️ Duration: "
    }
    
    //MARK: - Exercises base data
    static let Levels = ["Beginner","Intermediate","Advanced"]
    static let LevelColors = [UIColor.green, UIColor.orange, UIColor.red]
    static let baseSetsNumber = 3
    static let baseReturnNumber = 10
    static let lapCounter = "↺ #"
    static let RestTimeInSeconds = 90
    
    static let ExerciseCategoryMenuItems : [ExerciseCategory] = [
        ExerciseCategory(title: "Abs", imageName: "Exe_Abs", exercises: [Exercise(title: "Sit-Up", imageName: "Sit-Up", description: "Lie flat on your back on the floor with your knees bent and your legs secured under a piece of heavy furniture or bench. Place your hands by your chest. Flexing your abdominals, raise your torso until you are in nearly a sitting position. Retaining tension on the abs, lower your torso to the beginning position. (Note: Maintain full control throughout the movement. Avoid the temptation to rock back and forth.)", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Leg Raise", imageName: "Leg Raise", description: "Lie flat on your back on the floor with your legs straight in front of you. Place your hands at your sides by the floor for support. Flexing your lower abdominals, raise your legs until they are perpendicular to the floor. Retain tension as you lower your legs to the beginning position. (Note: Maintain full control throughout the movement. Avoid the temptation to let your legs drop on the negative portion of the movement.)", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Knee-In", imageName: "Knee-In", description: "Sit on the floor (or on the edge of a chair or exercise bench) with your legs extended in front of you and your hands holding on to the sides for support. Keep your knees together and pull them in toward your chest until you can't go any farther. Keeping the tension on your lower abs, return to the start position and repeat the movement until you've completed your set.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Back", imageName: "Exe_Back", exercises: [Exercise(title: "Wide-Grip Pull-Up", imageName: "Wide-Grip Pull-Up", description: "Because the pull-up range of motion is so long, several light reps make great warm-up moves for the shoulder joints. Since form is so important with these, it may be best to push pull-ups toward the front of your workout to ensure proper shoulder-joint positioning.", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Wide-Grip Seated Cable Row", imageName: "Wide-Grip Seated Cable Row", description: "Like machines, cables are best done toward the end of your workout. Choose a weight that enables you to complete no more than about 12 reps.", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Close-Grip Pull-Down", imageName: "Close-Grip Pull-Down", description: "This exercise can make a good warm-up move for your shoulders, but when used as a mass-building exercise, it's best placed toward the end of your workout for sets of 8-12 reps.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Biceps", imageName: "Exe_Biceps", exercises: [Exercise(title: "Incline Dumbbell Hammer Curl", imageName: "Incline Dumbbell Hammer Curl", description: "You rated these curls #1! The incline bench position increases the stretch on the long head of the biceps muscle and also locks your body against the bench so you can't cheat more weight during reps by rocking backward. An added benefit to hammers is that your wrist and elbow are less vulnerable to strain than during reps of other curls.", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Overhead Cable Curl", imageName: "Overhead Cable Curl", description: "This is a great way to practice your front double biceps pose as you train. You can do both cables at once, or alternate between arms!", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Zottman Curl", imageName: "Zottman Curl", description: "In this movement, you hold a dumbbell in each hand and have a palms-up (supinated) grip on the way up and a palms-down (pronated) grip as you lower the weight, so all of your elbow flexors get hit!", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Chest", imageName: "Exe_Chest", exercises: [Exercise(title: "Seated Machine Chest Press", imageName: "Seated Machine Chest Press", description: "do machine exercises at the end of your workout. For anyone looking to build mass, machines give you a greater chance to pump your pecs with minimal shoulder assistance", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Flat Bench Dumbbell Press", imageName: "Flat Bench Dumbbell Press", description: "Do flat dumbbell presses toward the start of your chest workout for heavy sets in lower rep ranges. We don't typically recommend doing dumbbell presses in addition to the barbell bench press, because both moves are so similar.", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Dips For Chest", imageName: "Dips For Chest", description: "If you're strong, this lower-chest move makes a great finisher; if you're not, you can do it earlier in your session. It makes a great superset pairing with push-ups for a big pump at the end of your workout.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Legs - Thighs", imageName: "Exe_Thighs", exercises: [Exercise(title: "Bulgarian Split Squat", imageName: "Bulgarian Split Squat", description: "Stand lunge-length in front of a bench. Hold a dumbbell in each hand and rest the top of your left foot on the bench behind you. Lower your body until your rear knee nearly touches the floor and your front thigh is parallel to the floor. Single-leg training can yield serious strength gains. ", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Romanian Deadlift", imageName: "Romanian Deadlift", description: "A killer deadlift variation, hold a barbell with a shoulder-width grip and stand with feet hip-width apart. Bend your hips back as far as you can. Allow your knees to bend as needed while you lower the bar along your shins until you feel a stretch in your hamstrings. Keep your lower back in its natural arched position throughout.", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Squat", imageName: "Squat", description: "In a squat rack or cage, grasp the bar as far apart as is comfortable and step under it. Place it on your lower traps, squeeze your shoulder blades together, push your elbows up and nudge the bar out of the rack. Take a step or two back and stand with your feet at shoulder width and your toes turned slightly out. Take a deep breath and bend your hips back, then bend your knees to lower your body as far as you can without losing the arch in your lower back. Push your knees out as you descend. Drive vertically with your hips to come back up, continuing to push your knees out.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Shoulders", imageName: "Exe_Shoulders", exercises: [Exercise(title: "Barbell Overhead Shoulder Press", imageName: "Barbell Overhead Shoulder Press", description: "A barbell overhead shoulder press (aka barbell standing shoulder press) works not just your shoulders, but most of your body. That makes it a terrific core strengthener and mass builder, among other things. To start, put your feet at shoulder-width, and tighten your core as you hold a barbell at your shoulders, palms facing forward. Next, push the bar upward and squeeze your shoulder blades together at the peak. Lower steadily and carefully.", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Seated Dumbbell Shoulder Press", imageName: "Seated Dumbbell Shoulder Press", description: "To perform a seated dumbbell shoulder press, sit on a low-back bench and hold a dumbbell in each hand at the shoulder level, palms facing forward. Keeping your head and spine perfectly straight, lift the dumbbells overhead toward one another, stopping just short of having them touch at the top. Hold the position for a few seconds and then carefully reverse course. Repeat.", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Front Raise", imageName: "Front Raise", description: "To execute, keep your hands at hip height as you hold the weight in front of you. Your feet should be even with your shoulders and your core should be tight. Next, retract your shoulder blades and keep your arms straight as you lift the weight to shoulder level. Breathe steadily and lower the weight carefully. Repeat.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)]),
        ExerciseCategory(title: "Triceps", imageName: "Exe_Triceps", exercises: [Exercise(title: "Diamond Push-ups", imageName: "Diamond Push-ups", description: "Begin the move by positioning the hands on the mat directly under the chest with the fingers spread and the thumbs and forefingers touching, making a diamond shape.Straighten the legs into a plank position (harder) or keep the knees on the floor for an easier version. Make sure the back is flat and the abs are engaged as you bend the elbows, lowering until your chin or chest touches the mat. If you can't go that low, go as low as you can—then work to build enough strength to lower all the way down over time.At the bottom of the movement, your elbows should stay in close to your sides.", difficulty: 0, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Kickbacks", imageName: "Kickbacks", description: "Prop the right foot on a step or platform, resting the right forearm on the thigh to support the back. Hold a weight in the left hand and pull the elbow up to torso level. Keeping the elbow in that position, extend the arm behind you, focusing on contracting the triceps. Lower the forearm down to about 90 degrees and repeat for 1-3 sets of 8-16 reps. Focus on keeping the upper arm stationary against the body throughout the exercise.", difficulty: 1, sets: K.baseSetsNumber, returns: K.baseReturnNumber),Exercise(title: "Rope Pushdown", imageName: "Rope Pushdown", description: "At a cable machine with a rope attachment, hold on to the rope near the knotted ends and begin the exercise with the elbows bent at about 90 degrees, elbows next to the torso. Extend the arms, taking the hands down towards the floor, spreading the rope slightly out on either side as you contract the triceps. Bring the forearms back to start and repeat for 1-3 sets of 8-16 reps.", difficulty: 2, sets: K.baseSetsNumber, returns: K.baseReturnNumber)])
    ]
}
