//
//  SetViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/6/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    var set = WorkoutSet.s1()
    var repsSelection: Int!
    var weightSelection: Float!

    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var numReps: UILabel!
    @IBOutlet weak var weight: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTitle.text = set.exercise.name
        repsSelection = set.numReps
        weightSelection = set.weight
        updateUI()

    }

    func updateUI() {
        numReps.text = "\(repsSelection)"
        weight.text = "\(weightSelection)"
    }



}
