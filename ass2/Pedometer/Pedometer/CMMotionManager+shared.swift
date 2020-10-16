//
//  CMMotionManager+shared.swift
//  Pedometer
//
//  Created by Hamza Mian on 2020-10-16.
//

import CoreMotion

extension CMMotionManager{
    static var shared = CMMotionManager()
    //    static var pedometer = CMPedometer()
    
    
}

extension CMPedometer{
    static var shared = CMPedometer()
}

extension CMMotionActivityManager{
    static var shared = CMMotionActivityManager()
}
