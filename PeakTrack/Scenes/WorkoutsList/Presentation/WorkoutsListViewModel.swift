//
//  WorkoutsListViewModel.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import Foundation

final class WorkoutsListViewModel: ObservableObject {
    enum Action {
        case showAddNewWorkout
        case showWorkoutDetail
    }

    enum State: Equatable {
        case empty
        case loading
        case content
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    @MainActor @Published private(set) var state: State = .empty

    private let parameters: Parameters

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func onLoad() async {
        
    }

    @MainActor
    func addNewWorkout() {
        parameters.onAction(.showAddNewWorkout)
    }

    @MainActor
    func filterWorkouts(by category: WorkoutStorageCategory) {
        
    }
}
