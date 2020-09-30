//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit
// view struct object to keep track of this view's controller life cycle method calls
var orangeViews = Views()


class OrangeViewController: UIViewController {
    
    var tableInfo: (label: String, view: Views)!
    
    @IBAction func touchBut(_ sender: Any) {//Function for both buttons in OrangeView.
        self.performSegue(withIdentifier: "table", sender: self)
        viewsUsed.setLabel("Orange View")//set the viewsused to orange view i.e Tell us which view initiated call.
        viewsUsed.setView(orangeViews)
    }
    
    // We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate Orangeviews (i.e. OrangeView, OrangeView) since they are all invoking the systems UIView.
    
    // function to print the life cycle stats of this controller
    func showLifeCycleStatus() {
        print("\n\n\nOrange View Controller Life Cycle Stats:")
        print("loadView Count: " + String(orangeViews.getLoadView()))
        print("viewDidLoad Count: " + String(orangeViews.getViewDidLoad()))
        print("viewWillAppear Count: " + String(orangeViews.getViewWillAppear()))
        print("viewDidAppear Count: " + String(orangeViews.getViewDidAppear()))
        print("viewWillDisappear Count: " + String(orangeViews.getViewWillDisappear()))
        print("viewDidDisappear Count: " + String(orangeViews.getViewDidDisappear()) + "\n\n\n")
    }
    
    // connected the button of life cycle stats to display the life cycle status of orange view controller
    @IBAction func orangeViewLifeCycleButton(_ sender: UIButton) {
        sender.alpha = 0.5
        showLifeCycleStatus()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            sender.alpha = 1.0
        }
    }
    
    //
    // life cycle functions below for this controller
    //
    
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        orangeViews.setLoadView(orangeViews.getLoadView() + 1)
        print("Creates the view that OVC manages. OVC is loading the view!")
        print("OV loadView Count: " + String(orangeViews.getLoadView()) + "\n\n")
//        showToast(message: "OrangeView loadView", seconds: 1.0)
        
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        super.viewDidLoad()
        orangeViews.setViewDidLoad(orangeViews.getViewDidLoad() + 1)
        print("Do additional view setups after view creation and transfering to main memory. OVC has loaded the view!")
        print("OV viewDidLoad Count: \(orangeViews.getViewDidLoad())" + "\n\n")
//        showToast(message: "OrangeView viewDidLoad", seconds: 1.0)
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orangeViews.setViewWillAppear(orangeViews.getViewWillAppear() + 1)
        print("Notifies OVC that it's view is about to be added to a view hiearchy!")
        print("OV viewWillAppear Count: \(orangeViews.getViewWillAppear())" + "\n\n")
//        showToast(message: "OrangeView viewWillAppear", seconds: 1.0)
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.orange
        super.viewDidAppear(animated)
        orangeViews.setViewDidAppear(orangeViews.getViewDidAppear() + 1)
        //        // viewDidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        print("Notifies OVC that it's view had been added to a view hiearchy. OVC shows view on screen!")
        print("OV viewDidAppear Count: \(orangeViews.getViewDidAppear())" + "\n\n")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.showToast(message: "OrangeView viewDidAppear", seconds: 3.0)
        }
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        orangeViews.setViewWillDisappear(orangeViews.getViewWillDisappear() + 1)
        //viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        print("Notifies OVC that it's view is about to be removed from a view hiearchy!")
        print("OV viewWillDisappear Count: \(orangeViews.getViewWillDisappear())" + "\n\n")
//        showToast(message: "OrangeView viewWillDisappear", seconds: 1.0)
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orangeViews.setViewDidDisappear(orangeViews.getViewDidDisappear() + 1)
        print("Notifies OVC that it's view had been removed from the hiearchy! OVC took the current view off!")
        print("OV viewDidDisappear Count: \(orangeViews.getViewDidDisappear())" + "\n\n")
        showToast(message: "OrangeView viewDidDisappear", seconds: 3.0)
    }
}



