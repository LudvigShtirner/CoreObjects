//
//  BaseCodableContextProvider.swift
//  
//
//  Created by Алексей Филиппов on 17.09.2023.
//

// SPM
import SupportCode
// Apple
import Foundation
import Combine

open class BaseCodableContextProvider<Context: BaseCodableContext> {
    // MARK: - Data
    private let initialContext: Context
    @UDCodableStored private var storedUserContext: Context
    private let observedContext = PassthroughSubject<Context, Never>()
    
    // MARK: - Inits
    public init(initialContext: Context,
                contextKey: UserDefaultsKey) {
        self.initialContext = initialContext
        _storedUserContext = UDCodableStored(key: contextKey,
                                             defaultValue: initialContext)
    }
    
    // MARK: - Interface methods
    public var currentContext: Context {
        get { storedUserContext }
        set {
            storedUserContext = newValue
            observedContext.send(newValue)
        }
    }
    
    public func observeContextUpdates() -> PassthroughSubject<Context, Never> {
        observedContext
    }
    
    public func updateUserContext(with newContext: Context) {
        currentContext = newContext
    }
    
    public func updateUserContext<T>(_ keyPath: WritableKeyPath<Context, T>,
                                     with value: T) {
        storedUserContext[keyPath: keyPath] = value
        updateUserContext(with: storedUserContext)
    }
}
