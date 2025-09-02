//
//  PeakTrackApp.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

@main
struct PeakTrackApp: App {
    @StateObject private var router = NavigationRouter()

    init() {
        DIAssembler.assembly()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
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
            .environmentObject(router)
            .sheet(item: $router.sheetDestination) { destination in
                destination.content()
            }
        }
    }
}
