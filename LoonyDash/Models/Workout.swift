//
//  Workout.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Workout: PFObject, PFSubclassing {
    @NSManaged var routine: Routine!
    @NSManaged var title: String
    @NSManaged var daysText: String
    @NSManaged var user: PFUser?
    @NSManaged var workoutId: Int
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    override init() {
        super.init()
    }
    
    init(title: String, daysText: String, workoutId: Int, user: PFUser?) {
        super.init()
        self.title = title
        self.daysText = daysText
        self.workoutId = workoutId
        if user != nil {
            self.user = user!
        }
    }
    
    static func parseClassName() -> String {
        return "Workout"
    }
}
