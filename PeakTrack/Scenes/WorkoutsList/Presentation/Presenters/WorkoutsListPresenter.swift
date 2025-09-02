//
//  WorkoutsListPresenter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

protocol WorkoutsListPresenter {
    func present(
        workouts: [WorkoutInformation],
        onSelectWorkout: @escaping (_ id: UUID) -> Void
    ) -> [WorkoutListRowViewModel]
}

struct WorkoutsListPresenterImp: WorkoutsListPresenter {
    func present(
        workouts: [WorkoutInformation],
        onSelectWorkout: @escaping (_ id: UUID) -> Void
    ) -> [WorkoutListRowViewModel] {
        workouts.map { workout in
            WorkoutListRowViewModel(
                id: workout.id,
                title: workout.name,
                subtitle: workout.place.isEmpty ? nil : workout.place,
                onTap: {
                    onSelectWorkout(workout.id)
                }
            )
        }
    }
}
