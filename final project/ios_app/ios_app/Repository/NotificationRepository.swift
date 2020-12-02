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
                    //TODO: Change UI HERE in MAIN View Controller
                    // getting the queried snap shot of the document info
                    let data = querySnapshot.data()
                    //                    let result = data!["test_result"]
                    print("CALLED LISTENER for \(data)")
                    // updating the UI....not sure if this is the correct way to do it
                    //                    callEvent(result! as! Bool)
                    
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
        print("we are POSSS TESTTTTTT")
        
        db.collection("notifications").whereField("id", isEqualTo: phone_id).getDocuments() { [self] (querySnapshot, err) in
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
        print("INIT TIME IS: \(String(describing: notifData.createdTime))")
        if let time = notifData.createdTime{
            let endTime = Timestamp.init(date: (time.dateValue()) + 500)
            print("TIME IS: \(endTime)")
            db.collection("notifications").whereField("id", isNotEqualTo: notifData.id).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("STUFF: \(document.documentID) => \(document.data())")
                        let result = Result {
                            try document.data(as: Notification.self)
                        }
                        switch result {
                            case .success(let otherData):
                                if let otherData = otherData {
                                    if((abs((otherData.createdTime?.compare(time).rawValue)!))<300 && otherData.major == notifData.major && otherData.minor == notifData.minor && otherData.test_result == false){
                                        self.db.collection("notifications").document(document.documentID).updateData(["test_result": true]) { (err) in
                                            print("Encountered Error \(String(describing: err?.localizedDescription))")
                                        }
                                    }
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
    }
    
}

