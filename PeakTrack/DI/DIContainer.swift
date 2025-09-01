//
//  DIContainer.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import Foundation

protocol DIContainer: AnyObject {
    func register<T>(
        identifier: T.Type,
        dependency: @Sendable @escaping () -> T
    ) async

    func register<T>(
        identifier: T.Type,
        dependency: @Sendable @escaping (_ parameters: Any) -> T
    ) async

    func resolve<T>(identifier: T.Type) async -> T
    func resolve<T>(identifier: T.Type, parameters: Any) async -> T
}

final actor DIContainerImp: DIContainer {
    private var dependencies = [ObjectIdentifier: Any]()

    init() {}

    func register<T>(
        identifier: T.Type,
        dependency: @Sendable @escaping () -> T
    ) async {
        let id = ObjectIdentifier(identifier)

        dependencies[id] = dependency
    }

    func register<T>(
        identifier: T.Type,
        dependency: @Sendable @escaping (_ parameters: Any) -> T
    ) async {
        let id = ObjectIdentifier(identifier)

        dependencies[id] = dependency
    }

    func resolve<T>(identifier: T.Type) async -> T {
        let id = ObjectIdentifier(identifier)

        guard let dependency = dependencies[id] as? () -> T else {
            fatalError("Fail to get dependency by id: \(id)")
        }

        return dependency()
    }

    func resolve<T>(identifier: T.Type, parameters: Any) async -> T {
        let id = ObjectIdentifier(identifier)

        guard let dependency = dependencies[id] as? (_ parameters: Any) -> T else {
            fatalError("Fail to get dependency by id: \(id)")
        }

        return dependency(parameters)
    }
}
