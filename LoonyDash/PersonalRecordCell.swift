//
//  PersonalRecordCell.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/22/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class PersonalRecordCell: UITableViewCell {

//    @IBOutlet weak var exerciseNameLabel: UILabel!
//    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var personalRecord: PersonalRecord! {
        didSet {
            exerciseNameLabel.text = personalRecord.exercise.name
            weightLabel.text = String(format: "%.0f", personalRecord.max_weight)
        }
    }
    
    override func awakeFromNib() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
