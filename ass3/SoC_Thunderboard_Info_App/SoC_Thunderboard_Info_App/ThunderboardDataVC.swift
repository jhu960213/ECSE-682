//
//  ThunderboardDataVC.swift
//  SoC_Thunderboard_Info_App
//
//  Created by Jack Hu on 2020-11-07.
//

import UIKit
import CoreBluetooth

class ThunderboardDataVC: UIViewController,CBPeripheralDelegate, CBCentralManagerDelegate{
    
    // outlets
    var centralManager: CBCentralManager?
    var peripheralAccelerometer: CBPeripheral?
    @IBOutlet weak var connectingActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectingActivityIndicator.backgroundColor = UIColor.white
        connectingActivityIndicator.startAnimating()
        // Do any additional setup after loading the view.
        // create a concurrent background queue for the central
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.iosbrain.centralQueueName", attributes: .concurrent)
        // Central scans for, connects to, manages, and collects data from peripherals
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
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
                //                        self.bluetoothOffLabel.alpha = 0.0
                self.connectingActivityIndicator.startAnimating()
            }
            
            // STEP 3.2: scan for peripherals that we're interested in
            centralManager?.scanForPeripherals(withServices: [CBUUID.AccelerationMeasurement])
            
        @unknown default:
            print("UNKNOWN BLUETOOTH ERROR");
            exit(0);
        } // END switch
    }
    // STEP 4.1: discover what peripheral devices OF INTEREST
    // are available for this app to connect to
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(peripheral.name!)
        decodePeripheralState(peripheralState: peripheral.state)
        // STEP 4.2: MUST store a reference to the peripheral in
        // class instance variable
        peripheralAccelerometer = peripheral
        peripheralAccelerometer?.delegate = self
        centralManager?.stopScan()    // re-scan if disconnected
        centralManager?.connect(peripheralAccelerometer!)
        
    } // END func centralManager(... didDiscover peripheral
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!");
        peripheralAccelerometer?.discoverServices(nil)
        
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("disconnected!");
        
        DispatchQueue.main.async { () -> Void in
            //TODO: Add Cleared labels here!
        }
        centralManager?.scanForPeripherals(withServices: [CBUUID.AccelerationMeasurement])
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for service in peripheral.services! {
            
            if service.uuid == CBUUID.AccelerationMeasurement {
                
                print("Service: \(service)")
                
                // STEP 9: look for characteristics of interest
                // within services of interest
                peripheral.discoverCharacteristics(nil, for: service)
                
            }
            
        }
        
    } // END func peripheral(... didDiscoverServices
    
    // STEP 10: confirm we've discovered characteristics
    // of interest within services of interest
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        for characteristic in service.characteristics! {
            print(characteristic)
            
            if characteristic.uuid == CBUUID.AccelerationMeasurement {
                
                // STEP 11: subscribe to a single notification
                // for characteristic of interest;
                // "When you call this method to read
                // the value of a characteristic, the peripheral
                // calls ... peripheral:didUpdateValueForCharacteristic:error:
                //
                // Notify    Mandatory
                //MARK: Add Read value if you must.
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
        } // END for
        
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
                
                UIView.animate(withDuration: 1.0, animations: {
                    //MARK: Write LABEL Values here.
                    //                       self.beatsPerMinuteLabel.alpha = 1.0
                    //                       self.beatsPerMinuteLabel.text = String(heartRate)
                }, completion: { (true) in
                    //                       self.beatsPerMinuteLabel.alpha = 0.0
                })
                
            } // END DispatchQueue.main.async...
            
        } // END if characteristic.uuid ==...
        
        
    }
    
    
    
    
    //Adapted from Silabs ThunderBoard App Code.
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
