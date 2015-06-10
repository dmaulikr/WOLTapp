//
//  Workout.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class Workout: NSObject {
  var title: String
  var workoutSets: [WorkoutSet]?
  
  init(dict: NSDictionary) {
    title = dict["title"] as! String
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
