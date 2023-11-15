//
//  FaceIdManagerBase.swift
//  
//
//  Created by Алексей Филиппов on 26.06.2023.
//

// SPM
import SupportCode
// Apple
import LocalAuthentication

final class FaceIdManagerBase: FaceIdManager {
    // MARK: - Data
    private let context = LAContext()
    
    // MARK: - Inits
    init(infoPlistDictionary: [String: Any]) {
        testInfoPlistForFaceIdValue(infoPlistDictionary: infoPlistDictionary)
    }
    
    // MARK: - FaceIdManager
    func canUseFaceID() -> Result<Void, FaceIDError> {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            return .success
        }
        return .failure(.customError(error))
    }
    
    func useFaceID(reason: String,
                   completion: @escaping ResultBlock<Void>) {
        switch canUseFaceID() {
        case .success:
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { (success, error) in
                guard success, error == nil else {
                    completion(.failure(FaceIDError.customError(error)))
                    return
                }
                completion(.success)
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    // MARK: - Private methods
    private func testInfoPlistForFaceIdValue(infoPlistDictionary: [String: Any]) {
        if infoPlistDictionary["NSFaceIDUsageDescription"] == nil {
           fatalError("Privacy - Face ID Usage Description in info.plist doesn't set")
        }
    }
}

public enum FaceIDError: Error {
    case customError(Error?)
}
