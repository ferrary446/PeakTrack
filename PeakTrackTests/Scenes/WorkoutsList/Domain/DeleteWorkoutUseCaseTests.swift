//
//  DeleteWorkoutUseCaseTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class DeleteWorkoutUseCaseTests: XCTestCase {
    func test_whenUseCaseCalled_thenWorkoutDeletedSuccessfully() async throws {
        let workoutID = UUID()
        let source: SourceType = .local
        let repository = WorkoutsListRepositorySpy()
        let sut = makeSUT(repository: repository)

        try await sut(by: workoutID, source: source)

        XCTAssertEqual(repository.deleteCalls.count, 1)
        XCTAssertEqual(repository.deleteCalls.first?.workoutID, workoutID)
        XCTAssertEqual(repository.deleteCalls.first?.source, source)
    }

    func test_whenUseCaseCalled_andReceivedError_thenWorkoutDeleteFailed() async throws {
        let workoutID = UUID()
        let source: SourceType = .local
        let repository = WorkoutsListRepositorySpy(deleteErrorToThrow: { MockError.testError })
        let sut = makeSUT(repository: repository)

        do {
            try await sut(by: workoutID, source: source)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(repository.deleteCalls.count, 1)
            XCTAssertEqual(repository.deleteCalls.first?.workoutID, workoutID)
            XCTAssertEqual(repository.deleteCalls.first?.source, source)
        }
    }
}

private extension DeleteWorkoutUseCaseTests {
    func makeSUT(
        repository: WorkoutsListRepository = WorkoutsListRepositorySpy()
    ) -> some DeleteWorkoutUseCase {
        DeleteWorkoutLiveUseCase(
            repository: repository
        )
    }
}
