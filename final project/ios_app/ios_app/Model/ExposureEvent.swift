//
//  File.swift
//  ios_app
//
//  Created by Jack Hu on 2020-11-29.
//

import Foundation

// transfer object class
class ExposureEvent: NSObject {
    // contains the updated exposure result from our data base
    var exposure_result:Bool
    // constructor
    init(_ exposure_result:Bool) {
        self.exposure_result = exposure_result
    }
}
