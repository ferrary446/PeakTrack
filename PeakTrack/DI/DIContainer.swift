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
        dependency: @escaping () -> T
    )

    func register<T>(
        identifier: T.Type,
        dependency: @escaping (_ parameters: Any) -> T
    )

    func resolve<T>(identifier: T.Type) -> T
    func resolve<T>(identifier: T.Type, parameters: Any) -> T
}

final class DIContainerImp: DIContainer {
    private var dependencies = [ObjectIdentifier: Any]()

    init() {}

    func register<T>(
        identifier: T.Type,
        dependency: @escaping () -> T
    ) {
        let id = ObjectIdentifier(identifier)

        dependencies[id] = dependency
    }

    func register<T>(
        identifier: T.Type,
        dependency: @escaping (_ parameters: Any) -> T
    ) {
        let id = ObjectIdentifier(identifier)

        dependencies[id] = dependency
    }

    func resolve<T>(identifier: T.Type) -> T {
        let id = ObjectIdentifier(identifier)

        guard let dependency = dependencies[id] as? () -> T else {
            fatalError("Fail to get dependency by id: \(id)")
        }

        return dependency()
    }

    func resolve<T>(identifier: T.Type, parameters: Any) -> T {
        let id = ObjectIdentifier(identifier)

        guard let dependency = dependencies[id] as? (_ parameters: Any) -> T else {
            fatalError("Fail to get dependency by id: \(id)")
        }

        return dependency(parameters)
    }
}
