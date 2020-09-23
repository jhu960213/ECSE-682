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
    override func viewDidLoad() {
        var numLoads = views.getLoad()
        numLoads += 1
        views.setLoad(numLoads)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
