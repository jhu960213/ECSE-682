//
//  ViewController.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit

// view struct object to keep track of this view's controller life cycle method calls
var tableViews = Views()
var viewsUsed = tableviews()
//var tabInfo: (label: String, view: Views)

class TableViewController: UITableViewController {
    var tableObjs = [tableobj]()
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableObjs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CounterTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CounterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CounterTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let counter = tableObjs[indexPath.row]
        print("Label is \(viewsUsed.getLabel())!!!!")
        cell.counterLabel.text = "\(viewsUsed.getLabel()) \(counter.getSectionName()) calls: \(counter.getSectionObjects())"

        return cell
    }


    private func unpackStruct(){
        tableObjs = (viewsUsed.getView().allProperties())
    }
    
    //We use super in order to invoke the superclass, i.e. in this instance UIView, this ensures consistency between seperate Tableviews (i.e. TableView, TableView) since they are all invoking the systems UIView.
    
    //
    // life cycle functions below for this controller
    //
    
    // 1st cycle function called
    
    override func loadView() {
        super.loadView()
        tableViews.setLoadView(tableViews.getLoadView() + 1)
        print("Creates the view that TVC manages. TVC is loading the view!")
        print("TV loadView Count: " + String(tableViews.getLoadView()) + "\n\n")
//        showToast(message: "TableView loadView", seconds: 1.0)
    }
    
    // 2nd cycle function called
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor.gray
        super.viewDidLoad()
        unpackStruct()
        tableViews.setViewDidLoad(tableViews.getViewDidLoad() + 1)
        //        showToast(message: "TableView viewDidLoad", seconds: 2.0)
        print("Do additional view setups after view creation and transfering to main memory. TVC has loaded the view!")
        print("TV viewDidLoad Count: \(tableViews.getViewDidLoad())" + "\n\n")
//        showToast(message: "TableView viewDidLoad", seconds: 1.0)
    }
    
    // 3rd life cycle function called
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViews.setViewWillAppear(tableViews.getViewWillAppear() + 1)
        //        showToast(message: "TableView viewWillAppear", seconds: 2.0)
        print("Notifies TVC that it's view is about to be added to a view hiearchy!")
        print("TV viewWillAppear Count: \(tableViews.getViewWillAppear())" + "\n\n")
//        showToast(message: "TableView viewWillAppear", seconds: 1.0)
    }
    
    // 4th life cycle function called
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViews.setViewDidAppear(tableViews.getViewDidAppear() + 1)
        //        showToast(message: "TableView viewDidAppear", seconds: 2.0)
        navigationController?.setNavigationBarHidden(false, animated: true)
        print("Notifies TVC that it's view had been added to a view hiearchy. TVC shows view on screen!")
        print("TV viewDidAppear Count: \(tableViews.getViewDidAppear())" + "\n\n")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.showToast(message: "TableView viewDidAppear", seconds: 3.0)
        }
    }
    
    // 5th life cycle function called
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableViews.setViewWillDisappear(tableViews.getViewWillDisappear() + 1)
        //        showToast(message: "TableView viewWillDisappear", seconds: 2.0)
        
        // viewWillDisappear is called every time the main view is left, hence the navigation bar will be shown in this instance when we leave the view.
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print("Notifies TVC that it's view is about to be removed from a view hiearchy!")
        print("TV viewWillDisappear Count: \(tableViews.getViewWillDisappear())" + "\n\n")
//        showToast(message: "TableView viewWillDisappear", seconds: 1.0)
    }
    
    // 6th life cycle function called
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableViews.setViewDidDisappear(tableViews.getViewDidDisappear() + 1)
        print("Notifies TVC that it's view had been removed from the hiearchy! TVC took the current view off!")
        print("TV viewDidDisappear Count: \(tableViews.getViewDidDisappear())" + "\n\n")
        showToast(message: "TableView viewDidDisappear", seconds: 3.0)
    }
}

protocol Loopable {
    func allProperties() /*throws*/ -> [tableobj]
}

extension Loopable {
    func allProperties() /*throws*/ -> [tableobj] {
        
        var tableObjs = [tableobj]()
        let mirror = Mirror(reflecting: self)
        
                // Optional check to make sure we're iterating over a struct or class
//                guard let style = mirror.displayStyle, style == .struct || style == .class else {
//                    throw NSError()
//                }
        
        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            tableObjs.append(tableobj(LifeCycle(rawValue: property) ?? LifeCycle.nul, value as! Int))
            print(tableObjs)
        }
        
        return tableObjs
    }
}



