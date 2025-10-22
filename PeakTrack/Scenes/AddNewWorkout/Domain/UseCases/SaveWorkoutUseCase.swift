//
//  SaveWorkoutUseCase.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

protocol SaveWorkoutUseCase {
    func callAsFunction(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws
}

final class SaveWorkoutLiveUseCase: SaveWorkoutUseCase {
    private let repository: WorkoutsListRepository

    init(repository: WorkoutsListRepository) {
        self.repository = repository
    }

    func callAsFunction(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
        try await repository.save(source: source, workout: workout)
    }
}
