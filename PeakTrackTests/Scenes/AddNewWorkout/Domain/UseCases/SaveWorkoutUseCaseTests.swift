//
//  SaveWorkoutUseCaseTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class SaveWorkoutUseCaseTests: XCTestCase {
    func test_whenUseCaseCalled_thenWorkoutSavedSuccessfully() async throws {
        let source: SourceType = .local
        let workoutInformation: WorkoutInformation = .makeMock()
        let repository = WorkoutsListRepositorySpy()
        let sut = makeSUT(repository: repository)

        try await sut(source: source, workout: workoutInformation)

        XCTAssertEqual(repository.saveCalls.count, 1)
        XCTAssertEqual(repository.saveCalls.first?.source, source)
        XCTAssertEqual(repository.saveCalls.first?.workout, workoutInformation)
    }

    func test_whenUseCaseCalled_andReceivedError_thenWorkoutSavedFailed() async throws {
        let source: SourceType = .local
        let workoutInformation: WorkoutInformation = .makeMock()
        let repository = WorkoutsListRepositorySpy(saveErrorToThrow: { MockError.testError })
        let sut = makeSUT(repository: repository)

        do {
            try await sut(source: source, workout: workoutInformation)
        } catch {
            XCTAssertEqual(repository.saveCalls.count, 1)
            XCTAssertEqual(repository.saveCalls.first?.source, source)
            XCTAssertEqual(repository.saveCalls.first?.workout, workoutInformation)
        }
    }
}

private extension SaveWorkoutUseCaseTests {
    func makeSUT(
        repository: WorkoutsListRepository = WorkoutsListRepositorySpy()
    ) -> some SaveWorkoutUseCase {
        SaveWorkoutLiveUseCase(
            repository: repository
        )
    }
}
