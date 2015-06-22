//
//  RoutinesViewController.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RoutinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var routines: [Routine]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 158
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        
        refreshData()
    }
    
    func refreshData() {
        DashClient.sharedInstance.fetchRoutines { (routines, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                self.routines = routines
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routines?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("RoutineCell") as! RoutineCell
        cell.routine = self.routines?[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "routineSegue" {
            let cell = sender as! RoutineCell
            let routine = cell.routine
            let bannerImage = cell.bannerImageView.image
            
            let vc = segue.destinationViewController as! RoutineViewController
            vc.routine = routine
            vc.bannerImage = bannerImage
            //      vc.delegate = self
        }
    }
}
