//
//  ViewController.swift
//  Pedometer
//
//  Created by Jack Hu on 2020-10-13.
//

import UIKit
import CoreMotion
import Foundation
import Charts


// This class will represent our main pedometer UI view controller upon loading up the app
// In here we will able to see the live step count the user would like to record, progress bar, etc
class PedometerMainController: UIViewController{
    
    // Local variable to store user input
    var userInputFromTextField = ""
    
    
    // Connecting the labels and progress bar
    @IBOutlet weak var activityType: UILabel!
    @IBOutlet weak var goalMessage: UILabel!
    @IBOutlet weak var distanceMeasure: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var myGoal: UILabel!
    @IBOutlet weak var myProgressBar: UIProgressView!
    
    //MARK: Instantiated as a global static var.
    // Instantiating the acitivity manager to determine sitting or walking etc and pedometer instances
    // For gathering live and old saved data
    //    let myActivityManager = CMMotionActivityManager()
    //    let myPedometer = CMPedometer()
    
    // Adding the goal button so we could switch views and go the goal view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Goal" {
            let PedometerGoalController = segue.destination as! PedometerGoalController
            PedometerGoalController.selectionDelegate = self
        }
    }
    // start CMPedometer functionalities
    @IBAction func startButton(_ sender: UIButton) {
        start()
    }
    
    // performs reseting of pedometer to initial state
    @IBAction func resetButton(_ sender: UIButton) {
        reset()
    }
    
    // performs a segue to the goal view
    @IBAction func goalViewButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: "Goal", sender: self)
    }
    
    // start function
    func start() {
        // Starting my step counting activity and getting my current type of activity
        if(CMMotionActivityManager.isActivityAvailable()) {
            
            // Listener of my acitivity, it will keep give me updates of my actiivity which is store in data
            CMMotionActivityManager.shared.startActivityUpdates(to: OperationQueue.main) { (data) in
                // Starts the listening of our data
                DispatchQueue.main.async { //Background Thread
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
            let startDate = Date()
            CMPedometer.shared.startUpdates(from: startDate) { (pedometerData, error) in
                // if we have no error occuring - running in safe mode
                if (error == nil) { //We don't need this as long as the data is valid.
                    if let response = pedometerData {
                        // starts the listening of the number of steps taken
                        DispatchQueue.main.async { // Background main application thread
                            
                            // updating the progress bar if there is goal data
                            let mg = self.myGoal.text
                            let mgValue = Int(mg!)
                            if (mgValue != 0) {
                                let sc = self.stepCount.text
                                let scValue = Int(sc!)
                                self.myProgressBar.progress = Float((Float(scValue!)/Float(mgValue!)))
                                print("My progress: \(self.myProgressBar.progress)\n")
                                if (self.myProgressBar.progress == 1.0) {
                                    self.goalMessage.text = "I ACHIEVED MY GOAL!"
                                    CMPedometer.shared.stopUpdates()
                                    CMMotionActivityManager.shared.stopActivityUpdates()
                                }
                            }
                            
                            // printing steps to console and updating step count and distance count in UI
                            print("Number of Steps: \(response.numberOfSteps)\n")
                            self.stepCount.text = "\(response.numberOfSteps)"
                            print("Distance traveled: \(response.distance!.intValue)")
                            self.distanceMeasure.text = "\(response.distance!.intValue)"
                                                                          
                            stepValues.append(ChartDataEntry(x:-startDate.timeIntervalSinceNow/60.0, y: Double(truncating: response.numberOfSteps)))
                        }
                    }
                }
            }
        }
        
    }
    
    // reset function
    func reset() {
        CMMotionActivityManager.shared.stopActivityUpdates()
        CMPedometer.shared.stopUpdates()
        self.myGoal.text = String(0)
        self.goalMessage.text = "I'm lazy and I don't have a goal!"
        self.distanceMeasure.text = String(0)
        self.activityType.text = ""
        self.stepCount.text = String(0)
        self.myProgressBar.progress = 0.0
        stepValues = [ChartDataEntry(x: 0.0, y: 0.0)]
    }
    
    // On start up we perform the UI initial setups here
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
        // Set my goal to 0 on start up
        self.myGoal.text = String(0)
        // Set my goal message on startup
        self.goalMessage.text = "I'm lazy and I don't have a goal!"
    }
}
extension PedometerMainController: passDatatoVC {
    func passData(str: String) {
        if let goal = Double(str){ //unwrapping to confirm we have a valid value
            print("Valid goal!")
            self.goalMessage.text = "I'm less lazy as I have a goal now!"
            self.myGoal.text = str
            liml = ChartLimitLine(limit: goal, label: "Step Goal") //adding a limit line to the chart
        }else {print("Invalid Value!")}
    }
}
