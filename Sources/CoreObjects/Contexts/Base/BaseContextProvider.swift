//
//  BaseContextProvider.swift
//  
//
//  Created by Алексей Филиппов on 16.09.2023.
//

// Apple
import Foundation
import Combine

open class BaseContextProvider<Context: BaseContext> {
    // MARK: - Data
    private let initialContext: Context
    private var storedContext: Context
    private let observedContext = PassthroughSubject<Context, Never>()
    
    // MARK: - Life Cycle
    public init(initialContext: Context) {
        self.initialContext = initialContext
        storedContext = initialContext
    }
    
    // MARK: - Interface methods
    public private(set) var currentContext: Context {
        get { storedContext }
        set {
            storedContext = newValue
            observedContext.send(newValue)
        }
    }
    
    public func observeContextUpdates() -> PassthroughSubject<Context, Never>{
        observedContext
    }
    
    public func updateContext(with newContext: Context) {
        currentContext = newContext
    }
    
    public func updateContext<T>(_ keyPath: WritableKeyPath<Context, T>, with value: T) {
        currentContext[keyPath: keyPath] = value
        updateContext(with: currentContext)
    }
    
    public func resetContext() {
        updateContext(with: initialContext)
    }
}
