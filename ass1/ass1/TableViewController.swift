//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit

var TableDidLoad = 0
var TableWillAppear = 0
var TableDidAppear = 0
var TableWillDisappear = 0
var TableDidDisappear = 0

class TableViewController: UIViewController {
    
    // attributes
    //var Tableviews = Views()
    
    
    //
    // life cycle functions below for this controller
    //
    //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate Tableviews (i.e. TableView, TableView) since they are all invoking the systems UIView.
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        //        print ("TableView loadView")
        //        print("Creates the view that TableViewController manages. TableViewController is loading the view!" + "\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        
        TableDidLoad += 1
        print("OG DidLode \(TableDidLoad)")
        super.viewDidLoad()
        //        showToast(message: "TableView viewDidLoad", seconds: 2.0)
        //  print("Do additional view setups after view creation and transfering to main memory. TableViewController has loaded the view!" + "\n")
        // Do any additional setup after loading the view.
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        TableWillAppear += 1
        print("OG WillApp \(TableWillAppear)")
        self.view.backgroundColor = UIColor.red
        super.viewWillAppear(animated)
        //        showToast(message: "TableView viewWillAppear", seconds: 2.0)
        //        print ("TableView viewWillAppear")
        //        print("Notifies TableViewController that it's view is about to be added to a view hiearchy!" + "\n" )
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.backgroundColor = UIColor.orange
        TableDidAppear += 1
        print("OG DidApp \(TableDidAppear)")
        //        showToast(message: "TableView viewDidAppear", seconds: 2.0)
        
        //viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
        //        print("Notifies TableViewController that it's view had been added to a view hiearchy. TableViewCOntroller shows view on screen!" + "\n" )
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        TableWillDisappear += 1
        print("OG WillDiss \(TableWillDisappear)")
        super.viewWillDisappear(animated)
        self.view.backgroundColor = UIColor.blue
        //        showToast(message: "TableView viewWillDisappear", seconds: 2.0)
        
        //viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
        //        print("Notifies TableViewController that it's view is about to be removed from a view hiearchy!")
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        TableDidDisappear += 1
        print("OG DidDiss \(TableDidDisappear)")
        super.viewDidDisappear(animated)
        self.view.backgroundColor = UIColor.green
        //        showToast(message: "TableView viewDidDisappear", seconds: 2.0)
        
        //        print("TableView diDisappears \(Tableviews.getDidDisappear())")
        //        print("Notifies TableViewController that it's view had been removed from the hiearchy! TableViewController took the current view off!" + "\n")
    }
    
    
    
    
}



