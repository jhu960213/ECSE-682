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
    //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate views (i.e. HomeView, OrangeView) since they are all invoking the systems UIView.
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        //        print("Creates the view that HomeViewController manages. HomeViewController is loading the view!" + "\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        views.setLoad(views.getLoad()+1)
        super.viewDidLoad()
        print("HM DidLoad \(views.getLoad())")
        
        //        print("Do additional view setups after view creation and transfering to main memory. HomeViewController has loaded the view!" + "\n")
        // Do any additional setup after loading the view.
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        // self.showToast(message: "HomeViewController viewWillAppear", seconds: 2.0)
        super.viewWillAppear(animated)
        //        print("Notifies HomeViewController that it's view is about to be added to a view hiearchy!" + "\n" )
    }
    
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        var appear = views.getAppear()
        appear += 1
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
        //        print("Notifies HomeViewController that it's view had been added to a view hiearchy. HomeViewCOntroller shows view on screen!" + "\n" )
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        views.setWillDis(views.getWillDis()+1)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        //viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
        //        print("Notifies HomeViewController that it's view is about to be removed from a view hiearchy!")
        //self.showToast(message: "HomewViewController viewWillDisappear", seconds: 1.0)
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        //        print ("HomeView viewDidDisappear")
        super.viewDidDisappear(animated)
        views.setDidDisappear(views.getDidDisappear()+1)
        //self.showToast(message: "HomewViewController viewDidDisappear", seconds: 2.0)
        //        print("Notifies HomeViewController that it's view had been removed from the hiearchy! HomeViewController took the current view off!" + "\n")
    }
    
    
    
}
//Borrowed method that is similar to toast in Android. Credit: Sazzad Hissain Khan, @StackOverFlow
extension UIViewController {
    func showToast(message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

