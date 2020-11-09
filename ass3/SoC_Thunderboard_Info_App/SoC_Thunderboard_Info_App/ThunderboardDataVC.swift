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
//            decodePeripheralState(peripheralState: peripheral.state)
            // STEP 4.2: MUST store a reference to the peripheral in
            // class instance variable
            peripheralAccelerometer = peripheral
            // STEP 4.3: since HeartRateMonitorViewController
            // adopts the CBPeripheralDelegate protocol,
            // the peripheralHeartRateMonitor must set its
            // delegate property to HeartRateMonitorViewController
            // (self)
            peripheralAccelerometer?.delegate = self
            
            // STEP 5: stop scanning to preserve battery life;
            // re-scan if disconnected
            centralManager?.stopScan()
            
            // STEP 6: connect to the discovered peripheral of interest
            centralManager?.connect(peripheralAccelerometer!)
            
        } // END func centralManager(... didDiscover peripheral
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!");
        peripheralAccelerometer?.discoverServices(nil)
    }
    
        
    
    
}


