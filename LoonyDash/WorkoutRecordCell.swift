//
//  WorkoutRecordCell.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/24/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutRecordCell: UITableViewCell {

    
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var routineLabel: UILabel!
    @IBOutlet weak var dateCompletedLabel: UILabel!
    
    
    var workout: Workout! {
        didSet {
            routineLabel.text = workout.routine.title
            workoutLabel.text = "\(workout.title)"
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd hh:mm"
            dateFormatter.timeZone = NSTimeZone.localTimeZone()
            dateCompletedLabel.text = dateFormatter.stringFromDate(workout.createdAt!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
