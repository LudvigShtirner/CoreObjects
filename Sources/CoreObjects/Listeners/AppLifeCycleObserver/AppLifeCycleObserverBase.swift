//
//  AppLifeCycleObserverBase.swift
//  
//
//  Created by Алексей Филиппов on 28.05.2023.
//

// SPM
import SupportCode
// Apple
import UIKit

final class AppLifeCycleObserverBase: AppLifeCycleObserver {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter
    
    // MARK: - Data
    private var listeners: [String: NotificationCenterListener] = [:]
    
    // MARK: - Life cycle
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - NotificationService
    func subscribeOn(_ event: AppLifeCycleEvent,
                     handler: @escaping VoidBlock) -> String {
        let notification = event.notification
        let listener = NotificationCenterListener(notificationCenter: notificationCenter,
                                                  notification: notification,
                                                  handler: handler)
        let key = UUID().uuidString
        listeners[key] = listener
        return key
    }
    
    @discardableResult
    func unsubscribe(with key: String) -> Bool {
        return (listeners.removeValue(forKey: key) != nil)
    }
}

fileprivate extension AppLifeCycleEvent {
    var notification: NSNotification.Name {
        switch self {
        case .didEnterBackground: return UIApplication.didEnterBackgroundNotification
        case .willEnterForeground: return UIApplication.willEnterForegroundNotification
        case .didFinishLaunching: return UIApplication.didFinishLaunchingNotification
        case .didBecomeActive: return UIApplication.didBecomeActiveNotification
        case .willResignActive: return UIApplication.willResignActiveNotification
        case .didReceiveMemoryWarning: return UIApplication.didReceiveMemoryWarningNotification
        case .willTerminate: return UIApplication.willTerminateNotification
        case .significantTimeChange: return UIApplication.significantTimeChangeNotification
        case .backgroundRefreshStatusDidChange: return UIApplication.backgroundRefreshStatusDidChangeNotification
        case .protectedDataWillBecomeUnavailable: return UIApplication.protectedDataWillBecomeUnavailableNotification
        case .protectedDataDidBecomeAvailable: return UIApplication.protectedDataDidBecomeAvailableNotification
        }
    }
}
