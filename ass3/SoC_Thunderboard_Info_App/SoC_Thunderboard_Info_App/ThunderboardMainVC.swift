//
//  ViewController.swift
//  SoC_Thunderboard_Info_App
//
//  Created by Jack Hu on 2020-11-07.
//

import UIKit
import CoreBluetooth

class ThunderboardMainVC: UIViewController {
    
    // outlets
    
    
    
    
    // performs segue
    @IBAction func viewData(_ sender: UIButton) {
        performSegue(withIdentifier: "GetData", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

