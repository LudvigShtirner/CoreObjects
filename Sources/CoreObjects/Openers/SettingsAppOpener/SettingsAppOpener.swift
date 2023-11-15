//
//  SettingsAppOpener.swift
//  
//
//  Created by Алексей Филиппов on 20.01.2023.
//

// Apple
import UIKit

public protocol SettingsAppOpener: URLOpener {
    func openAppSettings()
}

public extension SettingsAppOpener {
    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        openURL(url)
    }
}
