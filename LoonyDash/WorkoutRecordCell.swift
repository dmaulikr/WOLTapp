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
            dateCompletedLabel.text = decideDisplayTime()
        }
    }
    
    private func decideDisplayTime() -> String {
        let date = workout.createdAt!
        let timeNow = NSDate()

        
        if (date.minutesAgo() < 1 ) {
            return "\(Int(timeNow.secondsFrom(date))) seconds ago"
        }
        if (date.hoursAgo() < 1 ) {
            return "\(Int(timeNow.minutesFrom(date))) minutes ago"
        }
        if (date.daysAgo() < 1 ) {
            return "\(Int(timeNow.hoursFrom(date))) hours ago"
        }
        if (date.daysAgo() < 1 ) {
            return "\(Int(timeNow.daysFrom(date))) minutes ago"
        }

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd hh:mm"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter.stringFromDate(workout.createdAt!)
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
