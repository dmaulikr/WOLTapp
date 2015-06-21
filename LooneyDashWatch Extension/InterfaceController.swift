//
//  InterfaceController.swift
//  LooneyDashWatch Extension
//
//  Created by Michael Lipman on 6/15/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var session: WCSession!

    @IBOutlet var exerciseName: WKInterfaceLabel!

    @IBOutlet var repsPicker: WKInterfacePicker!
    @IBOutlet var weightPicker: WKInterfacePicker!
    var repsChoice = 0 // index of WKPickerItems list
    var weightsChoice = 0 // index of WKPickerItems list

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()

        var reps: [WKPickerItem] = []
        for i in 0...100 {
            let item = WKPickerItem()
            item.title = "\(i)"
            reps.append(item)
        }
        repsPicker.setItems(reps)

        var weights: [WKPickerItem] = []
        var i: Int
        for i = 0; i<=1000; i+=5 {
            let item = WKPickerItem()
            item.title = "\(i)"
            weights.append(item)
        }
        weightPicker.setItems(weights)
    }

    @IBAction func repsAction(value: Int) {
        repsChoice = value
    }
    
    @IBAction func weightsAction(value: Int) {
        weightsChoice = value
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.updateUIWithWatchDict(message)
            replyHandler([:])
        }
    }

    func updateUIWithWatchDict(dict: [String:AnyObject]) {
        let titleStr = dict["exerciseTitle"] as! String
        self.exerciseName.setAttributedText(NSAttributedString(string: titleStr))
        self.changeRepsPicker(dict["numReps"] as! Int)
        self.changeWeightPicker(dict["weight"] as! Int)
    }


    func changeRepsPicker(repsValue: Int) {
        repsChoice = repsValue
        repsPicker.setSelectedItemIndex(repsChoice)
    }

    func changeWeightPicker(weightValue: Int) {
        weightsChoice = weightValue / 5
        weightPicker.setSelectedItemIndex(weightsChoice)
    }


    @IBAction func myButton() {
        let numReps = repsChoice
        let weight = Float(5*weightsChoice)
        let dict = ["numReps": numReps, "weight": weight] as [String:AnyObject]
        if session.reachable {
            session.sendMessage(dict, replyHandler: { (replyDict: [String:AnyObject]) -> Void in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.updateUIWithWatchDict(replyDict)
                }
            }, errorHandler: { (err: NSError) -> Void in
                NSLog("thur was an error")
            })
        } else {
            NSLog("not reachable")
        }
        return


    }
}

// todo: communicate via transfer user info, not messages, ie:
// when you complete a set, it tries to send it,
// if phone is reachable, it send a message with this and all outstanding transfers as completed sets
// otherwise, it sends a user info dict as a completed set


















