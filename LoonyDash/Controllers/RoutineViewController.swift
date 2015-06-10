//
//  RoutineViewController.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var currAccount: Account!
  var routine: Routine!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRowsInSection = self.routine.workouts?.count ?? 0
    return numberOfRowsInSection + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("RoutineDescriptionCell") as! RoutineDescriptionCell
      cell.routine = self.routine
      
      return cell
    } else {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("WorkoutCell") as! WorkoutCell
      cell.workout = self.routine.workouts?[indexPath.row - 1]
      
      return cell
    }
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "workoutSegue" {
      let cell = sender as! WorkoutCell
      let workout = cell.workout
      workout.workoutSets = currAccount.plannedSets
      
      var vc = segue.destinationViewController as! WorkoutViewController
      vc.currAccount = self.currAccount
      vc.workout = workout
      //      vc.delegate = self
    }
  }
  
}
