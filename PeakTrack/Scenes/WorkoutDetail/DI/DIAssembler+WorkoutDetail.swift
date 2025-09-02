//
//  DIAssembler+WorkoutDetail.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

extension DIAssembler {
    static func assembleWorkoutDetail() {
        assembleWorkoutDetailPresentationLayer()
    }
}

// MARK: - Presentation
private extension DIAssembler {
    static func assembleWorkoutDetailPresentationLayer() {
        DI.live.register(identifier: WorkoutDetailView.self) { parameters in
            guard let parameters = parameters as? WorkoutDetailView.Parameters else {
                fatalError("Fail to cast \(parameters.self) to DI parameters")
            }

            return WorkoutDetailView(parameters: parameters)
        }
    }
}
