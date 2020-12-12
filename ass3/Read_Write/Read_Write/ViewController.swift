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
    
    // peripherals and central managers
    var isConnected: Bool = false
    var centralManager: CBCentralManager?
    var peripheralAccelerometer: CBPeripheral?
    @IBOutlet weak var searchingMessage: UILabel!
    @IBOutlet weak var writeText: UITextField!
    @IBOutlet weak var readText: UILabel!
    var otaDataCharacteristic: CBCharacteristic? = nil
    // converts string into utf-8 encoded bytes
//    fileprivate var value = String(describing: "hello".cString(using: String.Encoding.utf8))
//    let input = "hello"
    
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let characteristics = service.characteristics else {
//            return
//        }
//        characteristics.forEach({
//            switch $0.uuid {
//                default:
//                    // read all supported values
//                    if $0.tb_supportsRead() {
//                        peripheral.readValue(for: $0)
//                    }
//            }
//        })
//    }
    
    // write to board
    func writeToBoard(_ input:String, _ characteristic:CBCharacteristic) {
        let data = input.data(using: .utf8)!
        self.peripheralAccelerometer?.writeValue(data, for: characteristic, type: .withResponse)
    }
    
    // read from board
    func readFromBoard(_ characteristic:CBCharacteristic) {
        print("My desired characteristic: \(characteristic.description)\n")
        self.peripheralAccelerometer?.readValue(for: characteristic)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        // I'm writing
        if isConnected{
            if sender.tag == 0{
                // the input text must be 5 characters or less
                let input = self.writeText.text!
                writeToBoard(input, otaDataCharacteristic!)
                self.writeText.text = ""
            // I'm reading
            } else {
                readFromBoard(otaDataCharacteristic!)
            }
        }
    }
    
    
    //
    // CBCentralManagerDelegate methods
    //
    
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
                self.searchingMessage.text = "Searching for my board...."
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
        decodePeripheralState(peripheralState: peripheral.state)
        if ((peripheral.name?.contains("HAMZA'S BOARD")) ?? false){
            print("Found my board!")
            self.peripheralAccelerometer = peripheral
            self.peripheralAccelerometer?.delegate = self
            self.centralManager?.stopScan()
            self.centralManager?.connect(peripheralAccelerometer!)
        }
        
    } // END func centralManager(... didDiscover peripheral
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async { () -> Void in
            self.searchingMessage.text = "Connected to my board!"
        } // END DispatchQueue.main.async...
        // discover all services
        isConnected = true
        print("Discovering the OTA Service!....");
        self.peripheralAccelerometer?.discoverServices([CBUUID.otaService])
        self.peripheralAccelerometer?.delegate = self
    }
    
    // In the case the board is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        print("Disconnected from my board!");
        DispatchQueue.main.async { () -> Void in
            self.searchingMessage.text = "Searching for my board...."
        } // END DispatchQueue.main.async...
        self.centralManager?.scanForPeripherals(withServices: [CBUUID.otaService])
        print("Scanning for Periphs")
    }
    
    //
    // CBPeripheralDelegate Methods
    //
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            // now to discover characteristics for each service
            for service in services {
                // we want only to discover the characteristics of my InertialMeasurement Service
                if service.uuid == CBUUID.otaService {
                    // by setting it to be nil its going to discover all characteristics
                    print("My desired service: \(service.description)\n")
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    } // END func peripheral(... didDiscoverServices
    
    // STEP 10: confirm we've discovered characteristics
    // of interest within services of interest
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let charac = service.characteristics {
            for characteristic in charac {
                if characteristic.uuid == CBUUID.otaData {
                    print("My desired characteristic: \(characteristic.description)\n")
                    self.otaDataCharacteristic = characteristic
                }
                
            }
        }
        
    }
    
    // STEP 12: we're notified whenever a characteristic
    // value updates regularly or posts once; read and
    // decipher the characteristic value(s) that we've
    // subscribed to
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        // for temperature
        if characteristic.uuid == CBUUID.otaData {
            let readValue = characteristic.tb_stringValue()
            // have to update the UI labels in the main thread...no clue why but it had to be done in this way or else it wont work
            DispatchQueue.main.async { () -> Void in
                self.readText.text = readValue
            } // END DispatchQueue.main.async...
            
            
        }
    }
    
    
    
    // END func peripheral(... didDiscoverCharacteristicsFor service
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("WROTE VALUE: \(characteristic) to the OTA data characteristic of the baord!")
    }
    
    
    // application starts here
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set how the textfield repond to user input actions using UITextFiled protocols
        // So class (UI view controller) has to implement the UITextFieldDelegate functions
        // Allows dismissing keyboard when tapping anywhere on the view controller
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        self.readText.text = "Nothing so far"
        self.searchingMessage.text = "Searching for my board...."
        self.view.backgroundColor = UIColor.gray
        
        // create a concurrent background queue for the central
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        // Central scans for, connects to, manages, and collects data from peripherals
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    //MARK: HouseKeeping, in case of disconnects:
    func decodePeripheralState(peripheralState: CBPeripheralState) {
        switch peripheralState {
        case .disconnected:
            print("Peripheral state: disconnected")
        case .connected:
            print("Peripheral state: connected")
        case .connecting:
            print("Peripheral state: connecting")
        case .disconnecting:
            print("Peripheral state: disconnecting")
        @unknown default:
            print("Unknown Peripheral state!")
            exit(0);
        }
        
    } // END func decodePeripheralState(peripheralState
    
    func hideKeyBoard() {
        self.writeText.resignFirstResponder()
    }
    
    // UITextFieldDelegate methods - they are optional to implement but I will only implement one of them in order to make keyboard disappear upon touch return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // textfiled relinquish first responder status and returns to view controller and hides keyboard when return button is pressed
        hideKeyBoard()
        return true
    }
}

// extension to our view controller and characteristics etc
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
