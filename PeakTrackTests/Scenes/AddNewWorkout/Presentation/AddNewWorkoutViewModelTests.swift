//
//  AddNewWorkoutViewModelTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

@testable import PeakTrack
import XCTest

final class AddNewWorkoutViewModelTests: XCTestCase {
    @MainActor
    func test_whenCancelTapped_thenActionExecuted() {
        var actions = [AddNewWorkoutViewModel.Action]()
        let sut = makeSUT(
            onAction: { action in
                actions.append(action)
            }
        )

        sut.cancel()

        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions.first, .cancel)
    }

    @MainActor
    func test_givenNameIsEmpty_whenSaveToLocalTapped_thenActionNotExecuted() async {
        var actions = [AddNewWorkoutViewModel.Action]()
        let saveWorkoutUseCase = SaveWorkoutUseCaseSpy()
        let sut = makeSUT(
            saveWorkoutUseCase: saveWorkoutUseCase,
            onAction: { action in
                actions.append(action)
            }
        )

        await sut.saveTo(source: .local)

        XCTAssertEqual(actions.count, 0)
        XCTAssertNotNil(sut.alert)
        XCTAssertEqual(saveWorkoutUseCase.counter.count, 0)
    }

    @MainActor
    func test_givenNameIsNotEmpty_whenSaveTapped_thenActionExecuted() async {
        var actions = [AddNewWorkoutViewModel.Action]()
        let expectedSource: SourceType = .local
        let expectedWorkoutInformation: WorkoutInformation = .makeMock()
        let saveWorkoutUseCase = SaveWorkoutUseCaseSpy()
        let sut = makeSUT(
            saveWorkoutUseCase: saveWorkoutUseCase,
            onAction: { action in
                actions.append(action)
            }
        )
        sut.nameText = "name"
        sut.placeText = "place"
        sut.durationText = "duration"

        await sut.saveTo(source: expectedSource)

        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions.first, .save)
        XCTAssertNil(sut.alert)
        XCTAssertEqual(saveWorkoutUseCase.counter.count, 1)
        XCTAssertEqual(saveWorkoutUseCase.counter.first?.source, expectedSource)
        XCTAssertEqual(saveWorkoutUseCase.counter.first?.workout.name, expectedWorkoutInformation.name)
        XCTAssertEqual(saveWorkoutUseCase.counter.first?.workout.place, expectedWorkoutInformation.place)
        XCTAssertEqual(saveWorkoutUseCase.counter.first?.workout.duration, expectedWorkoutInformation.duration)
    }
}

private extension AddNewWorkoutViewModelTests {
    func makeSUT(
        saveWorkoutUseCase: SaveWorkoutUseCase = SaveWorkoutUseCaseSpy(),
        onAction: @escaping (AddNewWorkoutViewModel.Action) -> Void = { _ in }
    ) -> AddNewWorkoutViewModel {
        AddNewWorkoutViewModel(
            dependencies: AddNewWorkoutViewModel.Dependencies(
                saveWorkoutUseCase: saveWorkoutUseCase
            ),
            parameters: AddNewWorkoutViewModel.Parameters(
                onAction: onAction
            )
        )
    }
}
