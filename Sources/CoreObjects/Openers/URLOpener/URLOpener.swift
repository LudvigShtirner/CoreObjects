//
//  URLOpener.swift
//  
//
//  Created by Алексей Филиппов on 20.01.2023.
//

// Apple
import UIKit

public protocol URLOpener: AnyObject {
    @discardableResult
    func openURL(_ url: URL) -> Bool
    
    var application: UIApplication { get }
}

public extension URLOpener {
    @discardableResult
    func openURL(_ url: URL) -> Bool {
        guard application.canOpenURL(url) else {
            return false
        }
        precondition(Thread.isMainThread)
        application.open(url,
                         options: [:],
                         completionHandler: nil)
        return true
    }
}
