//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import WatchConnectivity

class SetViewController: UIViewController, WCSessionDelegate, WatchMessages {
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
    var session: WCSession!


    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var containerView: UIView!

    // reps and weight, pr, tips, video

    override func viewDidLoad() {
        updateTitle()
        super.viewDidLoad()
        let oldFrame = containerView.frame
        containerView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height - 30)

        (UIApplication.sharedApplication().delegate as! AppDelegate).watchMessageDelegate = self
        session = WCSession.defaultSession()
        if workoutSets.count > 0 && session.reachable {
            sendSetToWatch(0)
        }
    }

    func sendSetToWatch(indexOfSet: Int) {
        session.sendMessage(workoutSets[indexOfSet].watchDict(),
            replyHandler: { (replyDict: [String:AnyObject]) -> Void in
                NSLog("message recieved by watch, reply handler")
            }) { (err: NSError) -> Void in
                NSLog("error sending message")
        }
    }

    func updateTitle() {
        exerciseTitle.text = exercise.name
    }

    @IBAction func onCompleted() {

        recordCompletionOfSet(set.numReps, numSuggestedReps: set.numSuggestedReps, weight: set.weight) // query mutable vars backing labels
        // make new set with user inputed reps and weights
        showNextSetOnPhoneOrFinish(alsoSendSetToWatch: true)

    }

    func showNextSetOnPhoneOrFinish(alsoSendSetToWatch send: Bool) {
        if setIndex + 1 < self.workoutSets!.count {
            setIndex += 1
            updateTitle()
            embeddedPVVC.showNewSet(set)
            if send {
                sendSetToWatch(setIndex)
            }
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
            // send watch to home / waiting screen
        }
    }

    func recordCompletionOfSet(numReps: Int, numSuggestedReps: Int, weight: Float) {
        let completedSet = WorkoutSet(workout: workout, exercise: exercise, reps: numReps, suggestedReps: numSuggestedReps, weight: weight, user: PFUser.currentUser())
        completedSets.append(completedSet)
    }

    // watch sending in a numReps and weight that was completed
    // expecting back a watchDict to show
    func receiveMessage(dict: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            self.recordCompletionOfSet(dict["numReps"] as! Int, numSuggestedReps: dict["numSuggestedReps"] as! Int, weight: dict["weight"] as! Float)
            self.showNextSetOnPhoneOrFinish(alsoSendSetToWatch: false)
            replyHandler(self.set.watchDict())

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
    


    
}
