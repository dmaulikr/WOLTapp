//
//  Exercise.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Exercise: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var tips: [String]
    @NSManaged var videoUrl: String
    
    init(name: String, tips: [String], videoUrl: String) {
        super.init()
        self.name = name
        self.tips = tips
        self.videoUrl = videoUrl
    }
    
    convenience init(dict: NSDictionary) {
        self.init(
            name: dict["name"] as! String,
            tips: dict["tips"] as! [String],
            videoUrl: dict["video_url"] as! String
        )
    }
    
    static func parseClassName() -> String {
        return "Exercise"
    }
    
    class func dbSquat() -> Exercise {
        let dict = ["name": "Front DB Box Squat with Ankle Extension",
            "tips": ["Touch butt to the box or bench and explode up onto the toes.", "Touch other butt to the ceiling and go crazy."],
            "video_url": "https://www.youtube.com/watch?v=UBIIw29-lR4"]
        return Exercise(dict: dict)
        
    }
    
}
