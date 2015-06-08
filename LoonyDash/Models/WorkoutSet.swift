//
//  WorkoutSet.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutSet: NSObject {
    var exercise: Exercise
    var numReps: Int
    var weight: Float // in pounds

    init(dict: NSDictionary) {
        exercise = dict["exercise"] as! Exercise
        numReps = dict["num_reps"] as! Int
        weight = dict["weight"] as! Float
    }

    class func s1() -> WorkoutSet {
        let dict = ["exercise": Exercise.dbSquat(),
                    "num_reps": 8,
                    "weight": 35] as NSDictionary
        return WorkoutSet(dict: dict)
    }
}
