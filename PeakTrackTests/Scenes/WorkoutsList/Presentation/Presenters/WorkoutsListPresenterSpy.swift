//
//  WorkoutsListPresenterSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

final class WorkoutsListPresenterSpy: WorkoutsListPresenter {
    struct Call {
        let workouts: [WorkoutInformation]
        let onSelectWorkout: (_ id: UUID) -> Void
    }

    private(set) var calls = [Call]()

    private let presentReturnValue: [WorkoutListRowViewModel]

    init(presentReturnValue: [WorkoutListRowViewModel] = []) {
        self.presentReturnValue = presentReturnValue
    }

    func present(
        workouts: [WorkoutInformation],
        onSelectWorkout: @escaping (_ id: UUID) -> Void
    ) -> [WorkoutListRowViewModel] {
        calls.append(Call(workouts: workouts, onSelectWorkout: onSelectWorkout))

        return presentReturnValue
    }
}
