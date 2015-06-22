//
//  PageViewViewController.swift
//  LoonyDash
//
//  Created by Michael Lipman on 6/14/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class PageViewViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pages: [UIViewController] = []
    var set: WorkoutSet!
    var page1: RepsAndWeightVC!
    weak var parent: SetViewController!


    override func viewDidLoad() {
        super.viewDidLoad()

        page1 = UIStoryboard(name: "Sets", bundle: nil).instantiateViewControllerWithIdentifier("RepsAndWeightVC") as! RepsAndWeightVC
        let page2 = UIStoryboard(name: "Sets", bundle: nil).instantiateViewControllerWithIdentifier("VideoVC") as! VideoVC
        let page3 = UIStoryboard(name: "Sets", bundle: nil).instantiateViewControllerWithIdentifier("TipsVC") as! TipsVC
        pages = [page1, page2, page3]
        dataSource = self
        setViewControllers([page1], direction: .Forward, animated: true, completion: nil)

    }


    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController == pages[0] {
            return pages[1]
        } else if viewController == pages[1] {
            return pages[2]
        } else {
            return nil
        }
    }

    func updateRepsWeightUI() {
        page1.updateUI()
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController == pages[2] {
            return pages[1]
        } else if viewController == pages[1] {
            return pages[0]
        } else {
            return nil
        }
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    func showNewSet(set: WorkoutSet) {
        setViewControllers([page1], direction: .Forward, animated: false, completion: nil)
        self.set = set
        page1.updateUI()

    }



}
