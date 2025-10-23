//
//  WorkoutsListRepositorySpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

final class WorkoutsListRepositorySpy: WorkoutsListRepository {
    struct DeleteCall {
        let workoutID: UUID
        let source: SourceType
    }

    struct GetWorkoutsCall {
        let source: SourceType
    }

    struct SaveCall {
        let source: SourceType
        let workout: WorkoutInformation
    }

    private(set) var deleteCalls = [DeleteCall]()
    private(set) var getWorkoutsCalls = [GetWorkoutsCall]()
    private(set) var saveCalls = [SaveCall]()

    private let deleteErrorToThrow: (() -> Error)?
    private let getWorkoutsErrorToThrow: (() -> Error)?
    private let saveErrorToThrow: (() -> Error)?
    private let workoutsToReturn: [WorkoutInformation]

    init(
        deleteErrorToThrow: (() -> Error)? = nil,
        getWorkoutsErrorToThrow: (() -> Error)? = nil,
        saveErrorToThrow: (() -> Error)? = nil,
        workoutsToReturn: [WorkoutInformation] = []
    ) {
        self.deleteErrorToThrow = deleteErrorToThrow
        self.getWorkoutsErrorToThrow = getWorkoutsErrorToThrow
        self.saveErrorToThrow = saveErrorToThrow
        self.workoutsToReturn = workoutsToReturn
    }

    func delete(
        by workoutID: UUID,
        source: SourceType
    ) async throws {
        deleteCalls.append(DeleteCall(workoutID: workoutID, source: source))

        if let deleteErrorToThrow {
            throw deleteErrorToThrow()
        }
    }

    func getWorkouts(
        source: SourceType
    ) async throws -> [WorkoutInformation] {
        getWorkoutsCalls.append(GetWorkoutsCall(source: source))

        if let getWorkoutsErrorToThrow {
            throw getWorkoutsErrorToThrow()
        }

        return workoutsToReturn
    }

    func save(
        source: SourceType,
        workout: WorkoutInformation
    ) async throws {
        saveCalls.append(SaveCall(source: source, workout: workout))

        if let saveErrorToThrow {
            throw saveErrorToThrow()
        }
    }
}
