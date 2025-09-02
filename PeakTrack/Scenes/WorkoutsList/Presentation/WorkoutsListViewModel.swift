//
//  WorkoutsListViewModel.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import Foundation
import SwiftUI

final class WorkoutsListViewModel: ObservableObject {
    enum Action {
        case showAddNewWorkout(onSave: @MainActor () -> Void)
        case showWorkoutDetail(information: WorkoutInformation)
    }

    enum State: Equatable {
        case empty
        case loading
        case content([WorkoutListRowViewModel])
    }

    struct Dependencies {
        let deleteWorkoutUseCase: DeleteWorkoutUseCase
        let getWorkoutsUseCase: GetWorkoutsUseCase
        let presenter: WorkoutsListPresenter
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    @MainActor @Published private(set) var state: State = .loading

    @MainActor private var workoutsByCategory = [WorkoutStorageCategory: [WorkoutInformation]]()

    private let dependencies: Dependencies
    private let parameters: Parameters

    init(dependencies: Dependencies, parameters: Parameters) {
        self.dependencies = dependencies
        self.parameters = parameters
    }

    func onLoad() async {
        do {
            let workouts = try await dependencies.getWorkoutsUseCase()

            await MainActor.run { [weak self] in
                self?.workoutsByCategory[.all] = workouts
                self?.workoutsByCategory[.local] = workouts
            }

            await setContent(from: workouts)
        } catch {
            await MainActor.run { [weak self] in
                self?.state = .empty
            }
        }
    }

    @MainActor
    func addNewWorkout() {
        parameters.onAction(
            .showAddNewWorkout(
                onSave: { [weak self] in
                    Task { [weak self] in
                        await self?.onLoad()
                    }
                }
            )
        )
    }

    @MainActor
    func delete(workoutID: UUID) async {
        do {
            try await dependencies.deleteWorkoutUseCase(by: workoutID)
            await onLoad()
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor
    func filterWorkouts(by category: WorkoutStorageCategory) {
        if let workouts = workoutsByCategory[category] {
            setContent(from: workouts)
        }
    }
}

private extension WorkoutsListViewModel {
    @MainActor
    func setContent(from workouts: [WorkoutInformation]) {
        let rows = dependencies.presenter.present(
            workouts: workouts,
            onSelectWorkout: { [weak self] id in
                self?.showWorkoutDetail(by: id)
            }
        )

        if rows.isEmpty {
            state = .empty
        } else {
            state = .content(rows)
        }
    }

    @MainActor
    func showWorkoutDetail(by id: UUID) {
        let information = workoutsByCategory[.all]?.first(where: { $0.id == id })

        if let information {
            parameters.onAction(.showWorkoutDetail(information: information))            
        }
    }
}
