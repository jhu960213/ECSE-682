//
//  COVID_notify.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

var phone_id: String = UUID().uuidString //device identifier (Anonymous)
enum proximity{
    case immediate, near, irrelevant
}
struct Notification: Codable, Identifiable{
    var id: String = phone_id
    var beacon_UUID: String
    var major: Int
    var minor: Int
    var test_result: Bool
    var distance: Int
    var created_time: Timestamp?
}
