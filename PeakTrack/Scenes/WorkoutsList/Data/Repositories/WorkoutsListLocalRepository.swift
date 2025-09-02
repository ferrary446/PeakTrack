//
//  WorkoutsListLocalRepository.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

final class WorkoutsListLocalRepository: WorkoutsListRepository {
    private let converter: WorkoutInformationConverter
    private let manager: DBManagerful

    init(converter: WorkoutInformationConverter, manager: DBManagerful) {
        self.converter = converter
        self.manager = manager
    }

    @MainActor
    func delete(by workoutID: UUID) async throws {
        let dbEntities: [WorkoutDBEntity] = try manager.getEntities(
            model: WorkoutDBEntity.self,
            predicate: #Predicate<WorkoutDBEntity> { entity in
                entity.id == workoutID
            }
        )
        let dbEntity = dbEntities.first(where: { $0.id == workoutID })

        if let dbEntity {
            try manager.deleteEntity(dbEntity)            
        }
    }

    @MainActor
    func getWorkouts() async throws -> [WorkoutInformation] {
        let entities: [WorkoutDBEntity] = try manager.getEntities(
            model: WorkoutDBEntity.self,
            predicate: nil
        )

        return entities
            .compactMap { [weak self] in self?.converter.convert(dbEntity: $0) }
    }

    @MainActor
    func save(workout: WorkoutInformation) async throws {
        let dbEntity = converter.convert(domainModel: workout)

        try manager.saveEntity(dbEntity)
    }
}
