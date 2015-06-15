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
    
    var tmpSet: WorkoutSet?
    
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
    
    // nothing for now
    
    func fetchRoutines(completion: ([Routine]?, NSError?) -> Void) {
        var query = PFQuery(className: "Routine")
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
    
    func fetchWorkoutsForRoutine(routine: Routine!, completion: ([Workout]!, NSError!) -> Void) {
        var query = PFQuery(className: "Workout")
        query.includeKey("routine")
        query.whereKey("routine", equalTo: routine)
        
        var workouts: [Workout]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                workouts = objects as! [Workout]
                for w in workouts {
                    w.routine = w["routine"] as! Routine!
                }
                completion(workouts, error)
            }
        }
    }
    
    //  Return pfobjects casted as exercises for a given workout
    func fetchExercisesForWorkout(workout: Workout!, completion: ([WorkoutSet]!, NSError!) -> Void) {
        var query = PFQuery(className:"WorkoutSet")
        query.includeKey("workout")
        query.whereKey("workout", equalTo: workout)
        
        var sets: [WorkoutSet]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                sets = objects as! [WorkoutSet]
                for s in sets {
                    s.workout = s["workout"] as! Workout!
                    s.exercise = s["exercise"] as! Exercise!
                }
                completion(sets, error)
            }
        }
    }
    
    // Return the sets for the given exercise for the logged-in user
    func fetchSetsForExercise(exercise:Exercise, completion: ([WorkoutSet]!, NSError!) -> Void) {
        // TODO: SHOULD BE USING CURRENT USER
        
        var query = PFQuery(className:"Set")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.whereKey("exercise", equalTo: exercise)
        query.orderByDescending ("weight")
        
        var sets: [WorkoutSet]!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            sets = objects as! [WorkoutSet]
            for s in sets {
                s.workout = s["workout"] as! Workout!
                s.exercise = s["exercise"] as! Exercise!
            }
            completion(sets, error)
        }
    }
    
    func completeSet(#exercise: Exercise!, workout: Workout!, weight: Float!, reps: Int!, completion: (WorkoutSet?, NSError!) -> Void) {
        var set = WorkoutSet(workout: workout, exercise: exercise, reps: reps, weight: weight)
        
        // assigns to set
        self.tmpSet = set
        
        set.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                completion(self.tmpSet!, nil)
            } else {
                // There was a problem, check error.description
                completion(nil, error)
            }
        }
        
    }
    
}