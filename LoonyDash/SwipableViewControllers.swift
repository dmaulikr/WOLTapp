//
//  SwipableViewControllers.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/14/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RepsAndWeightVC: UIViewController {
    var set: WorkoutSet {
        return (self.parentViewController as! PageViewViewController).set
    }
    @IBOutlet weak var numWeightOutlet: UILabel!

    @IBOutlet weak var numRepsOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        numRepsOutlet.text = "\(set.numReps)"
        numWeightOutlet.text = "\(set.weight)"
    }

    func updateUI() {
        numRepsOutlet.text = "\(set.numReps)"
        numWeightOutlet.text = "\(set.weight)"
    }
}



class PersonalBestVC: UIViewController {

}


class TipsVC: UIViewController {

}


class VideoVC: UIViewController {
    
}
