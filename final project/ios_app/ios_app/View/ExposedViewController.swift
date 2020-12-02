//
//  ExposedViewController.swift
//  ios_app
//
//  Created by Jack Hu on 2020-12-02.
//

import Foundation
import UIKit

// this class will deal with UI changes in the event if you are already exposed
class ExposedViewController: UIViewController {
    
    // outlets and actions
    @IBOutlet weak var exposedDescription: UILabel!
    @IBOutlet weak var covidLink: UILabel!
    
    
    // click functions
    // And that's the function :)
    @objc func onClickLabel(sender:UITapGestureRecognizer) {
        openUrl(urlString: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/when-and-how-to-use-masks")
    }

    // open covid URL
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    // loading of the description
    override func viewDidLoad() {
        
        // covid description
        self.exposedDescription.text = "If you are an individual who had been exposed to Covid-19 please visit this link below for further instructions!"
        
        // link to covid help
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickLabel(sender:)))
        covidLink.isUserInteractionEnabled = true
        covidLink.addGestureRecognizer(tap)
    }
}
