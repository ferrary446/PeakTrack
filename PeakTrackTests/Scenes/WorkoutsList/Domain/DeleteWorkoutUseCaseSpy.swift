//
//  DeleteWorkoutUseCaseSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

final class DeleteWorkoutUseCaseSpy: DeleteWorkoutUseCase {
    struct Call {
        let workoutID: UUID
        let source: SourceType
    }

    private(set) var calls = [Call]()
    private let errorToThrow: (() -> Error)?

    init(errorToThrow: (() -> Error)? = nil) {
        self.errorToThrow = errorToThrow
    }

    func callAsFunction(
        by workoutID: UUID,
        source: SourceType
    ) async throws {
        calls.append(Call(workoutID: workoutID, source: source))

        if let errorToThrow {
            throw errorToThrow()
        }
    }
}
