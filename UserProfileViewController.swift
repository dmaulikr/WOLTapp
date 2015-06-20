//
//  UserProfileViewController.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/16/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        DashClient.sharedInstance.fetchWorkoutSetsForUser { (workouts: [WorkoutSet]!, error: NSError!) -> Void in
            print(workouts)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Profile"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
