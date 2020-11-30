//
//  CoreBLE.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-22.
//

import Foundation
import CoreBluetooth
import CoreLocation
import UIKit


// global beacon constraint variables
let uuid = UUID(uuidString: CBUUID.iBeaconUUID!.uuidString)
let beaconCons = CLBeaconIdentityConstraint(uuid: uuid!, major: 34987, minor:1025)
let beaconRegion = CLBeaconRegion(uuid: uuid!, major: 34987, minor: 1025, identifier: "MyBeacon")

class phoneBeaconIF_VM: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    // global notifications list
    var notifications_list:[Notification]
    
    @Published var notificationRepo = notificationRepository()
    var locationManager: CLLocationManager!
    var beaconDistance: CLProximity
    
    init(beaconDistance: CLProximity = .unknown){
        print("We are here!")
        self.beaconDistance = beaconDistance
        self.locationManager = CLLocationManager()
        self.notifications_list = [Notification]()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        //        startScanning()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("WE GOT TO HEREREEEEEEEEEEEEEEEE")
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        //        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconCons)
        //        locationManager.startRangingBeacons(in: beaconRegion)
        print("WE GOT TO HEREREEEEEEEEEEEEEEEE")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    //    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    //        for i in 0..<beacons.count{ //iterate through multiple beacons.
    //            print("Found Location!")
    //            print("Beacons count: \(beacons.count)")
    //            print("My beacon: \(beacons[i].description)")
    //            beaconDistance = (beacons[i].proximity)
    //            print("My beacon distance is: \(beacons[i].accuracy)" )
    //            switch beaconDistance {
    //            case .immediate, .near:
    //                //MARK:Sent to Firebase
    //                let add = Notification(id: phone_id, beacon_UUID: beaconRegion.uuid.uuidString, major: beaconRegion.major!.intValue, minor: beaconRegion.minor!.intValue, test_result: false, distance: beacons[i].accuracy)
    //                notificationRepo.addNotification(add)
    //                break
    //            default:
    //                //Do nothing
    //                print("Not Close enough!")
    //            }
    //        }
    
    
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        var count = 0
        for i in 0..<beacons.count{ //iterate through multiple beacons.
            print("Found Location!")
            print("Beacons count: \(beacons.count)")
            print("My beacon: \(beacons[i].description)")
            beaconDistance = (beacons[i].proximity)
//            print("My beacon distance is: \(beacons[i].accuracy)" )
            switch beaconDistance {
            case .immediate, .near, .far:
                //MARK:Sent to Firebase
                let add = Notification(id: phone_id, beacon_UUID: beaconConstraint.uuid.uuidString, major: Int(beaconConstraint.major!.magnitude), minor: Int(beaconConstraint.minor!.magnitude), test_result: false, distance: beacons[i].accuracy, proximity: beacons[i].proximity.rawValue)
                if (notifications_list.count < 1 && add.proximity != 3) {
                    notifications_list.append(add)
                    notificationRepo.addNotification(add)
                
                    
                }
                if (beacons[i].proximity.rawValue != notifications_list.last?.proximity && count<1) {
                    notifications_list.append(add)
                    notificationRepo.addNotification(add)
                    print("Person left the beacon!")
                    count += 1
                }
                break
            default:
                //Do nothing
                print("Not Close enough!")
            }
            
        }
    }
    //Mark: Error Handling
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
}



class coreBLE_VM: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate{
    private(set) var empData : UIdata! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
    }
    
    
    var centralManager: CBCentralManager?
    var peripheralTester: CBPeripheral?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Bluetooth status is UNKNOWN")
        case .resetting:
            print("Bluetooth status is RESETTING")
        case .unsupported:
            print("Bluetooth status is UNSUPPORTED")
        case .unauthorized:
            print("Bluetooth status is UNAUTHORIZED")
        case .poweredOff:
            print("Bluetooth status is POWERED OFF")
        case .poweredOn:
            print("Bluetooth status is POWERED ON")
            DispatchQueue.main.async { () -> Void in
                //                self.connectingActivityIndicator.startAnimating()
                //                self.searchingMessage.text = "Searching for my board...."
            }
            // STEP 3.2: scan for peripherals that we're interested in
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
            
        @unknown default:
            print("UNKNOWN BLUETOOTH ERROR");
            exit(0);
        } // END switch
    }
    // STEP 4.1: discover what peripheral devices OF INTEREST
    // are available for this app to connect to
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name != nil else {
            return
        }
        print((peripheral.name!))
        print(peripheral.identifier)
        //        decodePeripheralState(peripheralState: peripheral.state)
        if ((peripheral.name?.contains("Thunderboard")) ?? false){
            print("Found my board!")
            //            self.centralManager?.stopScan()
        }
        
    } // END func centralManager(... didDiscover peripheral
    
    
}

