//
//  CoreObjectsFactory.swift
//  
//
//  Created by Алексей Филиппов on 28.05.2023.
//

// Apple
import UIKit
import UserNotifications

public enum CoreObjectsFactory {
    // MARK: - Interface methods
    public static func buildApiClient() -> APIClient {
        return APIClientBase.shared
    }
    
    public static func buildBluetoothWrapper() -> BluetoothWrapper {
        return BluetoothWrapperBase()
    }
    
    public static func buildFaceIdManager(infoPlistDictionary: [String : Any]) -> FaceIdManager {
        FaceIdManagerBase(infoPlistDictionary: infoPlistDictionary)
    }
    
    public static func buildAppLifeCycleObserver(notificationCenter: NotificationCenter = .default) -> AppLifeCycleObserver {
        return AppLifeCycleObserverBase(notificationCenter: notificationCenter)
    }
    
    public static func buildLocalNotificationCenter(application: UIApplication = .shared,
                                                    notificationCenter: UNUserNotificationCenter = .current()) -> LocalNotificationWorker {
        return LocalNotificationWorkerBase(application: application,
                                           notificationCenter: notificationCenter)
    }
    
    public static func buildMailService() -> MailService {
        MailServiceBase()
    }
    
    public static func buildPhotoLibrary() -> PhotoLibraryWrapper {
        PhotoLibraryWrapperBase()
    }
    
    public static func buildPlistParser() -> PlistFileParser {
        PlistFileParserBase()
    }
}
