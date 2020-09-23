//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // attributes
    var views = Views()
    
    
    //
    // life cycle functions below for this controller
    //
    
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        print("Creates the view that HomeViewController manages. HomeViewController is loading the view!" + "\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        var numLoads = views.getLoad()
        numLoads += 1
        views.setLoad(numLoads)
        super.viewDidLoad()
        print("Do additional view setups after view creation and transfering to main memory. HomeViewController has loaded the view!" + "\n")
        // Do any additional setup after loading the view.
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Notifies HomeViewController that it's view is about to be added to a view hiearchy!" + "\n" )
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        var numAppears = views.getAppear()
        numAppears += 1
        views.setAppear(numAppears)
        navigationController?.setNavigationBarHidden(true, animated: true)
        //viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
        print("Notifies HomeViewController that it's view had been added to a view hiearchy. HomeViewCOntroller shows view on screen!" + "\n" )
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Notifies HomeViewController that it's view is about to be removed from a view hiearchy!")
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Notifies HomeViewController that it's view had been removed from the hiearchy! HomeViewController took the current view off!" + "\n")
    }
    
    


}

