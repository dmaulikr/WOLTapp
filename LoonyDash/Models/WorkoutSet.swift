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
    @NSManaged var user: PFUser?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    override init() {
        super.init()
    }
    
    init(workout: Workout, exercise: Exercise, reps: Int, weight: Float, user: PFUser?) {
        super.init()
        self.workout = workout
        self.exercise = exercise
        self.numReps = reps
        self.weight = weight
        if user != nil {
            self.user = user!
        }
    }
    
    init(set: WorkoutSet) {
        super.init()
        self.workout = set.workout
        self.exercise = set.exercise
        self.numReps = set.numReps
        self.weight = set.weight
        if user != nil {
            self.user = user!
        }
    }
    
    static func parseClassName() -> String {
        return "WorkoutSet"
    }
}
