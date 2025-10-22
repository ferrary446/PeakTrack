//
//  WorkoutsListRemoteRepository.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 21.10.2025.
//

import Foundation

final class WorkoutsListRemoteRepository: WorkoutsListRepository {
    private let converter: WorkoutInformationConverter
    private let manager: FirestoreManagerful

    init(converter: WorkoutInformationConverter, manager: FirestoreManagerful) {
        self.converter = converter
        self.manager = manager
    }

    func delete(
        by workoutID: UUID,
        source: SourceType
    ) async throws {
//        let dbEntities: [WorkoutDBEntity] = try manager.getEntities(
//            model: WorkoutDBEntity.self,
//            predicate: #Predicate<WorkoutDBEntity> { entity in
//                entity.id == workoutID
//            }
//        )
//        let dbEntity = dbEntities.first(where: { $0.id == workoutID })
//
//        if let dbEntity {
//            try manager.deleteEntity(dbEntity)
//        }
    }

    func getWorkouts(
        source: SourceType
    ) async throws -> [WorkoutInformation] {
        let entities: [WorkoutDTOEntity] = try await manager.getDocuments(
            collectionID: .workouts,
            type: WorkoutDTOEntity.self
        )

        return entities
            .compactMap { [weak self] in self?.converter.convert(dto: $0) }
    }

    func save(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
//        let dbEntity = converter.convert(domainModel: workout)
//
//        try manager.saveEntity(dbEntity)
    }
}
