//
//  InterfaceController.swift
//  LooneyDashWatch Extension
//
//  Created by Michael Lipman on 6/15/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var myLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        NSLog("awoked")
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("will activate")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NSLog("did deactivate")
    }


    @IBAction func myButton() {
        NSLog("tapped button")
    }
}
