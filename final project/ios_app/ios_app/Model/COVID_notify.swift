//
//  COVID_notify.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-26.
//

import Foundation
enum proximity{
    case immediate, near, irrelevant
}
struct notifications{
    var beacon_UUID: String
    var major: Int
    var minor: Int
    var test_result: Bool
    var device_id: String = UUID().uuidString //device identifier (Anonymous)
    var distance: String
}
