//
//  WorkoutSetRecordCell.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/22/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutSetRecordCell: UITableViewCell {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var workoutSet: WorkoutSet!{
        didSet {
            exerciseNameLabel.text = workoutSet.exercise.name
            repsLabel.text = "\(workoutSet.numReps)"
            weightLabel.text = "\(workoutSet.weight)"
        }
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
