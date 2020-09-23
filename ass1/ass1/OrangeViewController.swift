//
//  orangeView.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import Foundation
import UIKit

class OrangeViewController: UIViewController {
    // attributes
    var views = Views()
    
    //
    // life cycle functions below for this controller
    //
    //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate views (i.e. OrangeView, OrangeView) since they are all invoking the systems UIView.
    // 1st cycle function called
    
    override func loadView() {
        super.loadView()
        print ("OrangeView loadView")
        //        print("Creates the view that OrangeViewController manages. OrangeViewController is loading the view!" + "\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
       views.setLoad(views.getLoad()+1)
        super.viewDidLoad()
        print ("OrangeView viewDidLoad")
        print("OrangeView \(views.getLoad())")

        // Do any additional setup after loading the view.
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print ("OrangeView viewWillAppear")
        //        print("Notifies OrangeViewController that it's view is about to be added to a view hiearchy!" + "\n" )
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
       views.setAppear(views.getAppear()+1)
        print ("OrangeView viewDidAppear")
        print("OrangeView Appears \(views.getAppear())")
        
        //        print("Notifies OrangeViewController that it's view had been added to a view hiearchy. OrangeViewCOntroller shows view on screen!" + "\n" )
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print ("OrangeView viewWillDisappear")
        
        //        print("Notifies OrangeViewController that it's view is about to be removed from a view hiearchy!")
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        print ("OrangeView viewDidDisappear")
        super.viewDidDisappear(animated)
        //        print("Notifies OrangeViewController that it's view had been removed from the hiearchy! OrangeViewController took the current view off!" + "\n")
    }
    
}
