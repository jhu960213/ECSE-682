//
//  ViewController.swift
//  Read_Write
//
//  Created by Hamza Mian on 2020-12-11.
//


import UIKit
import CoreBluetooth
import Foundation


class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
    @IBOutlet weak var searchingMessage: UILabel!
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }
        characteristics.forEach({
            switch $0.uuid {
                default:
                    // read all supported values
                    if $0.tb_supportsRead() {
                        peripheral.readValue(for: $0)
                    }
            }
        })
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("Bluetooth status is UNKNOWN")
            //                    bluetoothOffLabel.alpha = 1.0
            case .resetting:
                print("Bluetooth status is RESETTING")
            //                    bluetoothOffLabel.alpha = 1.0
            case .unsupported:
                print("Bluetooth status is UNSUPPORTED")
            //                    bluetoothOffLabel.alpha = 1.0
            case .unauthorized:
                print("Bluetooth status is UNAUTHORIZED")
            //                    bluetoothOffLabel.alpha = 1.0
            case .poweredOff:
                print("Bluetooth status is POWERED OFF")
            //                    bluetoothOffLabel.alpha = 1.0
            case .poweredOn:
                print("Bluetooth status is POWERED ON")
                DispatchQueue.main.async { () -> Void in
                    //                self.connectingActivityIndicator.startAnimating()
                    self.searchingMessage.text = "Searching for my board...."
                }
            // STEP 3.2: scan for peripherals that we're interested in
            //            centralManager?.scanForPeripherals(withServices: nil, options: nil)
            
            @unknown default:
                print("UNKNOWN BLUETOOTH ERROR");
                exit(0);
        } // END switch
    }
    
    
    @IBOutlet weak var writeText: UITextField!
    
    @IBOutlet weak var readText: UILabel!
    
    @IBAction func readClick(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension CBCharacteristicProperties : CustomStringConvertible {
    public var description : String {
        let strings = [
            "Broadcast",
            "Read",
            "WriteWithoutResponse",
            "Write",
            "Notify",
            "Indicate",
            "AuthenticatedSignedWrites",
            "ExtendedProperties",
            "NotifyEncryptionRequired",
            "IndicateEncryptionRequired",
        ]
        
        var propertyDescriptions = [String]()
        for (index, string) in strings.enumerated() where contains(CBCharacteristicProperties(rawValue: UInt(1 << index))) {
            propertyDescriptions.append(string)
        }
        
        return propertyDescriptions.description
    }
}
extension CBCharacteristic {
    
    func tb_supportsNotificationOrIndication() -> Bool {
        let notification = self.properties.rawValue & CBCharacteristicProperties.notify.rawValue != 0
        let indication = self.properties.rawValue & CBCharacteristicProperties.indicate.rawValue != 0
        
        return notification || indication
    }
    
    func tb_supportsRead() -> Bool {
        return self.properties.rawValue & CBCharacteristicProperties.read.rawValue != 0
    }
    
    func tb_supportsWrite() -> Bool {
        return self.properties.rawValue & CBCharacteristicProperties.write.rawValue != 0
    }
    
    func tb_int8Value() -> Int8? {
        if let data = self.value {
            var byte: Int8 = 0
            (data as NSData).getBytes(&byte, length: 1)
            
            return byte
        }
        
        return nil
    }
    
    func tb_int32Value() -> Int32? {
        if let data = self.value {
            var value: Int32 = 0
            (data as NSData).getBytes(&value, length: 4)
            return value
        }
        
        return nil
    }
    
    func tb_uint8Value() -> UInt8? {
        if let data = self.value {
            var byte: UInt8 = 0
            (data as NSData).getBytes(&byte, length: 1)
            
            return byte
        }
        
        return nil
    }
    
    func tb_int16Value() -> Int16? {
        if let data = self.value {
            var value: Int16 = 0
            (data as NSData).getBytes(&value, length: 2)
            
            return value
        }
        
        return nil
    }
    
    func tb_uint16Value() -> UInt16? {
        if let data = self.value {
            var value: UInt16 = 0
            (data as NSData).getBytes(&value, length: 2)
            
            return value
        }
        
        return nil
    }
    
    func tb_uint32Value() -> UInt32? {
        if let data = self.value {
            var value: UInt32 = 0
            (data as NSData).getBytes(&value, length: 4)
            return value
        }
        
        return nil
    }
    
    func tb_uint64value() -> UInt64? {
        if let data = self.value {
            var value: UInt64 = 0
            (data as NSData).getBytes(&value, length: 8)
            return value
        }
        
        return nil
    }
    
    func tb_stringValue() -> String? {
        if let data = self.value {
            return String(data: data, encoding: String.Encoding.utf8)
        }
        
        return nil
    }
    
    func tb_hexStringValue() -> String? {
        guard let data = self.value else {
            return nil
        }
        
        let len = data.count
        let result = NSMutableString(capacity: len*2)
        var byteArray = [UInt8](repeating: 0x0, count: len)
        (data as NSData).getBytes(&byteArray, length:len)
        for (index, element) in byteArray.enumerated() {
            if index % 8 == 0 && index > 0 {
                result.appendFormat("\n")
            }
            result.appendFormat("%02x ", element)
        }
        
        return String(result)
    }
    
    //    func tb_hexDump() {
    //        if let hex = self.tb_hexStringValue() {
    //            log.debug("\(hex)")
    //        }
    //    }
    
}
