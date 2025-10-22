//
//  GetWorkoutsLocalUseCase.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

protocol GetWorkoutsLocalUseCase {
    func callAsFunction(source: SourceType) async throws -> [WorkoutInformation]
}

final class GetWorkoutsLocalLiveUseCase: GetWorkoutsLocalUseCase {
    private let repository: WorkoutsListRepository

    init(repository: WorkoutsListRepository) {
        self.repository = repository
    }

    func callAsFunction(source: SourceType) async throws -> [WorkoutInformation] {
        try await repository.getWorkouts(source: source)
    }
}
