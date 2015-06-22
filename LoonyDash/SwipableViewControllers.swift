//
//  SwipableViewControllers.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/14/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class RepsAndWeightVC: UIViewController {
    var set: WorkoutSet {
        return (self.parentViewController as! PageViewViewController).set
    }
    @IBOutlet weak var numWeightOutlet: UILabel!

    @IBOutlet weak var numRepsOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        numRepsOutlet.text = "\(set.numReps)"
        numWeightOutlet.text = "\(set.weight)"
    }

    func updateUI() {
        numRepsOutlet.text = "\(set.numReps)"
        numWeightOutlet.text = "\(set.weight)"
    }
}



class PersonalBestVC: UIViewController {

}


class TipsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tipsTableView: UITableView!

    var tips: [String] {
        return ["Do the thing like this", "then do the thing like that", "then do it again like that other way"]
        //return (self.parentViewController as! PageViewViewController).set.exercise.tips
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = tips[indexPath.row]
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }

}


class VideoVC: UIViewController, YTPlayerViewDelegate {


    @IBOutlet weak var videoPlayer: YTPlayerView!

    var set: WorkoutSet {
        return (self.parentViewController as! PageViewViewController).set
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer.delegate = self
        videoPlayer.loadWithVideoId(set.exercise.videoUrl)
    }

    func playerView(playerView: YTPlayerView!, didChangeToState state: YTPlayerState) {
        if state == YTPlayerState(rawValue: 1)! {
            videoPlayer.cueVideoById(set.exercise.videoUrl, startSeconds: 0, suggestedQuality: YTPlaybackQuality(rawValue: 2)!)
        }
    }

    
}
