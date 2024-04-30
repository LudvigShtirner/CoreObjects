//
//  PhotoLibraryWrapperMock.swift
//
//
//  Created by Алексей Филиппов on 25.04.2024.
//

/// SPM
import CoreObjects
/// Apple
import UIKit
import Photos
import Combine

public final class PhotoLibraryWrapperMock {
    // MARK: - Data
    public var currentStatusMock: CurrentValueSubject<PhotoLibraryPermissionStatus, Never>
    public var changePublisherMock = PassthroughSubject<PHChange, Never>()
    
    public var requestPermissionCallCount: Int = 0
    
    public var requestPermissionHandler: (() throws -> Void)?
    public var obtainFoldersHandler: ((PHFetchOptions) -> [PHAssetCollection])?
    public var getContentHandler: ((PHAssetCollection, PHFetchOptions) -> PHFetchResult<PHAsset>)?
    public var presentLimitedLibraryPickerHandler: ((UIViewController) -> [String])?
    
    // MARK: - Life cycle
    public init(currentStatus: PhotoLibraryPermissionStatus) {
        currentStatusMock = .init(currentStatus)
    }
}

// MARK: - PhotoLibraryWrapper
extension PhotoLibraryWrapperMock: PhotoLibraryWrapper {
    public var currentStatus: CurrentValueSubject<PhotoLibraryPermissionStatus, Never> {
        currentStatusMock
    }
    
    public var changePublisher: AnyPublisher<PHChange, Never> {
        changePublisherMock.eraseToAnyPublisher()
    }
    
    public func requestPermission() async throws {
        requestPermissionCallCount += 1
        return try requestPermissionHandler!()
    }
    
    public func obtainFolders(fetchOptions: PHFetchOptions) async -> [PHAssetCollection] {
        return obtainFoldersHandler!(fetchOptions)
    }
    
    public func getContent(of album: PHAssetCollection, fetchOptions: PHFetchOptions) async -> PHFetchResult<PHAsset> {
        return getContentHandler!(album, fetchOptions)
    }
    
    public func presentLimitedLibraryPicker(from viewController: UIViewController) async -> [String] {
        return presentLimitedLibraryPickerHandler!(viewController)
    }
}
