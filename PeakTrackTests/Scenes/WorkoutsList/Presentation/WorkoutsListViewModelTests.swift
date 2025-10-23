//
//  WorkoutsListViewModelTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack
import XCTest

final class WorkoutsListViewModelTests: XCTestCase {
    @MainActor
    func test_givenEmptyWorkouts_whenOnLoad_thenStateIsEmpty() async {
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: [])
        let sut = makeSUT(getWorkoutsUseCase: getWorkoutsUseCase)

        await sut.onLoad()

        XCTAssertEqual(sut.state, .empty)
        XCTAssertEqual(sut.currentCategory, .all)
        XCTAssertEqual(getWorkoutsUseCase.counter, 2)
    }

    @MainActor
    func test_givenWorkoutsAvailable_whenOnLoad_thenStateIsContent() async {
        let mockWorkouts = [WorkoutInformation.makeMock()]
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: mockWorkouts)
        let mockRowViewModels = [WorkoutListRowViewModel.makeMock()]
        let presenter = WorkoutsListPresenterSpy(presentReturnValue: mockRowViewModels)
        let sut = makeSUT(
            getWorkoutsUseCase: getWorkoutsUseCase,
            presenter: presenter
        )

        await sut.onLoad()

        XCTAssertEqual(sut.state, .content(mockRowViewModels))
        XCTAssertEqual(sut.currentCategory, .all)
        XCTAssertEqual(getWorkoutsUseCase.counter, 2)
        XCTAssertEqual(presenter.calls.count, 1)
    }

    @MainActor
    func test_givenGetWorkoutsThrowsError_whenOnLoad_thenStateIsEmpty() async {
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(errorToThrow: { MockError.testError })
        let sut = makeSUT(getWorkoutsUseCase: getWorkoutsUseCase)

        await sut.onLoad()

        XCTAssertEqual(sut.state, .empty)
    }

    // MARK: - addNewWorkout Tests

    @MainActor
    func test_whenAddNewWorkoutCalled_thenCorrectActionExecuted() {
        var actions = [WorkoutsListViewModel.Action]()
        let sut = makeSUT(
            onAction: { action in
                actions.append(action)
            }
        )

        sut.addNewWorkout()

        guard case .showAddNewWorkout = actions.first else {
            return XCTFail("Expected showAddNewWorkout action")
        }
        XCTAssertEqual(actions.count, 1)
    }

    @MainActor
    func test_givenWorkoutExistsInLocal_whenDelete_thenDeleteUseCaseCalledWithCorrectParameters() async {
        let mockWorkout = WorkoutInformation.makeMock()
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: [mockWorkout])
        let deleteWorkoutUseCase = DeleteWorkoutUseCaseSpy()
        let sut = makeSUT(
            deleteWorkoutUseCase: deleteWorkoutUseCase,
            getWorkoutsUseCase: getWorkoutsUseCase
        )

        await sut.onLoad()

        await sut.delete(workoutID: mockWorkout.id)

        XCTAssertEqual(deleteWorkoutUseCase.calls.count, 1)
        XCTAssertEqual(deleteWorkoutUseCase.calls.first?.workoutID, mockWorkout.id)
        XCTAssertEqual(deleteWorkoutUseCase.calls.first?.source, .local)
    }

    @MainActor
    func test_givenWorkoutDoesNotExist_whenDelete_thenDeleteUseCaseNotCalled() async {
        let deleteWorkoutUseCase = DeleteWorkoutUseCaseSpy()
        let sut = makeSUT(deleteWorkoutUseCase: deleteWorkoutUseCase)

        await sut.delete(workoutID: UUID())

        XCTAssertEqual(deleteWorkoutUseCase.calls.count, 0)
    }

    @MainActor
    func test_givenDeleteThrowsError_whenDelete_thenOnLoadCalledAgain() async {
        let mockWorkout = WorkoutInformation.makeMock()
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: [mockWorkout])
        let deleteWorkoutUseCase = DeleteWorkoutUseCaseSpy(errorToThrow: { MockError.testError })
        let sut = makeSUT(
            deleteWorkoutUseCase: deleteWorkoutUseCase,
            getWorkoutsUseCase: getWorkoutsUseCase
        )

        let initialCounter = getWorkoutsUseCase.counter
        await sut.onLoad()

        await sut.delete(workoutID: mockWorkout.id)

        XCTAssertEqual(deleteWorkoutUseCase.calls.count, 1)
        XCTAssertEqual(getWorkoutsUseCase.counter, initialCounter + 2)
    }

    @MainActor
    func test_whenFilterWorkoutsByCategory_thenCurrentCategoryUpdated() async {
        let mockWorkouts = [WorkoutInformation.makeMock()]
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: mockWorkouts)
        let sut = makeSUT(getWorkoutsUseCase: getWorkoutsUseCase)

        await sut.onLoad()

        sut.filterWorkouts(by: .local)

        XCTAssertEqual(sut.currentCategory, .local)
    }

    @MainActor
    func test_givenWorkoutsLoadedAndFilteredByLocal_whenFilterWorkouts_thenStateUpdatedWithLocalWorkouts() async {
        let mockWorkouts = [WorkoutInformation.makeMock()]
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: mockWorkouts)
        let mockRowViewModels = [WorkoutListRowViewModel.makeMock()]
        let presenter = WorkoutsListPresenterSpy(presentReturnValue: mockRowViewModels)
        let sut = makeSUT(
            getWorkoutsUseCase: getWorkoutsUseCase,
            presenter: presenter
        )

        await sut.onLoad()

        sut.filterWorkouts(by: .local)

        XCTAssertEqual(sut.currentCategory, .local)
        XCTAssertEqual(sut.state, .content(mockRowViewModels))
    }

    @MainActor
    func test_givenWorkoutExistsWhenPresenterCallsOnSelectWorkout_thenShowWorkoutDetailActionExecuted() async {
        var actions = [WorkoutsListViewModel.Action]()
        let mockWorkout = WorkoutInformation.makeMock()
        let getWorkoutsUseCase = GetWorkoutsUseCaseSpy(workoutsToReturn: [mockWorkout])
        let presenter = WorkoutsListPresenterSpy()
        let sut = makeSUT(
            getWorkoutsUseCase: getWorkoutsUseCase,
            presenter: presenter,
            onAction: { action in
                actions.append(action)
            }
        )

        await sut.onLoad()

        presenter.calls.first?.onSelectWorkout(mockWorkout.id)

        guard case .showWorkoutDetail = actions.first else {
            return XCTFail("Expected showWorkoutDetail action")
        }
        XCTAssertEqual(actions.count, 1)
    }
}

private extension WorkoutsListViewModelTests {
    func makeSUT(
        deleteWorkoutUseCase: DeleteWorkoutUseCase = DeleteWorkoutUseCaseSpy(),
        getWorkoutsUseCase: GetWorkoutsUseCase = GetWorkoutsUseCaseSpy(),
        presenter: WorkoutsListPresenter = WorkoutsListPresenterSpy(),
        onAction: @escaping (WorkoutsListViewModel.Action) -> Void = { _ in }
    ) -> WorkoutsListViewModel {
        WorkoutsListViewModel(
            dependencies: WorkoutsListViewModel.Dependencies(
                deleteWorkoutUseCase: deleteWorkoutUseCase,
                getWorkoutsUseCase: getWorkoutsUseCase,
                presenter: presenter
            ),
            parameters: WorkoutsListViewModel.Parameters(
                onAction: onAction
            )
        )
    }
}
