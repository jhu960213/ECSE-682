//
//  Variables.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-22.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import Foundation

// views class
struct Views {
    
    // attributes
    private var load: Int
    private var appear: Int
    private var willDisappear: Int
    private var didDisappear : Int
    
    // constructor 1 - for when we want to initialize with unique parameters
    init(_ loadNum: Int, _ appearNum: Int, _ willDisappearNum: Int, _ didDisappearNum: Int) {
        self.load = loadNum
        self.appear = appearNum
        self.willDisappear = willDisappearNum
        self.didDisappear = didDisappearNum
    }
    
    // constructor 2 - for when we just want to initialize with null parameters
    init() {
        self.load = 0
        self.appear = 0
        self.willDisappear = 0
        self.didDisappear = 0
    }
    
    // setters and getters
    public func getLoad() -> Int {
        return self.load
    }
    
    public mutating func setLoad(_ inload: Int) {
        self.load = inload
    }
    
    // setters and getters
    public func getAppear() -> Int {
        return self.appear
    }
    
    public mutating func setAppear(_ inAppear: Int) {
        self.appear = inAppear
    }
    
    // setters and getters
    public func getWillDis() -> Int {
        return self.willDisappear
    }
    
    public mutating func setWillDis(_ inWillDisappear: Int) {
        self.willDisappear = inWillDisappear
    }
    
    // setters and getters
    public func getDidDisappear() -> Int {
        return self.didDisappear
    }
    
    public mutating func setDidDisappear(_ inDidDisappear: Int) {
        self.didDisappear = inDidDisappear
    }
}
