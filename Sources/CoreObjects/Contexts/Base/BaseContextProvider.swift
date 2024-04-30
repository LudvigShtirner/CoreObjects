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
    private let storedContext: CurrentValueSubject<Context, Never>
    
    // MARK: - Life Cycle
    public init(initialContext: Context) {
        self.initialContext = initialContext
        storedContext = .init(initialContext)
    }
    
    // MARK: - Interface methods
    public var currentContext: Context {
        get { storedContext.value }
        set { storedContext.value = newValue }
    }
    
    public func observeContextUpdates() -> AnyPublisher<Context, Never>{
        storedContext.eraseToAnyPublisher()
    }
    
    public func updateContext<T>(_ keyPath: WritableKeyPath<Context, T>, with value: T) {
        var context = currentContext
        context[keyPath: keyPath] = value
        currentContext = context
    }
    
    public func resetContext() {
        currentContext = initialContext
    }
}
