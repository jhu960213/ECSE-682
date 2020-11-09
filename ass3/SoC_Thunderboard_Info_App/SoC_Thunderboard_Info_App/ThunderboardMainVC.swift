//
//  ViewController.swift
//  SoC_Thunderboard_Info_App
//
//  Created by Jack Hu on 2020-11-07.
//

import UIKit
import CoreBluetooth
import Foundation
class ThunderboardMainVC: UIViewController{
    // performs segue
    @IBAction func viewData(_ sender: UIButton) {
        performSegue(withIdentifier: "GetData", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.451579988, green: 0.6610453725, blue: 1, alpha: 1)]//Colors you want to add
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()

}

