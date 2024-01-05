//
//  PhotoLibraryWrapper.swift
//  
//
//  Created by Алексей Филиппов on 05.09.2023.
//

// Apple
import Foundation

public protocol PhotoLibraryWrapper: AnyObject {
    func requestPermission() async throws -> PhotoLibraryPermissionStatus
}

public enum PhotoLibraryPermissionStatus {
    case notDetermined
    case granted
    case limited
    case denied
    
    public var hasAccess: Bool {
        switch self {
        case PhotoLibraryPermissionStatus.notDetermined, PhotoLibraryPermissionStatus.denied: return false
        case PhotoLibraryPermissionStatus.granted, PhotoLibraryPermissionStatus.limited: return true
        }
    }
}
