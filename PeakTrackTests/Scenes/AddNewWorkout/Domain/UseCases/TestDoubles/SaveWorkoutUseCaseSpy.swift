//
//  SaveWorkoutUseCaseSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

@testable import PeakTrack

final class SaveWorkoutUseCaseSpy: SaveWorkoutUseCase {
    struct Call {
        let source: SourceType
        let workout: WorkoutInformation
    }

    private(set) var calls = [Call]()
    private let errorToThrow: (() -> Error)?

    init(errorToThrow: (() -> Error)? = nil) {
        self.errorToThrow = errorToThrow
    }

    func callAsFunction(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
        calls.append(Call(source: source, workout: workout))

        if let errorToThrow {
            throw errorToThrow()
        }
    }
}
