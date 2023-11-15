//
//  PhotoLibraryWrapper.swift
//  
//
//  Created by Алексей Филиппов on 05.09.2023.
//

// Apple
import Foundation

public protocol PhotoLibraryWrapper: AnyObject {
    /// Запросить доступ к записи и чтению
    /// - Parameter completionBlock: блок операций после выбора статуса доступа
    func requestPermission(completionBlock: @escaping (PermissionStatus) -> Void)
}

public enum PermissionStatus {
    case notDetermined
    case granted
    case limited
    case denied
    
    public var hasAccess: Bool {
        switch self {
        case .notDetermined, .denied: return false
        case .granted, .limited: return true
        }
    }
}
