//
//  ThunderboardDataVC.swift
//  SoC_Thunderboard_Info_App
//
//  Created by Jack Hu on 2020-11-07.
//

import UIKit
import CoreBluetooth
import Foundation


class ThunderboardDataVC: UIViewController,CBPeripheralDelegate, CBCentralManagerDelegate{
    
    // outlets corebluetooth central and peripherals managers
    @IBOutlet weak var myTemp: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var searchingMessage: UILabel!
    @IBOutlet weak var accelX: UILabel!
    @IBOutlet weak var accelY: UILabel!
    @IBOutlet weak var accelZ: UILabel!
    var centralManager: CBCentralManager?
    var peripheralAccelerometer: CBPeripheral?
    @IBOutlet weak var connectingActivityIndicator: UIActivityIndicatorView!
    // local variables
    var stepCounts: Int = -1
    var lightCharacteristic: CBCharacteristic? = nil
    fileprivate var ledMask: UInt8    = 0
    fileprivate let digitalBits       = 2
    
    
    // Adapted from medium Mac O'Clock
    func setDigitalOutput(_ index: Int, _ on: Bool, _ characteristic:CBCharacteristic) {
      let shift = UInt(index) * UInt(digitalBits)
      var mask = ledMask
      if on {
        mask = mask | UInt8(1 << shift)
      }
        else {
        mask = mask & ~UInt8(1 << shift)
      }
      let data = Data(_: [mask])
        self.peripheralAccelerometer?.writeValue(data, for: characteristic, type: .withResponse)
       ledMask = mask
    }
    
    func disconnect() {
        centralManager?.cancelPeripheralConnection(peripheralAccelerometer!)
        self.connectingActivityIndicator.startAnimating()
        self.searchingMessage.text = "Searching for my board...."
        stepCount.text = ""
        myTemp.text = ""
    }
    
    func connect() {
        // create a concurrent background queue for the central
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        // Central scans for, connects to, manages, and collects data from peripherals
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    // connect to board after click
    @IBAction func connectButtonPress(_ sender: UIButton) {
        connect()
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ) {
            sender.alpha = 1.0
        }
    }
    
