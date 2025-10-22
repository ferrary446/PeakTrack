//
//  DeleteWorkoutUseCase.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

protocol DeleteWorkoutUseCase {
    func callAsFunction(
        by workoutID: UUID,
        source: SourceType
    ) async throws
}

final class DeleteWorkoutLiveUseCase: DeleteWorkoutUseCase {
    private let repository: WorkoutsListRepository

    init(repository: WorkoutsListRepository) {
        self.repository = repository
    }

    func callAsFunction(
        by workoutID: UUID,
        source: SourceType
    ) async throws {
        try await repository.delete(by: workoutID, source: source)
    }
}
