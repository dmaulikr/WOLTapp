//
//  WorkoutCell.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    @IBOutlet weak var workoutTitleLabel: UILabel!
    @IBOutlet weak var workoutDaysLabel: UILabel!
    
    var workout: Workout! {
        didSet {
            workoutTitleLabel.text = workout.title
            workoutDaysLabel.text = workout.daysText
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
