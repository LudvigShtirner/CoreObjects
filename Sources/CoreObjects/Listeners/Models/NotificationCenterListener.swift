//
//  NotificationCenterListener.swift
//  
//
//  Created by Алексей Филиппов on 28.05.2023.
//

// SPM
import SupportCode
// Apple
import Foundation

final class NotificationCenterListener {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter
    // MARK: - Data
    private var observeKey: Any?
    
    // MARK: - Life Cycle
    init(notificationCenter: NotificationCenter,
         notification: NSNotification.Name,
         handler: @escaping (Notification) -> Void) {
        self.notificationCenter = notificationCenter
        
        startObserve(notification: notification,
                     handler: handler)
    }
    
    deinit {
        _ = observeKey.map { notificationCenter.removeObserver($0) }
    }
    
    // MARK: - Private methods
    private func startObserve(notification: NSNotification.Name,
                              handler: @escaping (Notification) -> Void) {
        observeKey = notificationCenter.addObserver(forName: notification,
                                                    object: nil,
                                                    queue: nil) { notification in
            handler(notification)
        }
    }
}
