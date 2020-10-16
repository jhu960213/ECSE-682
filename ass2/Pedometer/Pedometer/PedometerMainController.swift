//
//  ViewController.swift
//  Pedometer
//
//  Created by Jack Hu on 2020-10-13.
//

import UIKit
import CoreMotion

// This class will represent our main pedometer UI view controller upon loading up the app
// In here we will able to see the live step count the user would like to record, progress bar, etc
class PedometerMainController: UIViewController {
    let activityManaging = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    let appQueue = OperationQueue()
    let motionerror = NSError()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startWalking()

        
    }
    func startWalking () -> Void {
        if (CMPedometer.isStepCountingAvailable() && CMPedometer.authorizationStatus() == .authorized){
            CMPedometer.shared.startUpdates(from: Date.init()) { (stepData, error) in
                if let stepcount = stepData?.numberOfSteps{
                    //TODO: Show on graph
                }
            
//                if let stepcount = dataf?.
            
            //CMPedometer.shared.startEventUpdates(handler: motionerror) in
            }
        }else if (CMPedometer.authorizationStatus() != (.authorized)){
            //TODO: Send User message telling them to authorize
        }
        
    }
    


}

// MARK: Code that we could incorporate
//        if CMMotionManager.shared.isAccelerometerAvailable{
//
//        }
//        if CMMotionActivityManager.isActivityAvailable(){
//            CMMotionActivityManager.shared.startActivityUpdates(to: OperationQueue.main){ (data) in
//                DispatchQueue.main
//            }
//        }
