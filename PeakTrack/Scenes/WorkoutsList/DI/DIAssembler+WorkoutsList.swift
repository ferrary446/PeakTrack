//
//  DIAssembler+WorkoutsList.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

extension DIAssembler {
    static func assembleWorkoutsList() {
        assembleWorkoutsListDataLayer()
        assembleWorkoutsListDomainLayer()
        assembleWorkoutsListPresentationLayer()
    }
}

// MARK: - Data
private extension DIAssembler {
    static func assembleWorkoutsListDataLayer() {
        DI.live.register(identifier: WorkoutInformationConverter.self) {
            WorkoutInformationConverterImp()
        }

        DI.live.register(identifier: WorkoutsListRepository.self) {
            WorkoutsListLocalRepository(
                converter: DI.live.resolve(identifier: WorkoutInformationConverter.self),
                manager: DI.live.resolve(identifier: DBManagerful.self)
            )
        }
    }
}

// MARK: - Domain
private extension DIAssembler {
    static func assembleWorkoutsListDomainLayer() {
        DI.live.register(identifier: DeleteWorkoutUseCase.self) {
            DeleteWorkoutLiveUseCase(
                repository: DI.live.resolve(identifier: WorkoutsListRepository.self)
            )
        }

        DI.live.register(identifier: GetWorkoutsUseCase.self) {
            GetWorkoutsLiveUseCase(
                repository: DI.live.resolve(identifier: WorkoutsListRepository.self)
            )
        }
    }
}

// MARK: - Presentation
private extension DIAssembler {
    static func assembleWorkoutsListPresentationLayer() {
        DI.live.register(identifier: WorkoutsListPresenter.self) {
            WorkoutsListPresenterImp()
        }

        DI.live.register(identifier: WorkoutsListView.self) { parameters in
            guard let parameters = parameters as? WorkoutsListViewModel.Parameters else {
                fatalError("Fail to cast \(parameters.self) to DI parameters")
            }

            let viewModel = WorkoutsListViewModel(
                dependencies: WorkoutsListViewModel.Dependencies(
                    deleteWorkoutUseCase: DI.live.resolve(identifier: DeleteWorkoutUseCase.self),
                    getWorkoutsUseCase: DI.live.resolve(identifier: GetWorkoutsUseCase.self),
                    presenter: DI.live.resolve(identifier: WorkoutsListPresenter.self)
                ),
                parameters: parameters
            )

            return WorkoutsListView(viewModel: viewModel)
        }
    }
}
