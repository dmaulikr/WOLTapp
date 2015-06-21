//
//  UserProfileViewController.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/16/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var profileContainerController: ProfileContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileContainerController = UIStoryboard.profileContainerViewController()
        
        self.profileContainerController.view.frame = self.view.bounds
        self.addChildViewController(self.profileContainerController)
        self.view.addSubview(self.profileContainerController.view)
        self.profileContainerController.didMoveToParentViewController(self)
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
