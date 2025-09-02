//
//  DIAssembler+WorkoutsList.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

extension DIAssembler {
    static func assembleWorkoutsList() {
        DI.live.register(identifier: WorkoutsListView.self) { parameters in
            guard let parameters = parameters as? WorkoutsListViewModel.Parameters else {
                fatalError("Fail to cast \(parameters.self) to DI parameters")
            }

            let viewModel = WorkoutsListViewModel(
                parameters: parameters
            )

            return WorkoutsListView(viewModel: viewModel)
        }
    }
}
