//
//  GetWorkoutsUseCase.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

protocol GetWorkoutsUseCase {
    func callAsFunction() async throws -> [WorkoutInformation]
}

final class GetWorkoutsLiveUseCase: GetWorkoutsUseCase {
    private let repository: WorkoutsListRepository

    init(repository: WorkoutsListRepository) {
        self.repository = repository
    }

    func callAsFunction() async throws -> [WorkoutInformation] {
        try await repository.getWorkouts()
    }
}
