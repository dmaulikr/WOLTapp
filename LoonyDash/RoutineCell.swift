//
//  RoutineCell.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RoutineCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var routineTitleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    var routine: Routine! {
        didSet {
            routineTitleLabel.text = routine.title
            shortDescriptionLabel.text = routine.shortDescription
            bannerImageView.setImageWithURL(NSURL(string: routine.bannerImageUrl))
            bannerImageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: routine.bannerImageUrl)!), placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                self.bannerImageView.alpha = 0.0
                self.bannerImageView.image = image
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bannerImageView.alpha = 1.0
                })
            }, failure: nil)
        }
    }
    
    override func awakeFromNib() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        bannerImageView.image = nil
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
