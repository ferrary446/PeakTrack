//
//  WorkoutsListRepositoryImp.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

import Foundation

final class WorkoutsListRepositoryImp: WorkoutsListRepository {
    private let local: WorkoutsListLocalRepository
    private let remote: WorkoutsListRemoteRepository

    init(local: WorkoutsListLocalRepository, remote: WorkoutsListRemoteRepository) {
        self.local = local
        self.remote = remote
    }

    func delete(
        by workoutID: UUID,
        source: SourceType
    ) async throws {
        switch source {
        case .local:
            try await local.delete(by: workoutID, source: source)
        case .remote:
            try await remote.delete(by: workoutID, source: source)
        }
    }

    func getWorkouts(
        source: SourceType
    ) async throws -> [WorkoutInformation] {
        switch source {
        case .local:
            try await local.getWorkouts(source: source)
        case .remote:
            try await remote.getWorkouts(source: source)
        }
    }

    func save(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
        switch source {
        case .local:
            try await local.save(source: source, workout: workout)
        case .remote:
            try await remote.save(source: source, workout: workout)
        }
    }
}
