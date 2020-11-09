//
//  BLEdevice.swift
//  SoC_Thunderboard_Info_App
//
//  Created by Hamza Mian on 2020-11-09.
//

import Foundation
import CoreBluetooth

class BleDevice : NSObject, CBPeripheralDelegate, CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        <#code#>
    }
    var centralManager: CBCentralManager?
    var peripheralHeartRateMonitor: CBPeripheral?
    
    
}
