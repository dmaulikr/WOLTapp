//
//  WorkoutSet.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class WorkoutSet: PFObject, PFSubclassing {
    @NSManaged var workout: Workout!
    @NSManaged var exercise: Exercise
    @NSManaged var numReps: Int
    @NSManaged var weight: Float // in pounds
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    init(workout: Workout, exercise: Exercise, reps: Int, weight: Float) {
        super.init()
        self.workout = workout
        self.exercise = exercise
        self.numReps = reps
        self.weight = weight
    }
    
    convenience init(dict: NSDictionary) {
        self.init(
            workout: dict["workout"] as! Workout,
            exercise: dict["exercise"] as! Exercise,
            reps: dict["num_reps"] as! Int,
            weight: dict["weight"] as! Float
        )
    }
    
    static func parseClassName() -> String {
        return "WorkoutSet"
    }
    
    class func s1() -> WorkoutSet {
        let dict = ["exercise": Exercise.dbSquat(),
            "num_reps": 8,
            "weight": 35] as NSDictionary
        return WorkoutSet(dict: dict)
    }
}
