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
    
    @IBOutlet weak var stepCount: UILabel!
    @IBOutlet weak var searchingMessage: UILabel!
    @IBOutlet weak var accelX: UILabel!
    @IBOutlet weak var accelY: UILabel!
    @IBOutlet weak var accelZ: UILabel!
    var centralManager: CBCentralManager?
    var peripheralAccelerometer: CBPeripheral?
    @IBOutlet weak var connectingActivityIndicator: UIActivityIndicatorView!
    var stepCounts: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        connectingActivityIndicator.isHidden = true
        // Setting the initial acceleration values to be 0
        connectingActivityIndicator.backgroundColor = UIColor.lightGray
        connectingActivityIndicator.startAnimating()
        stepCounts = 0
        self.accelX.text = ""
        self.accelY.text = ""
        self.accelZ.text = ""
        // Do any additional setup after loading the view.
        // create a concurrent background queue for the central
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        // Central scans for, connects to, manages, and collects data from peripherals
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
        
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
        peripheralAccelerometer?.delegate = self
        centralManager?.stopScan()
        centralManager?.connect(peripheralAccelerometer!)
            
        }
        
    } // END func centralManager(... didDiscover peripheral
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async { () -> Void in
            self.connectingActivityIndicator.stopAnimating()
            self.searchingMessage.text = "Connected to my board!"
            self.accelX.text = "0"
            self.accelY.text = "0"
            self.accelZ.text = "0"
        }
        // discover all services
        print("Discovering all  services!....");
        peripheralAccelerometer?.discoverServices([CBUUID.InertialMeasurement])
        peripheralAccelerometer?.delegate = self
        
    }
    
    // In the case the board is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from the board!");
        DispatchQueue.main.async { () -> Void in
            self.searchingMessage.text = "Searching for my board...."
            self.accelX.text = ""
            self.accelY.text = ""
            self.accelZ.text = ""
            self.connectingActivityIndicator.startAnimating()
        }
        centralManager?.scanForPeripherals(withServices: [CBUUID.InertialMeasurement])
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
                    print("My desired service: \(service.description)")
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
                    print("My desired characteristic: \(characteristic.description)")
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
        
    } // END func peripheral(... didDiscoverCharacteristicsFor service
    
    // STEP 12: we're notified whenever a characteristic
    // value updates regularly or posts once; read and
    // decipher the characteristic value(s) that we've
    // subscribed to
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == CBUUID.AccelerationMeasurement {
            // STEP 13: we generally have to decode BLE
            // data into human readable format
            let acc_data = tb_vectorValue(using: characteristic)
            DispatchQueue.main.async { () -> Void in
                UIView.animate(withDuration: 1.0, animations: { [self] in
                    //MARK: Write LABEL Values here.
                    self.accelX.text = String((acc_data?.x)!)
                    self.accelY.text = String((acc_data?.y)!)
                    self.accelZ.text = String((acc_data?.z)!)
                    print("X is \(self.accelX.text!)")
                    print("Y is \(self.accelY.text!)")
                    print("Z is \(self.accelZ.text!)")
                    let x_data = Double((acc_data?.x)!).magnitude
                    let y_data = Double((acc_data?.y)!).magnitude
                    let z_data = Double((acc_data?.z)!).magnitude
                    
                    if x_data + y_data + z_data > 2.0 || x_data > 1.4 || y_data > 1.4 || z_data > 1.4{
                        self.stepCounts  = self.stepCounts + 1
                        print("stepCounts is \(stepCounts)")
                        self.stepCount.text = String(stepCounts)
                    }
                })
            } // END DispatchQueue.main.async...
        } // END if characteristic.uuid ==...
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



