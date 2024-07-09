//
//  AppDependencyContainer.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 09/07/24.
//

import Foundation

protocol DependencyContainer {
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    func resolve<T>() -> T?
}

class AppDependencyContainer: DependencyContainer {
    private var factories: [String: () -> Any] = [:]
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        factories[String(describing: type)] = factory
    }
    
    func resolve<T>() -> T? {
        let key = String(describing: T.self)
        return factories[key]?() as? T
    }
}
