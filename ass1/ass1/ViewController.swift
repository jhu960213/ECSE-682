//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        views.load += 1
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        views.appear += 1
        navigationController?.setNavigationBarHidden(true, animated: true)
        //viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
    }


}

