//
//  Variables.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import Foundation
import UIKit
// views class
struct Views {
    
    // attributes
    private var loadView: Int
    private var viewDidLoad: Int
    private var viewWillAppear: Int
    private var viewDidAppear: Int
    private var viewWillDisappear: Int
    private var viewDidDisappear : Int
    
    // constructor 1 - for when we want to initialize with unique parameters
    init(_ loadView:Int, _ viewDidLoad:Int, _ viewWillAppear:Int, _ viewDidAppear:Int, _ viewWillDisappear:Int, _ viewDidDisappear:Int) {
        self.loadView = loadView
        self.viewDidLoad = viewDidLoad
        self.viewWillAppear = viewWillAppear
        self.viewDidAppear = viewDidAppear
        self.viewWillDisappear = viewWillDisappear
        self.viewDidDisappear = viewDidDisappear
    }
    
    // constructor 2 - for when we just want to initialize with null parameters
    init() {
        self.loadView = 0
        self.viewDidLoad = 0
        self.viewWillAppear = 0
        self.viewDidAppear = 0
        self.viewWillDisappear = 0
        self.viewDidDisappear = 0
    }
    
    // setters and getters
    public func getLoadView() -> Int {
        return self.loadView
    }
    
    public mutating func setLoadView(_ inLoadView: Int) {
        self.loadView = inLoadView
    }
    
    // setters and getters
    public func getViewDidLoad() -> Int {
        return self.viewDidLoad
    }
    
    public mutating func setViewDidLoad(_ inViewDidLoad: Int) {
        self.viewDidLoad = inViewDidLoad
    }
    
    // setters and getters
    public func getViewWillAppear() -> Int {
        return self.viewWillAppear
    }
    
    public mutating func setViewWillAppear(_ inViewWillAppear: Int) {
        self.viewWillAppear = inViewWillAppear
    }
    
    // setters and getters
    public func getViewDidAppear() -> Int {
        return self.viewDidAppear
    }
    
    public mutating func setViewDidAppear(_ inViewDidAppear: Int) {
        self.viewDidAppear = inViewDidAppear
    }
    
    // setters and getters
    public func getViewWillDisappear() -> Int {
        return self.viewWillDisappear
    }
    
    public mutating func setViewWillDisappear(_ inViewWillDisappear: Int) {
        self.viewWillDisappear = inViewWillDisappear
    }
    
    
    // setters and getters
    public func getViewDidDisappear() -> Int {
        return self.viewDidDisappear
    }
    
    public mutating func setViewDidDisappear(_ inViewDidDisappear: Int) {
        self.viewDidDisappear = inViewDidDisappear
    }
}
