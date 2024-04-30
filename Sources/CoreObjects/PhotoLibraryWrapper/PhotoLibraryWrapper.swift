//
//  PhotoLibraryWrapper.swift
//  
//
//  Created by Алексей Филиппов on 05.09.2023.
//

// Apple
import UIKit
import Photos
import Combine

public protocol PhotoLibraryWrapper: AnyObject {
    var currentStatus: CurrentValueSubject<PhotoLibraryPermissionStatus, Never> { get }
    var changePublisher: AnyPublisher<PHChange, Never> { get }
    
    func requestPermission() async throws
    func obtainFolders(fetchOptions: PHFetchOptions) async -> [PHAssetCollection]
    func getContent(of album: PHAssetCollection,
                    fetchOptions: PHFetchOptions) async -> PHFetchResult<PHAsset>
    
    func presentLimitedLibraryPicker(from viewController: UIViewController) async -> [String]
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
