//
//  NotificationRepository.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class notificationRepository: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var notifications = [Notification]()
    
    func loadData(){
        db.collection("notifications").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot =  querySnapshot {
                self.notifications = querySnapshot.documents.compactMap{ document in
                    try? document.data(as: Notification.self)
                }
            }
        }
    }
}
