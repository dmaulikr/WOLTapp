//
//  WorkoutSetCell.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutSetCell: UITableViewCell {
  
  @IBOutlet weak var exerciseNameLabel: UILabel!
  @IBOutlet weak var numSetsLabel: UILabel!
  @IBOutlet weak var numRepsLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  
  var workoutSet: WorkoutSet! {
    didSet {
      exerciseNameLabel.text = workoutSet.exercise.name
      numRepsLabel.text = workoutSet.numReps.description
      weightLabel.text = workoutSet.weight.description
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
