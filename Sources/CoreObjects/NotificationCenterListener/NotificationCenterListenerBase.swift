//
//  NotificationCenterListenerBase.swift
//  CoreObjects
//
//  Created by Алексей Филиппов on 22.04.2022.
//

// SPM
import SupportCode

// Apple
import UIKit

/// Реализация слушателя за нотификацитей от системы
final class NotificationCenterListenerBase: NotificationCenterListener {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter
    
    // MARK: - Data
    private var observers: [String: VoidBlock] = [:]
    
    // MARK: - Life cycle
    init(notificationCenter: NotificationCenter = .default,
         notificationName: Notification.Name) {
        self.notificationCenter = notificationCenter
        
        startListening(notificationName: notificationName)
    }
    
    // MARK: - NotificationCenterListener
    func addListener(_ closure: @escaping VoidBlock) -> String {
        let key = ProcessInfo.processInfo.globallyUniqueString
        observers[key] = closure
        return key
    }
    
    func removeListener(forKey key: String) {
        observers.removeValue(forKey: key)
    }
    
    // MARK: - Private methods
    private func startListening(notificationName: NSNotification.Name) {
        notificationCenter.addObserver(self,
                                       selector: #selector(action),
                                       name: notificationName,
                                       object: nil)
    }
    
    // MARK: - Actions
    @objc private func action() {
        observers.values.forEach { $0() }
    }
}
