//
//  PhotoLibraryWrapperBase.swift
//  
//
//  Created by Алексей Филиппов on 05.09.2023.
//

// Apple
import Foundation
import Photos

final class PhotoLibraryWrapperBase: PhotoLibraryWrapper {
    // MARK: - Data
    private var isRequestingAccess = false
    
    // MARK: - Inits
    init() {
    }
    
    // MARK: - PhotoLibraryWrapper
    func requestPermission() async throws -> PhotoLibraryPermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus().permissionStatus
        if status != .notDetermined {
            return status
        }
        if isRequestingAccess {
            throw RequestError.alreadyRequested
        }
        isRequestingAccess = true
        let gainedStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        isRequestingAccess = false
        return gainedStatus.permissionStatus
    }
}

enum RequestError: Error {
    case alreadyRequested
}

// MARK: - Private extensions
private extension PHAuthorizationStatus {
    var permissionStatus: PhotoLibraryPermissionStatus {
        switch self {
        case .notDetermined: return .notDetermined
        case .restricted, .denied: return .denied
        case .authorized: return .granted
        case .limited: return .limited
        @unknown default:
            fatalError("")
        }
    }
}
