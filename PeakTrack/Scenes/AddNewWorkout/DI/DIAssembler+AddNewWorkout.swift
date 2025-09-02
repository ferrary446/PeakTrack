//
//  DIAssembler+AddNewWorkout.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

extension DIAssembler {
    static func assembleAddNewWorkout() {
        DI.live.register(identifier: AddNewWorkoutView.self) { parameters in
            guard let parameters = parameters as? AddNewWorkoutViewModel.Parameters else {
                fatalError("Fail to cast \(parameters.self) to DI parameters")
            }

            let viewModel = AddNewWorkoutViewModel(parameters: parameters)

            return AddNewWorkoutView(viewModel: viewModel)
        }
    }
}
