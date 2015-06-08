//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    var currAccount: Account!
    var repsSelection: Int!
    var weightSelection: Float!
    var setIndex = 0


    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var numReps: UILabel!
    @IBOutlet weak var weight: UILabel!

    override func viewDidLoad() {
        updateIvars()
        super.viewDidLoad()
    }

    func updateIvars() {
        var set = currAccount.plannedSets[setIndex]
        exerciseTitle.text = set.exercise.name
        repsSelection = set.numReps
        weightSelection = set.weight
        updateUI()
    }

    func updateUI() {
        numReps.text = "\(repsSelection)"
        weight.text = "\(weightSelection)"
    }


    @IBAction func onCompleted() {
        currAccount.completedSets.append(currAccount.plannedSets[setIndex])
        if setIndex + 1 < currAccount.plannedSets.count {
            setIndex += 1
            updateIvars()
        }
    }

}
