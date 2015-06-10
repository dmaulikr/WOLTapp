//
//  Account.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/7/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class Account: NSObject {
  var completedSets: [WorkoutSet] = [] // may change to completed workouts
  var routine: Routine?
  var plannedSets: [WorkoutSet]?
  
  override init() {
    completedSets = []
    plannedSets = [
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 4, weight: 12),
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 2, weight: 13),
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 6, weight: 14),
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 9, weight: 15),
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 2, weight: 16),
      WorkoutSet(exercise: Exercise.dbSquat(), reps: 6, weight: 17)
    ]
  }
}
