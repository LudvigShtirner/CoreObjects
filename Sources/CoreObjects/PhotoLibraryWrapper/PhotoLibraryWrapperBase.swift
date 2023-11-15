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
    // MARK: - Dependencies
    private let photoLibrary: PHPhotoLibrary
    
    // MARK: - Data
    private var isRequestingAccess = false
    
    // MARK: - Inits
    init(photoLibrary: PHPhotoLibrary) {
        self.photoLibrary = photoLibrary
    }
    
    // MARK: - PhotoLibraryWrapper
    func requestPermission(completionBlock: @escaping (PermissionStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus().permissionStatus
        if status != .notDetermined {
            completionBlock(status)
            return
        }
        guard isRequestingAccess else {
            return
        }
        isRequestingAccess = true
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            self?.isRequestingAccess = false
            completionBlock(status.permissionStatus)
        }
    }
}

// MARK: - Private extensions
private extension PHAuthorizationStatus {
    var permissionStatus: PermissionStatus {
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
