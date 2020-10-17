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
    
    // Local variable to store user input
    var userInputFromTextField = ""
    
    // Connecting the labels and progress bar
    @IBOutlet weak var activityType: UILabel!
    @IBOutlet weak var distanceMeasure: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var myGoal: UILabel!
    @IBOutlet weak var myProgressBar: UIProgressView!
    
    // Instantiating the acitivity manager to determine sitting or walking etc and pedometer instances
    // For gathering live and old saved data
    let myActivityManager = CMMotionActivityManager()
    let myPedometer = CMPedometer()
    
    
    // Adding the goal button so we could switch views and go the goal view
    @IBAction func goalViewButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: "Goal", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Setting my goal and step count labels to a certain value on start up
        self.stepCount.text = String(0)
        // Setting my progress bar to 0 at start up
        self.myProgressBar.progress = 0.0
        // Set my default acitivity to null
        self.activityType.text = ""
        // Set distance traveled on start up to 0
        self.distanceMeasure.text = String(0)
        // Setting the goal = to the user inputed goal from the other view controller or
        // 0 from initial startup 
        if (self.userInputFromTextField == "") {
            self.myGoal.text = String(0)
        } else {
            self.myGoal.text = self.userInputFromTextField
        }
        
        
        // Setting up the time and date for pedometer data extraction
        let calender = NSCalendar.current
        var calComponents = calender.dateComponents(in: TimeZone.current, from: Date())
        calComponents.hour = 0
        calComponents.minute = 0
        calComponents.second = 0
        let midnightOfToday = calender.date(from: calComponents)!
        
        
        // Starting my step counting activity and getting my current type of activity
        if(CMMotionActivityManager.isActivityAvailable()) {
            // Listener of my acitivity, it will keep give me updates of my actiivity which is store in data
            self.myActivityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                // Starts the listening of our data
                DispatchQueue.main.async {
                    if let myActivity = data {
                        // Switching between the differnt types of activity
                        if (myActivity.running == true) {
                            print("User is running!")
                            self.activityType.text = "Running"
                        } else if(myActivity.stationary == true) {
                            print("User is stationary!")
                            self.activityType.text = "Stationary"
                            
                        } else if(myActivity.walking == true) {
                            print("User is walking!")
                            self.activityType.text = "Walking"
                            
                        } else if(myActivity.automotive == true) {
                            print("User is in a car!")
                            self.activityType.text = "Automotive"
                            
                        } else if(myActivity.cycling == true) {
                            print("User is biking!")
                            self.activityType.text = "Cycling"
                        }
                    }
                }
            }
        }
        
        // If my pedometer has step counting and distance measure hardware support
        // then count and measure the number of steps and distance traveled
        // This does live updates
        if (CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable()) {
            self.myPedometer.startUpdates(from: Date()) { (pedometerData, error) in
                // if we have no error occuring - running in safe mode
                if (error == nil) {
                    if let response = pedometerData {
                        // starts the listening of the number of steps taken
                        DispatchQueue.main.async {
                            // updating the progress bar
                            let sc = self.stepCount.text
                            let scValue = Int(sc!)
                            let mg = self.myGoal.text
                            let mgValue = Int(mg!)
                            self.myProgressBar.progress = Float((Float(scValue!)/Float(mgValue!)))
                            print("My progress: \(self.myProgressBar.progress)\n")
                            print("Number of Steps: \(response.numberOfSteps)\n")
                            self.stepCount.text = "\(response.numberOfSteps)"
                            print("Distance traveled: \(response.distance!.intValue)")
                            self.distanceMeasure.text = "\(response.distance!.intValue)"
                        }
                        
                    }
                }
            }
        }
    }
}
