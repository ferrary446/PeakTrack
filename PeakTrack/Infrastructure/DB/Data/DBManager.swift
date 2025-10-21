//
//  DBManager.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation
import SwiftData

@MainActor
protocol DBManagerful {
    func deleteEntity<E: PersistentModel>(
        _ entity: E
    ) throws

    func getEntities<E: PersistentModel>(
        model: any PersistentModel.Type,
        predicate: Predicate<E>?
    ) throws -> [E]

    func saveEntity<E: PersistentModel>(
        _ entity: E
    ) throws
}

final class DBManager: DBManagerful {
    private var context: ModelContext {
        container.mainContext
    }

    private let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for: WorkoutDBEntity.self
            )
        } catch {
            fatalError("Fail to initialize ModalContainer")
        }
    }

    func deleteEntity<E: PersistentModel>(
        _ entity: E
    ) throws {
        context.delete(entity)
        try context.save()
    }

    func getEntities<E: PersistentModel>(
        model: any PersistentModel.Type,
        predicate: Predicate<E>?
    ) throws -> [E] {
        var entity = FetchDescriptor<E>()

        entity.predicate = predicate
        entity.fetchLimit = 50
        entity.includePendingChanges = true

        return try context.fetch(entity)
    }

    func saveEntity<E: PersistentModel>(
        _ entity: E
    ) throws {
        context.insert(entity)

        try context.save()
    }
}
