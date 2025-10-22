//
//  WorkoutsListRepository.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

protocol WorkoutsListRepository {
    func delete(
        by workoutID: UUID,
        source: SourceType
    ) async throws

    func getWorkouts(
        source: SourceType
    ) async throws -> [WorkoutInformation]

    func save(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws
}
