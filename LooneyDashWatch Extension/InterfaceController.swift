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

    @IBOutlet var myLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WCSession.defaultSession().delegate = self
        WCSession.defaultSession().activateSession()
        // Configure interface objects here.
    }


    @IBAction func myButton() {
        NSLog("my button pressed")

        //let myDict = ["msg":"hellothere"]
        let session = WCSession.defaultSession()
        var olds = ""
        var str = ""
        if session.reachable {
            NSLog("is rechable")
            for a in session.outstandingUserInfoTransfers {
                olds += "O"
                str += "P"
                a.cancel()
            }
            session.sendMessage(["olds":olds], replyHandler: { (mee: [String:AnyObject]) -> Void in
                let msgg = "msgg"
                NSLog("reply value is \(mee[msgg])")
                }, errorHandler: { (err: NSError) -> Void in
                    NSLog("errrrrrr")
            })
            str = "is reachable"
        } else {
            NSLog("is not reachable")
            let randInt = random()%1000
            str = "J\(randInt)"
            WCSession.defaultSession().transferUserInfo(["curr":"C"])
            str = "is not reachable"
        }
        str = "wahhhh"
        /*if WCSession.defaultSession().reachable {
            WCSession.defaultSession().sendMessage(myDict, replyHandler: { (mee: [String:AnyObject]) -> Void in
                let msgg = "msgg"
                NSLog("it is \(mee[msgg])")
            }, errorHandler: { (err: NSError) -> Void in
                NSLog("errrrr")
            })
            NSLog("tapped rrbutton")
            //
        } else {
            NSLog("not reachable")
        }
        let a = WCSession.defaultSession().outstandingUserInfoTransfers

        let str = "M"

        NSLog("\(a.count) transfers outstanding B")
        */
        let attStr = NSAttributedString(string: str)
        //myLabel.setAttributedText(attStr)

    }
}


// when you complete a set, it tries to send it,
// if phone is reachable, it send a message with this and all outstanding transfers as completed sets
// otherwise, it sends a user info dict as a completed set


















