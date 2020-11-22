//
//  CardViewController.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-20.
//

import UIKit

class CardViewController: UIViewController {
    
    
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var selfReport: UIButton!
    
    @IBAction func helpTouch(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "performSegueforHelp"), object: nil)
    }
    
    @IBAction func selfReportTouch(_ sender: UIButton) {
        print("SENT DELEGATE")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "performSegueforSelf_report"), object: nil)

//        delegate?.performSegue(identifier: "self_report")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        [scrollView setContentSize:CGSizeMake(320, 480)];
//        [scrollView setEnabled:YES];
        

        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
