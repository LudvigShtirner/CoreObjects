//
//  BluetoothWrapper.swift
//  
//
//  Created by Алексей Филиппов on 25.04.2023.
//

// Apple
import Foundation

public protocol BluetoothWrapper: AnyObject {
    var peripheralNames: [String] { get }
}
