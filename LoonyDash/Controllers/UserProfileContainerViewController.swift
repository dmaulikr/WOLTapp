//
//  UserProfileContainerViewController.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/22/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class UserProfileContainerViewController: UIViewController {

    var userProfileController: UserProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userProfileController = UIStoryboard.userProfileViewController()

        self.userProfileController.view.frame = self.view.bounds
        self.addChildViewController(self.userProfileController)
        self.view.addSubview(self.userProfileController.view)
        self.userProfileController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
