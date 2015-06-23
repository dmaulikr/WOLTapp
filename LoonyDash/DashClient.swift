//
//  DashAPIClient.swift
//  DashWorkout
//
//  Created by ming yeow ng on 6/6/15.
//  Copyright (c) 2015 Dash. All rights reserved.
//

import Foundation
import Parse

class DashClient {
    
    class var sharedInstance: DashClient {
        struct Static {
            static var token: dispatch_once_t = 0
            static var instance: DashClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = DashClient()
        }
        return Static.instance!
    }
    
    func fetchRoutines(completion: ([Routine]?, NSError?) -> Void) {
        let query = PFQuery(className: "Routine")
        var routines: [Routine]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                routines = objects as! [Routine]
                completion(routines, error)
            }
        }
    }
    
    func fetchWorkoutsForRoutine(routine: Routine!, completion: ([Workout]!, NSError?) -> Void) {
        let query = PFQuery(className: "Workout")
        query.includeKey("routine")
        query.whereKey("routine", equalTo: routine)
        query.whereKeyDoesNotExist("user")
        query.whereKeyExists("sequence")
        query.orderByAscending("sequence")
        
        var workouts: [Workout]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                workouts = objects as! [Workout]
                completion(workouts, error)
            }
        }
    }
    
    func fetchWorkoutSetsForWorkout(workout: Workout!, completion: ([WorkoutSet]!, NSError?) -> Void) {
        let query = PFQuery(className: "WorkoutSet")
        query.includeKey("workout")
        query.includeKey("exercise")
        query.whereKey("workout", equalTo: workout)
        query.orderByAscending("sequence")
        
        var workoutSets: [WorkoutSet]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                workoutSets = objects as! [WorkoutSet]
                completion(workoutSets, error)
            }
        }
    }

    func fetchWorkoutSetsForUser(completion: ([WorkoutSet]!, NSError?) -> Void) {
        let query = PFQuery(className: "WorkoutSet")
        query.includeKey("workout")
        query.includeKey("exercise")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        var workoutSets: [WorkoutSet]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                workoutSets = objects as! [WorkoutSet]
                completion(workoutSets, error)
            }
        }
    }

    func fetchWorkoutsCompletedForUser(completion: ([Workout]!, NSError?) -> Void) {
        let query = PFQuery(className: "Workout")
        query.includeKey("routine")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        var workouts: [Workout]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                workouts = objects as! [Workout]
                completion(workouts, error)
            }
        }
    }

    func fetchPersonalRecordsForUser(completion: ([PersonalRecord]!, NSError?) -> Void) {
        let query = PFQuery(className: "PersonalRecord")
        query.includeKey("exercise")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        var personalRecords: [PersonalRecord]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                personalRecords = objects as! [PersonalRecord]
                completion(personalRecords, error)
            }
        }
    }

    func fetchLastWorkoutOfWorkoutIDForUser(workout: Workout!, completion: (Workout!) -> Void) {
        let query = PFQuery(className: "Workout")
        query.includeKey("workout")
        query.whereKey("workoutId", equalTo: workout.workoutId)
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        var lastWorkout: Workout!
        let object = query.getFirstObject()
        lastWorkout = object as? Workout
        completion(lastWorkout)
    }

//    // Return the sets for the given exercise for the logged-in user
//    func fetchSetsForExercise(exercise: Exercise, completion: ([WorkoutSet]!, NSError!) -> Void) {
//        // TODO: SHOULD BE USING CURRENT USER
//        
//        var query = PFQuery(className:"Set")
//        query.whereKey("user", equalTo: PFUser.currentUser()!)
//        query.whereKey("exercise", equalTo: exercise)
//        query.orderByDescending ("weight")
//        
//        var sets: [WorkoutSet]!
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]?, error: NSError?) -> Void in
//            sets = objects as! [WorkoutSet]
//            for s in sets {
//                s.workout = s["workout"] as! Workout!
//                s.exercise = s["exercise"] as! Exercise!
//            }
//            completion(sets, error)
//        }
//    }
    
    func completeWorkout(workout: Workout, completedSets: [WorkoutSet], completion: (Bool, NSError?) -> Void) {
        var thingsToSave = [PFObject]()
        let completedWorkout = Workout(title: workout.title, daysText: workout.daysText, workoutId: workout.workoutId, user: PFUser.currentUser()!)
        completedWorkout.routine = workout.routine
        for set in completedSets {
            set.workout = completedWorkout
            thingsToSave.append(set)
        }
        thingsToSave.append(completedWorkout)
        PFObject.saveAllInBackground(thingsToSave, block: completion)
    }
}
