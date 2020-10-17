//
//  PedometerGoalController.swift
//  Pedometer
//
//  Created by Jack Hu on 2020-10-13.
//

// imports
import Foundation
import UIKit


// In this class, the controller will focus on implementing services/call backs to
// Check when the goal for the number of steps have been reached or not
// And user can input their own step goals, then application persists the data 
class PedometerGoalController: UIViewController, UITextFieldDelegate {

    // Outlets
    // This is user input field to get desired goal data
    @IBOutlet weak var userGoalInput: UITextField!
    
    // Local variables for storing the user inputed text field
    var inputText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set how the textfield repond to user input actions using UITextFiled protocols
        // So class (UI view controller) has to implement the UITextFieldDelegate functions
        self.userGoalInput.delegate = self
        // Allows dismissing keyboard when tapping anywhere on the view controller
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // Actions
    // This button when called will get the user inputed data from the UITextField
    @IBAction func setMyGoalButton(_ sender: UIButton){
        self.inputText = self.userGoalInput.text!
        self.userGoalInput.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PedometerMainController
        vc.userInputFromTextField = self.inputText
    }
    
    func hideKeyBoard() {
        self.userGoalInput.resignFirstResponder()
    }
    
    // UITextFieldDelegate methods - they are optional to implement but I will only implement one of them in order to make keyboard disappear upon touch return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // textfiled relinquish first responder status and returns to view controller and hides keyboard when return button is pressed
        hideKeyBoard()
        return true
    }
    
}


