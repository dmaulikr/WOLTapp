//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    let embedSwipable = "embedSwipable"

    var currAccount: Account!
    var repsSelection: Int!
    var weightSelection: Float!
    var setIndex = 0
    var set: WorkoutSet  {
        return self.currAccount.plannedSets![setIndex]
    }
    var exercise: Exercise {
        return set.exercise
    }

    var embededPVVC: PageViewViewController!


    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var containerView: UIView!

    // reps and weight, pr, tips, video

    override func viewDidLoad() {
        updateTitle()
        super.viewDidLoad()
        let oldFrame = containerView.frame
        containerView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height - 30)

    }

    func updateTitle() {
        exerciseTitle.text = exercise.name
    }



    @IBAction func onCompleted() {
        currAccount.completedSets.append(currAccount.plannedSets![setIndex])
        if setIndex + 1 < currAccount.plannedSets!.count {
            setIndex += 1
            updateTitle()
            embededPVVC.showNewSet(set)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case embedSwipable:
            let destVC = segue.destinationViewController as! PageViewViewController
            embededPVVC = destVC
            destVC.set = set

        default:
            break
        }
    }
    
}
