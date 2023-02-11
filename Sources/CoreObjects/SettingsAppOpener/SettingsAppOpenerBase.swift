//
//  SettingsAppOpenerBase.swift
//  
//
//  Created by Алексей Филиппов on 20.01.2023.
//

// Apple
import UIKit

final class SettingsAppOpenerBase: SettingsAppOpener, URLOpener {
    // MARK: - URLOpener
    var application: UIApplication
    
    // MARK: - Life cycle
    init(application: UIApplication) {
        self.application = application
    }
    
    // MARK: - SettingsAppOpener
    func openAppSettings() {
        precondition(Thread.isMainThread)
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        openURL(url)
    }
}
