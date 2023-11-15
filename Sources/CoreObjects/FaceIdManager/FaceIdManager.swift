//
//  FaceIdManager.swift
//  
//
//  Created by Алексей Филиппов on 26.06.2023.
//

// SPM
import SupportCode
// Apple
import Foundation

public protocol FaceIdManager: AnyObject {
    func canUseFaceID() -> Result<Void, FaceIDError>
    func useFaceID(reason: String,
                   completion: @escaping ResultBlock<Void>)
}
