//
//  DIAssembler+AddNewWorkout.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

extension DIAssembler {
    static func assembleAddNewWorkout() {
        assembleAddNewWorkoutDomainLayer()
        assembleAddNewWorkoutPresentationLayer()
    }
}

// MARK: - Domain
private extension DIAssembler {
    static func assembleAddNewWorkoutDomainLayer() {
        DI.live.register(identifier: SaveWorkoutUseCase.self) {
            SaveWorkoutLiveUseCase(
                repository: DI.live.resolve(identifier: WorkoutsListRepository.self)
            )
        }
    }
}

// MARK: - Presentation
private extension DIAssembler {
    static func assembleAddNewWorkoutPresentationLayer() {
        DI.live.register(identifier: AddNewWorkoutView.self) { parameters in
            guard let parameters = parameters as? AddNewWorkoutViewModel.Parameters else {
                fatalError("Fail to cast \(parameters.self) to DI parameters")
            }

            let viewModel = AddNewWorkoutViewModel(
                dependencies: AddNewWorkoutViewModel.Dependencies(
                    saveWorkoutUseCase: DI.live.resolve(identifier: SaveWorkoutUseCase.self)
                ),
                parameters: parameters
            )

            return AddNewWorkoutView(viewModel: viewModel)
        }
    }
}
