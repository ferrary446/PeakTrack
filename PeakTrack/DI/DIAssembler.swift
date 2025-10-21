//
//  DIAssembler.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

enum DIAssembler {
    @MainActor
    static func assembly() {
        assembleInfrastructure()
        assembleScenes()
    }
}

private extension DIAssembler {
    @MainActor
    static func assembleInfrastructure() {
        assembleDBManager()
        assembleFirestoreManager()
    }
}

private extension DIAssembler {
    static func assembleScenes() {
        assembleAddNewWorkout()
        assembleWorkoutDetail()
        assembleWorkoutsList()
    }
}
