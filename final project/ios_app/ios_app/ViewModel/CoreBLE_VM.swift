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

class beacon_VM: NSObject{
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    
    init(name: String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int) {
        //      self.name = name
        //      self.icon = icon
        //      self.uuid = uuid
        self.majorValue = CLBeaconMajorValue(majorValue)
        self.minorValue = CLBeaconMinorValue(minorValue)
    }
}

class phoneBeaconIF_VM: NSObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    var beaconDistance: CLProximity
    
    init(beaconDistance: CLProximity = .unknown){
        self.beaconDistance = beaconDistance
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        //        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconCons = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconCons)
        //        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        for i in 0..<beacons.count{ //iterate through multiple beacons.
            beaconDistance = (beacons[i].proximity)
            switch beaconDistance {
            case .immediate, .near:
                //add to Firebase
                //var timestamp: Date(
                break
            default:
                //Do nothing
                print("Not Close enough!")
            }
        }
        
        
        //TODO: Send this to FireBase
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
