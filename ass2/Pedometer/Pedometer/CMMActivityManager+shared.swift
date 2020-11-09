//
//  CMMActivityManager.swift
//  Pedometer
//
//  Created by Hamza Mian on 2020-10-17.
//

import CoreMotion

extension CMMotionActivityManager{
    static var shared = CMMotionActivityManager()
}

extension CMPedometer{
    static var shared = CMPedometer()
}

