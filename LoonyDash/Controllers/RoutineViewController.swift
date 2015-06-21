//
//  RoutineViewController.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var routine: Routine!
    var workouts: [Workout]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshData()
    }
    
    func refreshData() {
        DashClient.sharedInstance.fetchWorkoutsForRoutine(routine) { (workouts, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                self.workouts = workouts
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = self.workouts?.count ?? 0
        return numberOfRowsInSection + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("RoutineDescriptionCell") as! RoutineDescriptionCell
            cell.routine = self.routine
            
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("WorkoutCell") as! WorkoutCell
            cell.workout = self.workouts?[indexPath.row - 1]
            
            return cell
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "workoutSegue" {
            let cell = sender as! WorkoutCell
            let workout = cell.workout
            
            let vc = segue.destinationViewController as! WorkoutViewController
            vc.workout = workout
            //      vc.delegate = self
        }
    }
    
}
