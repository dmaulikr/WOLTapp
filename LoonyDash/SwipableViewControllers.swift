//
//  SwipableViewControllers.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/14/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

protocol RepsAndWeightDelegate: class {
    func repsDown()
    func repsUp()
    func weightDown()
    func weightUp()
}

class RepsAndWeightVC: UIViewController {
    var setVC: SetViewController {
        return (self.parentViewController as! PageViewViewController).parent
    }

    @IBOutlet weak var numWeightOutlet: UILabel!
    weak var delegate: RepsAndWeightDelegate?

    @IBOutlet weak var numRepsOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = setVC

    }



    func updateUI() {
        numRepsOutlet.text = "\(setVC.repsSelection)"
        numWeightOutlet.text = String(format: "%.0f", setVC.weightSelection)
    }



    @IBAction func onDownReps(sender: AnyObject) {
        delegate?.repsDown()
        updateUI()
    }


    @IBAction func onUpReps(sender: AnyObject) {
        delegate?.repsUp()
        updateUI()
    }


    @IBAction func onDownWeight(sender: AnyObject) {
        delegate?.weightDown()
        updateUI()
    }


    @IBAction func onUpWeight(sender: AnyObject) {
        delegate?.weightUp()
        updateUI()
    }
}



class PersonalBestVC: UIViewController {

}


class TipsVC: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!

    var tipText: String {
        return "Don’t squat by just bending through your knees, letting them travel all the way forward. Engage your stronger posterior chain muscle by sitting back on the way down.\n\nNever allow your knees to buckle on the way up. Push your knees outward at all times - this is safer for your knees and your back.\n\nArch your upper back. Lock the bar in position so it doesn’t move while you squat. Keeping your back tight will also keep pressure from your wrists. Take a big breath, lift your chest, and squeeze your shoulder-blades together."
        //return (self.parentViewController as! PageViewViewController).set.exercise.tips
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = tipText
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
