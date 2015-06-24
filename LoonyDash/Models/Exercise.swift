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
    @NSManaged var tipText: String
    @NSManaged var videoUrl: String
    
    override init() {
        super.init()
    }

    init(name: String, tipText: String, videoUrl: String) {
        super.init()
        self.name = name
        self.tipText = tipText
        self.videoUrl = videoUrl
    }
    
    convenience init(dict: NSDictionary) {
        self.init(
            name: dict["name"] as! String,
            tipText: dict["tip_text"] as! String,
            videoUrl: dict["video_url"] as! String
        )
    }
    
    static func parseClassName() -> String {
        return "Exercise"
    }
}
