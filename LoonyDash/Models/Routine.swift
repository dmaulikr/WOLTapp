//
//  Routine.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Routine: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var descriptionText: String
    @NSManaged var shortDescription: String
    @NSManaged var bannerImageUrl: String
    
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
    
    init(title: String, descriptionText: String, shortDescription: String, bannerImageUrl: String) {
        super.init()
        self.title = title
        self.descriptionText = descriptionText
        self.shortDescription = shortDescription
        self.bannerImageUrl = bannerImageUrl
    }
    
    convenience init(dict: NSDictionary) {
        self.init(
            title: dict["title"] as! String,
            descriptionText: dict["description_text"] as! String,
            shortDescription: dict["short_description"] as! String,
            bannerImageUrl: dict["banner_image_url"] as! String
        )
    }
    
    static func parseClassName() -> String {
        return "Routine"
    }
}
