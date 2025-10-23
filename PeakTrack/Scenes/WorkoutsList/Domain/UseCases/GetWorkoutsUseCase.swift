//
//  GetWorkoutsUseCase.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

protocol GetWorkoutsUseCase {
    func callAsFunction(source: SourceType) async throws -> [WorkoutInformation]
}

final class GetWorkoutsLiveUseCase: GetWorkoutsUseCase {
    private let repository: WorkoutsListRepository

    init(repository: WorkoutsListRepository) {
        self.repository = repository
    }

    func callAsFunction(source: SourceType) async throws -> [WorkoutInformation] {
        try await repository.getWorkouts(source: source)
    }
}
