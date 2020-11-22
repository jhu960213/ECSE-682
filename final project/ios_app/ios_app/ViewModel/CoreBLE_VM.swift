//
//  CoreBLE.swift
//  ios_app
//
//  Created by Hamza Mian on 2020-11-22.
//

import Foundation
import CoreBluetooth
import UIKit

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
