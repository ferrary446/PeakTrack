//
//  WorkoutsListFlow.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

struct WorkoutsListFlow: View {
    enum Destination: Hashable {
        case workoutDetail(information: WorkoutInformation)
    }

    @EnvironmentObject private var router: NavigationRouter

    struct Dependencies {
        @ViewBuilder let addNewWorkoutViewBuilder: (
            _ onAction: @escaping (AddNewWorkoutViewModel.Action) -> Void
        ) -> AddNewWorkoutView

        @ViewBuilder let workoutsListViewBuilder: (
            _ onAction: @escaping (WorkoutsListViewModel.Action) -> Void
        ) -> WorkoutsListView
        
        @ViewBuilder let workoutDetailViewBuilder: (
            _ information: WorkoutInformation
        ) -> WorkoutDetailView
    }

    let dependencies: Dependencies

    var body: some View {
        dependencies.workoutsListViewBuilder { action in
            switch action {
            case let .showAddNewWorkout(onSave):
                router.presentSheet {
                    dependencies.addNewWorkoutViewBuilder { action in
                        switch action {
                        case .cancel:
                            router.dismissSheet()
                        case .save:
                            router.dismissSheet()
                            onSave()
                        }
                    }
                }
            case let .showWorkoutDetail(information):
                router.navigate(to: Destination.workoutDetail(information: information))
            }
        }
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case let .workoutDetail(information):
                dependencies.workoutDetailViewBuilder(information)
            }
        }
    }
}
