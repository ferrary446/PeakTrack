//
//  GetWorkoutsUseCaseSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

final class GetWorkoutsUseCaseSpy: GetWorkoutsUseCase {
    private(set) var counter = 0

    private let errorToThrow: (() -> Error)?
    private let workoutsToReturn: [WorkoutInformation]

    init(errorToThrow: (() -> Error)? = nil, workoutsToReturn: [WorkoutInformation] = []) {
        self.errorToThrow = errorToThrow
        self.workoutsToReturn = workoutsToReturn
    }

    func callAsFunction(source: SourceType) async throws -> [WorkoutInformation] {
        counter += 1

        if let errorToThrow {
            throw errorToThrow()
        }

        return workoutsToReturn
    }
}
