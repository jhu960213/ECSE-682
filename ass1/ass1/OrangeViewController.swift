//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit
var OrangeDidLoad = 0
var OrangeWillAppear = 0
var OrangeDidAppear = 0
var OrangeWillDisappear = 0
var OrangeDidDisappear = 0

class OrangeViewController: UIViewController {
    
    // attributes
    //var Orangeviews = Views()
    
    
    //
    // life cycle functions below for this controller
    //
    //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate Orangeviews (i.e. OrangeView, OrangeView) since they are all invoking the systems UIView.
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        //        print ("OrangeView loadView")
        //        print("Creates the view that OrangeViewController manages. OrangeViewController is loading the view!" + "\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        
        OrangeDidLoad += 1
        print("OG DidLode \(OrangeDidLoad)")
        super.viewDidLoad()
        //        showToast(message: "OrangeView viewDidLoad", seconds: 2.0)
        //  print("Do additional view setups after view creation and transfering to main memory. OrangeViewController has loaded the view!" + "\n")
        // Do any additional setup after loading the view.
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        OrangeWillAppear += 1
        print("OG WillApp \(OrangeWillAppear)")
        self.view.backgroundColor = UIColor.red
        super.viewWillAppear(animated)
        //        showToast(message: "OrangeView viewWillAppear", seconds: 2.0)
        //        print ("OrangeView viewWillAppear")
        //        print("Notifies OrangeViewController that it's view is about to be added to a view hiearchy!" + "\n" )
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.backgroundColor = UIColor.orange
        OrangeDidAppear += 1
        print("OG DidApp \(OrangeDidAppear)")
        //        showToast(message: "OrangeView viewDidAppear", seconds: 2.0)
        
        //viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
        //        print("Notifies OrangeViewController that it's view had been added to a view hiearchy. OrangeViewCOntroller shows view on screen!" + "\n" )
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        OrangeWillDisappear += 1
        print("OG WillDiss \(OrangeWillDisappear)")
        super.viewWillDisappear(animated)
        self.view.backgroundColor = UIColor.blue
        //        showToast(message: "OrangeView viewWillDisappear", seconds: 2.0)
        
        //viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
        //        print("Notifies OrangeViewController that it's view is about to be removed from a view hiearchy!")
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        OrangeDidDisappear += 1
        print("OG DidDiss \(OrangeDidDisappear)")
        super.viewDidDisappear(animated)
        self.view.backgroundColor = UIColor.green
        //        showToast(message: "OrangeView viewDidDisappear", seconds: 2.0)
        
        //        print("OrangeView diDisappears \(Orangeviews.getDidDisappear())")
        //        print("Notifies OrangeViewController that it's view had been removed from the hiearchy! OrangeViewController took the current view off!" + "\n")
    }
    
    
    
    
}