    // async disconnect from board
    @IBAction func disconnectButtonPress(_ sender: UIButton) {
        disconnect()
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ) {
            sender.alpha = 1.0
        }
    }
    
    // Turning our light on and off on the board
    @IBAction func lightSwitch(_ sender: UISwitch) {
        setDigitalOutput(0, sender.isOn, lightCharacteristic!)
    }
    
    // lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        connectingActivityIndicator.isHidden = true
        // Setting the initial acceleration values to be 0
        self.connectingActivityIndicator.backgroundColor = UIColor.lightGray
        self.connectingActivityIndicator.startAnimating()
        self.stepCounts = 0
        self.accelX.text = ""
        self.accelY.text = ""
        self.accelZ.text = ""
        self.stepCount.text = "0"
        self.myTemp.text = "0"
        // Do any additional setup after loading the view.
        self.connectingActivityIndicator.startAnimating()
        self.searchingMessage.text = "Searching for my board...."
        
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
                self.connectingActivityIndicator.startAnimating()
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
        print(peripheral.name!)
        print(peripheral.identifier)
        decodePeripheralState(peripheralState: peripheral.state)
        if ((peripheral.name?.contains("Thunderboard")) ?? false){
            print("Found my board!")
            self.peripheralAccelerometer = peripheral
            self.peripheralAccelerometer?.delegate = self
            self.centralManager?.stopScan()
            self.centralManager?.connect(peripheralAccelerometer!)
        }
        
    } // END func centralManager(... didDiscover peripheral
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async { () -> Void in
            self.connectingActivityIndicator.stopAnimating()
            self.searchingMessage.text = "Connected to my board!"
            self.accelX.text = "0g"
            self.accelY.text = "0g"
            self.accelZ.text = "0g"
        }
        // discover all services
        print("Discovering all  services!....");
        self.peripheralAccelerometer?.discoverServices([CBUUID.InertialMeasurement, CBUUID.EnvironmentalSensing, CBUUID.AutomationIO])
        self.peripheralAccelerometer?.delegate = self
    }
    
    // In the case the board is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from my board!");
        DispatchQueue.main.async { () -> Void in
            self.searchingMessage.text = "Searching for my board...."
            self.accelX.text = ""
            self.accelY.text = ""
            self.accelZ.text = ""
            self.connectingActivityIndicator.startAnimating()
        }
        self.centralManager?.scanForPeripherals(withServices: [CBUUID.InertialMeasurement, CBUUID.EnvironmentalSensing, CBUUID.AutomationIO])
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
                if service.uuid == CBUUID.InertialMeasurement {
                    // by setting it to be nil its going to discover all characteristics
                    print("My desired service: \(service.description)\n")
                    peripheral.discoverCharacteristics(nil, for: service)
                }
                
                // we want only to discover the characteristics of my EnvironmentSensing Service
                if service.uuid == CBUUID.EnvironmentalSensing {
                    // by setting it to be nil its going to discover all characteristics
                    print("My desired service: \(service.description)\n")
                    peripheral.discoverCharacteristics(nil, for: service)
                }
                
                // we want only to discover the characteristics of my AutomationIO Service
                if service.uuid == CBUUID.AutomationIO {
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
                if characteristic.uuid == CBUUID.AccelerationMeasurement {
                    print("My desired characteristic: \(characteristic.description)\n")
                    peripheral.setNotifyValue(true, for: characteristic)
                }
                
                if characteristic.uuid == CBUUID.Temperature {
                    print("My desired characteristic: \(characteristic.description)\n")
                    peripheral.readValue(for: characteristic)
//                    peripheral.setNotifyValue(true, for: characteristic)
                }
                
                if characteristic.uuid == CBUUID.Digital {
                    print("My desired characteristic: \(characteristic.description)\n")
                    self.lightCharacteristic = characteristic
                }
                
            }
        }
        
    } // END func peripheral(... didDiscoverCharacteristicsFor service
    
    // STEP 12: we're notified whenever a characteristic
    // value updates regularly or posts once; read and
    // decipher the characteristic value(s) that we've
    // subscribed to
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        // for acceleration
        if characteristic.uuid == CBUUID.AccelerationMeasurement {
            // STEP 13: we generally have to decode BLE
            // data into human readable format
            let acc_data = tb_vectorValue(using: characteristic)
            DispatchQueue.main.async { () -> Void in
                //MARK: Write LABEL Values here.
                self.accelX.text = String((acc_data?.x)!) + "g"
                self.accelY.text = String((acc_data?.y)!) + "g"
                self.accelZ.text = String((acc_data?.z)!) + "g"
//                print("X is \(self.accelX.text!)")
//                print("Y is \(self.accelY.text!)")
//                print("Z is \(self.accelZ.text!)")
                let x_data = Double((acc_data?.x)!).magnitude
                let y_data = Double((acc_data?.y)!).magnitude
                let z_data = Double((acc_data?.z)!).magnitude
                    
                if x_data + y_data + z_data > 2.0 || x_data > 1.4 || y_data > 1.4 || z_data > 1.4{
                    self.stepCounts  = self.stepCounts + 1
                    print("stepCounts is \(self.stepCounts)")
                    self.stepCount.text = String(self.stepCounts)
                }
            } // END DispatchQueue.main.async...
        } // END if characteristic.uuid ==...
        
        // for temperature
        if characteristic.uuid == CBUUID.Temperature {
            let tempCel = characteristic.tb_int16Value()
            // have to update the UI labels in the main thread...no clue why but it had to be done in this way or else it wont work
            print("My current temperature is: \(Double(tempCel!) / 100)")
            DispatchQueue.main.async { () -> Void in
                self.myTemp.text = String(Double(tempCel!) / 100) + " C"
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
            print("WRITE VALUE : \(characteristic)")
    }
    
    
    // Adapted from Silabs ThunderBoard App Code.
    func tb_vectorValue(using accelerometerMeasurementCharacteristic: CBCharacteristic) -> accelerometer_data? {
        if let data = accelerometerMeasurementCharacteristic.value{
            if data.count >= 6 {
                var xAccelerationTimes1k: Int16 = 0;
                var yAccelerationTimes1k: Int16 = 0;
                var zAccelerationTimes1k: Int16 = 0;
                (data as NSData).getBytes(&xAccelerationTimes1k, range: NSMakeRange(0, 2))
                (data as NSData).getBytes(&yAccelerationTimes1k, range: NSMakeRange(2, 2))
                (data as NSData).getBytes(&zAccelerationTimes1k, range: NSMakeRange(4, 2))
                let xAcceleration = α(xAccelerationTimes1k) / 1000.0;
                let yAcceleration = α(yAccelerationTimes1k) / 1000.0;
                let zAcceleration = α(zAccelerationTimes1k) / 1000.0;
                return accelerometer_data(x: xAcceleration, y: yAcceleration, z: zAcceleration)
            }
        }
        return nil
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
}

extension CBCharacteristic  {
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
}



