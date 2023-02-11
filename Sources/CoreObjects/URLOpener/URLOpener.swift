//
//  URLOpener.swift
//  
//
//  Created by Алексей Филиппов on 20.01.2023.
//

// Apple
import UIKit

protocol URLOpener: AnyObject {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
    
    var application: UIApplication { get }
}

extension URLOpener {
    func canOpenURL(_ url: URL) -> Bool {
        application.canOpenURL(url)
    }
    
    func openURL(_ url: URL) {
        application.open(url,
                         options: [:],
                         completionHandler: nil)
    }
}
