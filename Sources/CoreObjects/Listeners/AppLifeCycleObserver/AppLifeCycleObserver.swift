//
//  AppLifeCycleObserver.swift
//  
//
//  Created by Алексей Филиппов on 28.05.2023.
//

// SPM
import SupportCode
// Apple
import Foundation

public protocol AppLifeCycleObserver: AnyObject {
    func subscribeOn(_ event: AppLifeCycleEvent,
                     handler: @escaping VoidBlock) -> String
    @discardableResult
    func unsubscribe(with key: String) -> Bool
}

public enum AppLifeCycleEvent {
    case didEnterBackground
    case willEnterForeground
    case didFinishLaunching
    case didBecomeActive
    case willResignActive
    case didReceiveMemoryWarning
    case willTerminate
    case significantTimeChange
    case backgroundRefreshStatusDidChange
    case protectedDataWillBecomeUnavailable
    case protectedDataDidBecomeAvailable
}

