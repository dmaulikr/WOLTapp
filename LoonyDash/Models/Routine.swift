//
//  Routine.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class Routine: NSObject {
  var title: String
  var descriptionText: String
  var workouts: [Workout]?
  
  init(dict: NSDictionary) {
    title = dict["title"] as! String
    descriptionText = dict["description_text"] as! String
    workouts = Workout.workoutsWithArray(dict["workouts"] as! [NSDictionary])
  }
  
  class func stronglifts() -> Routine {
    let dict = ["title": "Stronglifts 5x5",
      "description_text": "Stronglifts 5×5 is the simplest, most effective workout to get stronger fast. Thousands of people have used the StrongLifts 5×5 workout to gain strength, build muscle and burn fat. The program is easy to follow and only takes three workouts a week of about 45 minutes. Stronglifts 5×5 uses five free weight compound exercises: the Squat, Bench Press, Deadlift, Overhead Press and Barbell Row. You do three of these exercises each workout, three times a week, for about 45 minutes per workout. You Squat every workout, three times a week.",
      "workouts": [["title": "Workout A"], ["title": "Workout B"]]]
    return Routine(dict: dict)
  }
}
