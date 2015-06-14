//
//  Workout.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Workout: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var workoutSets: [WorkoutSet]?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    init(title: String) {
        super.init()
        self.title = title
    }
    
    convenience init(dict: NSDictionary) {
        self.init(
            title: dict["title"] as! String
        )
    }
    
    static func parseClassName() -> String {
        return "Workout"
    }
    
    class func workoutA() -> Workout {
        let dict = ["title": "Workout A"]
        return Workout(dict: dict)
    }
    
    class func workoutB() -> Workout {
        let dict = ["title": "Workout B"]
        return Workout(dict: dict)
    }
    
    class func workoutsWithArray(array: [NSDictionary]) -> [Workout] {
        var workouts = [Workout]()
        
        for dictionary in array {
            workouts.append(Workout(dict: dictionary))
        }
        
        return workouts
    }
}
