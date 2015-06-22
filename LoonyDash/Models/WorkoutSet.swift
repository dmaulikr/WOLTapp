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
    @NSManaged var numSuggestedReps: Int
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
    
    init(workout: Workout, exercise: Exercise, reps: Int, suggestedReps: Int, weight: Float, user: PFUser?) {
        super.init()
        self.workout = workout
        self.exercise = exercise
        self.numReps = reps
        self.numSuggestedReps = suggestedReps
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
        self.numSuggestedReps = set.numSuggestedReps
        self.weight = set.weight
        if user != nil {
            self.user = user!
        }
    }

    func watchDict() -> [String:AnyObject] {
        var dict: [String:AnyObject] = [:]
        dict["exerciseTitle"] = exercise.name
        dict["numReps"] = numReps
        dict["weight"] = weight
        return dict
    }
    
    static func parseClassName() -> String {
        return "WorkoutSet"
    }
}
