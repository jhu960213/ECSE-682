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
    
    func loadData(){ //Don't think we need to load Data, actually just send Notif when Pos test, and addNotification.
//MARK:Here we can add a listener for a Positive result, that can change the UI.
        
        db.collection("notifications").whereField("device_id", isEqualTo: phone_id).addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot =  querySnapshot {
                self.notifications = querySnapshot.documents.compactMap{ document in
                    try? document.data(as: Notification.self)
                }
            }
        }
    }
    
    func addNotification(_ notif: Notification){
        do{
            try db.collection("notifications").addDocument(from: notif)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
}
