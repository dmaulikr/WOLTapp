//
//  WorkoutRecordViewController.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/24/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var workout: Workout! {
        didSet {
            routineLabel?.text = workout.routine.title
            workoutLabel?.text = "\(workout.title)"
            dateLabel?.text = decideDisplayTime()
        }
    }
    var workoutSets: [WorkoutSet]!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var routineLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routineLabel.text = workout.routine.title
        workoutLabel.text = "\(workout.title)"
        dateLabel.text = decideDisplayTime()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        self.navigationItem.title = self.workout.title
        
        refreshData()
    }
    
    func refreshData() {
        DashClient.sharedInstance.fetchWorkoutSetsForWorkout(workout) { (workoutSets, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                self.workoutSets = workoutSets
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutSets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("WorkoutSetCell") as! WorkoutSetCell
        cell.workoutSet = self.workoutSets?[indexPath.row]
        
        return cell
    }
    
    private func decideDisplayTime() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter.stringFromDate(workout.createdAt!)
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
