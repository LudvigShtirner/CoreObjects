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
    @UDCodableStoredRx private var storedContext: Context
    
    // MARK: - Inits
    public init(initialContext: Context,
                contextKey: UserDefaultsKey) {
        self.initialContext = initialContext
        _storedContext = UDCodableStoredRx(key: contextKey,
                                           defaultValue: initialContext)
    }
    
    // MARK: - Interface methods
    public var currentContext: Context {
        get { storedContext }
        set { storedContext = newValue }
    }
    
    public func observeContextUpdates() -> AnyPublisher<Context, Never> {
        _storedContext.publisher
    }
    
    public func updateContext<T>(_ keyPath: WritableKeyPath<Context, T>,
                                 with value: T) {
        var context = storedContext
        context[keyPath: keyPath] = value
        currentContext = context
    }
}
