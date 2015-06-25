//
//  PersonalRecordsViewController.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/21/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class PersonalRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var personalRecords: [PersonalRecord]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "workoutCompleted", object: nil)
        
        refreshData()
    }
    
    func refreshData() {
        DashClient.sharedInstance.fetchPersonalRecordsForUser { (personalRecords: [PersonalRecord]!, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else {
                self.personalRecords = personalRecords
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: Use delegate pattern here instead!
        let parent = self.parentViewController!.parentViewController as! ProfileContainerViewController
        parent.pageControl.currentPage = 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalRecords.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalRecordCell", forIndexPath: indexPath) as! PersonalRecordCell
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalRecordCell") as! PersonalRecordCell
        
        cell.personalRecord = personalRecords[indexPath.row]
        
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
            cell.preservesSuperviewLayoutMargins = false
        }
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
