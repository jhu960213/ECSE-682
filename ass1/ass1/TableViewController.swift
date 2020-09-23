//
//  orangeView.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
      // attributes
     var views = Views()
     
     //
     // life cycle functions below for this controller
     //
     //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate views (i.e. TableView, TableView) since they are all invoking the systems UIView.
     // 1st cycle function called
     
     override func loadView() {
         super.loadView()
         print ("TableView loadView")
         //        print("Creates the view that TableViewController manages. TableViewController is loading the view!" + "\n")
     }
     
     // 2nd cycle function called
     override func viewDidLoad() {
         var numLoads = views.getLoad()
         numLoads += 1
         views.setLoad(numLoads)
         super.viewDidLoad()
        print ("TableView viewDidLoad")
        print(numLoads)
         // Do any additional setup after loading the view.
     }
     
     // 3rd life cycle function called
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print ("TableView viewWillAppear")
         //        print("Notifies TableViewController that it's view is about to be added to a view hiearchy!" + "\n" )
     }
     
     
     // 4th life cycle function called
     override func viewDidAppear(_ animated: Bool) {
         var numAppears = views.getAppear()
         numAppears += 1
         views.setAppear(numAppears)
         print ("TableView viewDidAppear")
         //        print("Notifies TableViewController that it's view had been added to a view hiearchy. TableViewCOntroller shows view on screen!" + "\n" )
     }
     
     // 5th life cycle function called
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         print ("TableView viewWillDisappear")
         
         //        print("Notifies TableViewController that it's view is about to be removed from a view hiearchy!")
     }
     
     // 6th life cycle function called
     override func viewDidDisappear(_ animated: Bool) {
         print ("TableView viewDidDisappear")
         super.viewDidDisappear(animated)
         //        print("Notifies TableViewController that it's view had been removed from the hiearchy! TableViewController took the current view off!" + "\n")
     }
    
}
