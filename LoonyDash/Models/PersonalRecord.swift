//
//  WorkoutSet.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class PersonalRecord: PFObject, PFSubclassing {
    @NSManaged var exercise: Exercise!
    @NSManaged var record: Float
    @NSManaged var user: PFUser!
    
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
    
    init(exercise: Exercise, record: Float, user: PFUser) {
        super.init()
        self.exercise = exercise
        self.record = record
        self.user = user
    }
    
    init(r: PersonalRecord) {
        super.init()
        self.exercise = r.exercise
        self.record = r.record
        self.user = r.user
    }
    
    static func parseClassName() -> String {
        return "PersonalRecord"
    }
}
