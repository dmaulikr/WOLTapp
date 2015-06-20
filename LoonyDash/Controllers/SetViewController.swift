//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import WatchConnectivity

class SetViewController: UIViewController, WCSessionDelegate {
    let embedSwipable = "embedSwipable"

    var repsSelection: Int!
    var weightSelection: Float!
    var setIndex = 0
    var workoutSets: [WorkoutSet]!
    var workout: Workout!
    var completedSets: [WorkoutSet] = []
    
    var set: WorkoutSet {
        return self.workoutSets[setIndex]
    }
    var exercise: Exercise {
        return set.exercise
    }

    var embeddedPVVC: PageViewViewController!


    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var containerView: UIView!

    // reps and weight, pr, tips, video

    override func viewDidLoad() {
        updateTitle()
        super.viewDidLoad()
        let oldFrame = containerView.frame
        containerView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height - 30)
        if (WCSession.isSupported()) {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }

    }

    func updateTitle() {
        exerciseTitle.text = exercise.name
    }

    @IBAction func onCompleted() {
        // make new set with user inputed reps and weights
        let completedSet = WorkoutSet(set: self.workoutSets![setIndex])
        completedSet.user = PFUser.currentUser()
        completedSets.append(completedSet)
        if setIndex + 1 < self.workoutSets!.count {
            setIndex += 1
            updateTitle()
            embeddedPVVC.showNewSet(set)
        } else {
            DashClient.sharedInstance.completeWorkout(workout, completedSets: completedSets, completion: { (success: Bool, err: NSError?) -> Void in
                if let _ = err {
                    NSLog("error")
                } else {
                    self.completedSets = []
                    self.navigationController?.popViewControllerAnimated(true)

                }
                // stop spinner (happens second)
            })
            // show spinner (happens first b/c workout.complete returns immediately
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case embedSwipable:
            let destVC = segue.destinationViewController as! PageViewViewController
            embeddedPVVC = destVC
            destVC.set = set

        default:
            break
        }
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let me = message["abc"] as! String
        NSLog("msg of abc: \(me)")
        NSLog("heree")
    }
    
}
