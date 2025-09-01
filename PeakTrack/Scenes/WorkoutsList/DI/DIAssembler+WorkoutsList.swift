//
//  DIAssembler+WorkoutsList.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

extension DIAssembler {
    static func assembleWorkoutsList() {
        DI.live.register(identifier: WorkoutsListView.self) {
            WorkoutsListView()
        }
    }
}
