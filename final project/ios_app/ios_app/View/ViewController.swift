//
//  ViewController.swift
//  Medium-popover
//
//  Created by Henry Goodwin on 3/6/19.
//  Copyright © 2019 Henry Goodwin. All rights reserved.
//

import UIKit
import SwiftEventBus
class ViewController: UIViewController{

    //MARK:_____________CARD UI DEPENDENT LOGIC______________________________________
        // Variable for card view controller
        var cardViewController:CardViewController!
        
        var nextState:CardState {
            return cardVisible ? .collapsed : .expanded
        }
    
    // outlets for the labels and image view
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Exposure: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    
    // called from viewdidload to setup subscribing to event updates from repository
    func setupEventBusSubscriber() {
        _ = SwiftEventBus.onMainThread(self, name: "UpdateUI") { result in
            if let updateEvent = result?.object as? Notification{
                if (updateEvent.test_result == true) {
                    self.Exposure.text = "You have been near someone who had reported a positive diagnosis!"
                    self.stateImage.image = UIImage(named: "caution")
                } else {
                    self.Exposure.text = "You are clean! Be mindful of large social gatherings!"
                    self.stateImage.image = UIImage(named: "thumbsup")
                }
            }
        }
    }
        
    
        
        // Variable for effects visual effect view
        var visualEffectView:UIVisualEffectView!
        
        // Starting and end card heights will be determined later
        var endCardHeight:CGFloat = 0
        var startCardHeight:CGFloat = 0
        
        // Current visible state of the card
        var cardVisible = false
        
        // Empty property animator array
        var runningAnimations = [UIViewPropertyAnimator]()
        var animationProgressWhenInterrupted:CGFloat = 0
    //_____________CARD UI DEPENDENT LOGIC______________________________________

    @objc func performSegueforSelfreport(_ notification: NSNotification) {
        print("OBJC WORKED")
        performSegue(withIdentifier: "self_report", sender: self)
    }
    @objc func performSegueforHelp(_ notification: NSNotification) {
        print("OBJC WORKED")
        performSegue(withIdentifier: "help", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(performSegueforSelfreport(_:)), name: NSNotification.Name(rawValue: "performSegueforSelf_report"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(performSegueforHelp(_:)), name: NSNotification.Name(rawValue: "performSegueforHelp"), object: nil)
        // Do any additional setup after loading the view.
        setupCard()
        setupEventBusSubscriber()
    }
}
