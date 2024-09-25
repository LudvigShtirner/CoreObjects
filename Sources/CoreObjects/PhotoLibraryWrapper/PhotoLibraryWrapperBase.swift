//
//  PhotoLibraryWrapperBase.swift
//  
//
//  Created by Алексей Филиппов on 05.09.2023.
//

// Apple
import UIKit
import Photos
import PhotosUI
import Combine

final class PhotoLibraryWrapperBase: NSObject {
    // MARK: - Dependencies
    private let photoLibrary: PHPhotoLibrary
    
    // MARK: - Data
    private var isRequestingAccess = false
    private let __currentStatus: CurrentValueSubject<PhotoLibraryPermissionStatus, Never>
    private let __changePublisher = PassthroughSubject<PHChange, Never>()
    
    // MARK: - Inits
    init(photoLibrary: PHPhotoLibrary) {
        self.photoLibrary = photoLibrary
        self.__currentStatus = .init(PHPhotoLibrary.authorizationStatus(for: .readWrite).permissionStatus)
        super.init()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.registerIfCan(status: self.__currentStatus.value)
        }
    }
}

// MARK: - PhotoLibraryWrapper
extension PhotoLibraryWrapperBase: PhotoLibraryWrapper {
    func requestPermission() async throws {
        let status = __currentStatus.value
        if status != .notDetermined {
            return
        }
        if isRequestingAccess {
            throw RequestError.alreadyRequested
        }
        isRequestingAccess = true
        let gainedStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        isRequestingAccess = false
        let permissionStatus = gainedStatus.permissionStatus
        registerIfCan(status: permissionStatus)
        __currentStatus.value = permissionStatus
    }
    
    func obtainFolders(fetchOptions: PHFetchOptions) async -> [PHAssetCollection] {
        let collection: [PHAssetCollection] = await withCheckedContinuation { continuation in
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            var result = [PHAssetCollection]()
            smartAlbums.enumerateObjects { (album, _, _) in
                result.append(album)
            }
            let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            albums.enumerateObjects { (album, _, _) in
                result.append(album)
            }
            continuation.resume(returning: result)
        }
        return collection
    }
    
    func getContent(of album: PHAssetCollection,
                    fetchOptions: PHFetchOptions) async -> PHFetchResult<PHAsset> {
        let fetchResult: PHFetchResult<PHAsset> = await withCheckedContinuation { continuation in
            let result = PHAsset.fetchAssets(in: album, options: fetchOptions)
            continuation.resume(returning: result)
        }
        return fetchResult
    }
    
    var currentStatus: CurrentValueSubject<PhotoLibraryPermissionStatus, Never> { __currentStatus }
    var changePublisher: AnyPublisher<PHChange, Never> { __changePublisher.eraseToAnyPublisher() }
    
    func presentLimitedLibraryPicker(from viewController: UIViewController) async -> [String] {
        return await photoLibrary.presentLimitedLibraryPicker(from: viewController)
    }
}

// MARK: - Private methods
private extension PhotoLibraryWrapperBase {
    func registerIfCan(status: PhotoLibraryPermissionStatus) {
        let currentStatus = __currentStatus.value
        guard currentStatus == .granted || currentStatus == .limited else {
            return
        }
        photoLibrary.register(self)
    }
}

// MARK: - PHPhotoLibraryChangeObserver
extension PhotoLibraryWrapperBase: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        __changePublisher.send(changeInstance)
    }
}

// MARK: - Subtypes
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
        @unknown default: return .notDetermined
        }
    }
}
