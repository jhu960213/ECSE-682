//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

// imnports and global variables
import UIKit
// view struct object to keep track of this view's controller life cycle method calls
var homeViews = Views()

class HomeViewController: UIViewController {
    
    // We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate views (i.e. HomeView, OrangeView) since they are all invoking the systems UIView.
    
    //
    // life cycle functions below for this controller
    //
    
    // shows the life cycle stats of this controller
    func showLifeCycleStatus() {
        print("\n\n\nHome View Controller Life Cycle Stats:")
        print("loadView Count: " + String(orangeViews.getLoadView()))
        print("viewDidLoad Count: " + String(orangeViews.getViewDidLoad()))
        print("viewWillAppear Count: " + String(orangeViews.getViewWillAppear()))
        print("viewDidAppear Count: " + String(orangeViews.getViewDidAppear()))
        print("viewWillDisappear Count: " + String(orangeViews.getViewWillDisappear()))
        print("viewDidDisappear Count: " + String(orangeViews.getViewDidDisappear()) + "\n\n\n")
    }
    
    
    @IBAction func homeViewLifeCycleButton(_ sender: UIButton) {
        sender.alpha = 0.5
        showLifeCycleStatus()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 ) {
                sender.alpha = 1.0
            }
    }
    
    // 1st cycle function called
    override func loadView() {
        super.loadView()
        homeViews.setLoadView(homeViews.getLoadView() + 1)
        print("Creates the view that HVC manages. HVC is loading the view!")
        print("HV loadView Count: " + String(homeViews.getLoadView()) + "\n\n")
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViews.setViewDidLoad(homeViews.getViewDidLoad() + 1)
        print("Do additional view setups after view creation and transfering to main memory. HVC has loaded the view!")
        print("HV viewDidLoad Count: \(homeViews.getViewDidLoad())" + "\n\n")
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        // self.showToast(message: "HomeViewController viewWillAppear", seconds: 2.0)
        super.viewWillAppear(animated)
        homeViews.setViewWillAppear(homeViews.getViewWillAppear() + 1)
        print("Notifies HVC that it's view is about to be added to a view hiearchy!")
        print("HV viewWillAppear Count: \(homeViews.getViewWillAppear())" + "\n\n")
    }
    
    
    // 4th life cycle function called
    // viewdidAppear is called every time the main view is loaded, hence the navigation bar will be hidden in this instance
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViews.setViewDidAppear(homeViews.getViewDidAppear() + 1)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        print("Notifies HVC that it's view had been added to a view hiearchy. HVC shows view on screen!")
        print("HV viewDidAppear Count: \(homeViews.getViewDidAppear())" + "\n\n")
    }
    
    // 5th life cycle function called
    // viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        homeViews.setViewWillDisappear(homeViews.getViewWillDisappear() + 1)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print("Notifies HVC that it's view is about to be removed from a view hiearchy!")
        print("HV viewWillDisappear Count: \(homeViews.getViewWillDisappear())" + "\n\n")
        //self.showToast(message: "HomewViewController viewWillDisappear", seconds: 1.0)
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        homeViews.setViewDidDisappear(homeViews.getViewDidDisappear() + 1)
        //self.showToast(message: "HomewViewController viewDidDisappear", seconds: 2.0)
        print("Notifies HVC that it's view had been removed from the hiearchy! HVC took the current view off!")
        print("HV viewDidDisappear Count: \(homeViews.getViewDidDisappear())" + "\n\n")
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

