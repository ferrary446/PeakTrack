//
//  WorkoutsListFlow.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

struct WorkoutsListFlow: View {
    enum Destination: Hashable {
        case workoutDetail
    }

    @EnvironmentObject private var router: NavigationRouter

    struct Dependencies {
        @ViewBuilder let addNewWorkoutViewBuilder: (
            _ onAction: @escaping (AddNewWorkoutViewModel.Action) -> Void
        ) -> AddNewWorkoutView

        @ViewBuilder let workoutsListViewBuilder: (
            _ onAction: @escaping (WorkoutsListViewModel.Action) -> Void
        ) -> WorkoutsListView
    }

    let dependencies: Dependencies

    var body: some View {
        dependencies.workoutsListViewBuilder { action in
            switch action {
            case .showAddNewWorkout:
                router.presentSheet {
                    dependencies.addNewWorkoutViewBuilder { action in
                        switch action {
                        case .cancel:
                            router.dismissSheet()
                        }
                    }
                }
            case .showWorkoutDetail:
                router.navigate(to: Destination.workoutDetail)
            }
        }
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .workoutDetail:
                EmptyView()
            }
        }
    }
}
