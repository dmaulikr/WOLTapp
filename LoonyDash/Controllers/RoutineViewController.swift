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
    var bannerImage: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
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
            cell.bannerImageView.image = self.bannerImage
            
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
            let vc = segue.destinationViewController as! WorkoutViewController
//            vc.workout = cell.workout
            DashClient.sharedInstance.fetchLastWorkoutOfWorkoutIDForUser(cell.workout) { (lastWorkout) -> Void in
                if lastWorkout != nil {
                    vc.workout = lastWorkout
                } else {
                    vc.workout = cell.workout
                }
            }
        }
    }
    
}
