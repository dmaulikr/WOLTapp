//
//  UIStoryboard.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/21/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import Foundation

extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    class func setsStoryboard() -> UIStoryboard { return UIStoryboard(name: "Sets", bundle: NSBundle.mainBundle()) }
    class func profileStoryboard() -> UIStoryboard { return UIStoryboard(name: "Profile", bundle: NSBundle.mainBundle()) }
    
    
    class func loginViewController() -> LoginViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }

    class func userProfileViewController() -> UserProfileViewController? {
        return profileStoryboard().instantiateViewControllerWithIdentifier("UserProfileViewController") as? UserProfileViewController
    }

    class func personalRecordsViewController() -> PersonalRecordsViewController? {
        return profileStoryboard().instantiateViewControllerWithIdentifier("PersonalRecordsViewController") as? PersonalRecordsViewController
    }

    class func setsCompletedViewController() -> SetsCompletedViewController? {
        return profileStoryboard().instantiateViewControllerWithIdentifier("SetsCompletedViewController") as? SetsCompletedViewController
    }


    
    
//    class func repsAndWeightViewController() -> RepsAndWeightVC {
//        return setsStoryboard().instantiateViewControllerWithIdentifier("RepsAndWeightVC") as! RepsAndWeightVC
//    }
//
//    class func videoViewController() -> VideoVC? {
//        return setsStoryboard().instantiateViewControllerWithIdentifier("VideoVC") as? VideoVC
//    }

    
}