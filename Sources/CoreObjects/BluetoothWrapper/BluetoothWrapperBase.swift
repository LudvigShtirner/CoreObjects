//
//  BluetoothWrapperBase.swift
//  
//
//  Created by Алексей Филиппов on 25.04.2023.
//

// Apple
import Foundation
import CoreBluetooth

final class BluetoothWrapperBase: NSObject, BluetoothWrapper {
    // MARK: - Dependencies
    private let centralManager: CBCentralManager
    
    // MARK: - Data
    private var peripherals: [CBPeripheral] = []
    
    // MARK: - Inits
    override init() {
        centralManager = CBCentralManager(delegate: nil, queue: .main)
        super.init()
        centralManager.delegate = self
    }
    
    // MARK: - BluetoothWrapper
    var peripheralNames: [String] {
        peripherals.map { $0.name ?? "Unnamed device with id: \($0.identifier.uuidString)"}
    }
}

extension BluetoothWrapperBase: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
        }
    }
}
