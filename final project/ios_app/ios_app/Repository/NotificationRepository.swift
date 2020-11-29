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
    var numCalls = -1
    let db = Firestore.firestore()
    @Published var notifications = [Notification]()
    
    func loadData(){ //Don't think we need to load Data, actually just send Notif when Pos test, and addNotification.
        //MARK:Here we can add a listener for a Positive result, that can change the UI.
        
        db.collection("notifications").whereField("device_id", isEqualTo: phone_id).order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot =  querySnapshot {
                self.notifications = querySnapshot.documents.compactMap{ document in
                    try? document.data(as: Notification.self)
                }
            }
        }
    }
    
    func addNotification(_ notif: Notification){
        do{
            try db.collection("notifications").addDocument(from: notif).addSnapshotListener({ (querySnapshot, error) in
                if let querySnapshot =  querySnapshot {
                    self.numCalls += 1
                    if (self.numCalls>=0){
                        //TODO: Change UI HERE in MAIN View Controller
                    }
                }
            })
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateNotification(_ notif: Notification){ //MARK: update This during COVID test
        if let notifID = notif.docID {
            do{
                try db.collection("notifications").document(notifID).setData(from: notif)
            }catch{
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    func pos_test(){
        db.collection("notifications").whereField("device_id", isEqualTo: phone_id).getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for documenty in querySnapshot!.documents {
                    //FOR updating this DATA
                    db.collection("notifications").document(documenty.documentID).updateData([
                        "test_result": true
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                    //________________For updating other data___________________
                    let result = Result {
                        try documenty.data(as: Notification.self)
                    }
                    switch result {
                        case .success(let notif):
                            if let notif = notif {
                                update_others(notifData: notif)
                            }else {
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            print("Error decoding Notification: \(error)")
                    }
                    
                }
            }
        }
    }
    func update_others(notifData: Notification){
        if let time = notifData.createdTime{
            let endtime = Timestamp.init(seconds: time.seconds+300, nanoseconds: 0)
            db.collection("notifications").whereField("createdTime", isGreaterThan: notifData.createdTime!).whereField("createdTime", isLessThan: endtime).whereField("major", isEqualTo: notifData.major).whereField("minor", isEqualTo: notifData.minor).whereField("distance", isGreaterThanOrEqualTo: 1).getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for documenty in querySnapshot!.documents {
                        db.collection("notifications").document(documenty.documentID).updateData([
                            "test_result": true
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
            }
        }
    }
    
}
