//
//  Exercise.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class Exercise: NSObject {
    var name: String
    var tips: [String]
    var videoUrl: String

    init(dict: NSDictionary) {
        name = dict["name"] as! String
        tips = dict["tips"] as! [String]
        videoUrl = dict["video_url"] as! String

    }

    class func dbSquat() -> Exercise {
        let dict = ["name": "Front DB Box Squat with Ankle Extension",
                    "tips": ["Touch butt to the box or bench and explode up onto the toes.", "Touch other butt to the ceiling and go crazy."],
                    "video_url": "https://www.youtube.com/watch?v=UBIIw29-lR4"]
        return Exercise(dict: dict)

    }

}
