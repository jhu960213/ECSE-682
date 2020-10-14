//
//  ViewController.swift
//  Pedometer
//
//  Created by Jack Hu on 2020-10-13.
//

import UIKit

// This class will represent our main pedometer UI view controller upon loading up the app
// In here we will able to see the live step count the user would like to record, progress bar, etc
class PedometerMainController: UIViewController {
    
    // Adding the goal button so we could switch views and go the goal view
    @IBAction func goalButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: "Goal", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.systemPurple
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }


}

