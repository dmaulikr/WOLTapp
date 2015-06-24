//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import WatchConnectivity

class SetViewController: UIViewController, WCSessionDelegate, WatchMessages, RepsAndWeightDelegate {
    let embedSwipable = "embedSwipable"

    var repsSelection: Int!
    var weightSelection: Float!
    var setIndex = 0
    var workoutSets: [WorkoutSet]!
    var workout: Workout!
    var completedSets: [WorkoutSet] = []
    var child: PageViewViewController?
    var isCurrentlySaving: Bool!

    var set: WorkoutSet {
        return self.workoutSets[setIndex]
    }
    var exercise: Exercise {
        return set.exercise
    }

    var embeddedPVVC: PageViewViewController!
    var session: WCSession!


    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var nextExerciseTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currentSetIndexLabel: UILabel!
    @IBOutlet weak var totalSetCountLabel: UILabel!

    // reps and weight, pr, tips, video

    override func viewDidLoad() {
        isCurrentlySaving = false
        updateLabels()
        repsSelection = set.numReps
        weightSelection = set.weight
        super.viewDidLoad()
        
        let oldFrame = containerView.frame
        containerView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height - 30)

        (UIApplication.sharedApplication().delegate as! AppDelegate).watchMessageDelegate = self
        session = WCSession.defaultSession()
        if workoutSets.count > 0 && session.reachable {
            sendSetToWatch(0)
        }
        embeddedPVVC.updateRepsWeightUI()
    }


    func repsUp() {
        repsSelection = repsSelection + 1
    }

    func repsDown() {
        repsSelection = max(repsSelection - 1, 0)

    }

    func weightUp() {
        weightSelection = weightSelection + 5
    }

    func weightDown() {
        weightSelection = max(weightSelection - 5, 0)
    }

    func sendSetToWatch(indexOfSet: Int) {
        session.sendMessage(workoutSets[indexOfSet].watchDict(),
            replyHandler: { (replyDict: [String:AnyObject]) -> Void in
                NSLog("message recieved by watch, reply handler")
            }) { (err: NSError) -> Void in
                NSLog("error sending message")
        }
    }

    func updateLabels() {
        totalSetCountLabel.text = "\(self.workoutSets!.count)"
        exerciseTitle.text = exercise.name
        currentSetIndexLabel.text = "\(setIndex + 1)"
        if setIndex + 1 < self.workoutSets!.count {
            nextExerciseTitle.text = "Up next: \(self.workoutSets![setIndex + 1].exercise.name)"
        } else {
            nextExerciseTitle.text = "Last set!"
        }
    }

    @IBAction func onCompleted() {
        recordCompletionOfSet(repsSelection, numSuggestedReps: set.numSuggestedReps, weight: weightSelection, sequence: setIndex + 1)
        showNextSetOnPhoneOrFinish(alsoSendSetToWatch: true)
    }

    func showNextSetOnPhoneOrFinish(alsoSendSetToWatch send: Bool) {
        if setIndex + 1 < self.workoutSets!.count {
            setIndex += 1
            updateLabels()
            repsSelection = set.numReps
            weightSelection = set.weight
            embeddedPVVC.showNewSet(set)
            if send {
                sendSetToWatch(setIndex)
            }
        } else {
            if isCurrentlySaving != true {
                isCurrentlySaving = true
                DashClient.sharedInstance.completeWorkout(workout, completedSets: completedSets, completion: { (success: Bool, err: NSError?) -> Void in
                    if let _ = err {
                        NSLog("error")
                    } else {
                        self.completedSets = []
                        self.navigationController?.popViewControllerAnimated(true)
                        self.session.sendMessage(["finished":true], replyHandler: nil, errorHandler: nil)
                    }
                    // stop spinner (happens second)
                })
                // show spinner (happens first b/c workout.complete returns immediately
                // send watch to home / waiting screen
            }
        }
    }

    func recordCompletionOfSet(numReps: Int, numSuggestedReps: Int, weight: Float, sequence: Int) {
        let completedSet = WorkoutSet(workout: workout, exercise: exercise, reps: numReps, suggestedReps: numSuggestedReps, weight: weight, sequence: sequence, user: PFUser.currentUser())
        completedSets.append(completedSet)
    }

    // watch sending in a numReps and weight that was completed
    // expecting back a watchDict to show
    func receiveMessage(dict: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            self.recordCompletionOfSet(dict["numReps"] as! Int, numSuggestedReps: dict["numSuggestedReps"] as! Int, weight: dict["weight"] as! Float, sequence: self.setIndex + 1)
            self.showNextSetOnPhoneOrFinish(alsoSendSetToWatch: false)
            replyHandler(self.set.watchDict())

        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case embedSwipable:
            let destVC = segue.destinationViewController as! PageViewViewController
            embeddedPVVC = destVC
            destVC.parent = self
            destVC.set = set

        default:
            break
        }
    }
    


    
}
