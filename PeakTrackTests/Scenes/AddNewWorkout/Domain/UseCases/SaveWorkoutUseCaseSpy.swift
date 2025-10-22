//
//  SaveWorkoutUseCaseSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

@testable import PeakTrack

final class SaveWorkoutUseCaseSpy: SaveWorkoutUseCase {
    struct SaveWorkoutUseCaseCounter {
        let source: SourceType
        let workout: WorkoutInformation
    }

    var errorToThrow: Error?

    private(set) var counter = [SaveWorkoutUseCaseCounter]()

    func callAsFunction(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
        counter.append(SaveWorkoutUseCaseCounter(source: source, workout: workout))

        if let errorToThrow {
            throw errorToThrow
        }
    }
}
