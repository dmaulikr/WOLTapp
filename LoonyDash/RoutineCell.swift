//
//  RoutineCell.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RoutineCell: UITableViewCell {
    
    @IBOutlet weak var routineTitleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    var routine: Routine! {
        didSet {
            routineTitleLabel.text = routine.title
            shortDescriptionLabel.text = routine.shortDescription
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
