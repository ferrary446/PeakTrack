//
//  PeakTrackApp.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import FirebaseCore
import SwiftUI

@main
struct PeakTrackApp: App {
    @StateObject private var router = NavigationRouter()

    init() {
        FirebaseApp.configure()
        DIAssembler.assembly()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                makeWorkoutsListFlow()
            }
            .environmentObject(router)
            .sheet(item: $router.sheetDestination) { destination in
                destination.content()
            }
        }
    }
}

private extension PeakTrackApp {
    func makeWorkoutsListFlow() -> some View {
        WorkoutsListFlow(
            dependencies: WorkoutsListFlow.Dependencies(
                addNewWorkoutViewBuilder: { onAction in
                    let parameters = AddNewWorkoutViewModel.Parameters(
                        onAction: onAction
                    )

                    DI.live.resolve(
                        identifier: AddNewWorkoutView.self,
                        parameters: parameters
                    )
                },
                workoutsListViewBuilder: { onAction in
                    let parameters = WorkoutsListViewModel.Parameters(
                        onAction: onAction
                    )

                    DI.live.resolve(
                        identifier: WorkoutsListView.self,
                        parameters: parameters
                    )
                },
                workoutDetailViewBuilder: { information in
                    let parameters = WorkoutDetailView.Parameters(
                        information: information
                    )

                    DI.live.resolve(
                        identifier: WorkoutDetailView.self,
                        parameters: parameters
                    )
                }
            )
        )
    }
}
