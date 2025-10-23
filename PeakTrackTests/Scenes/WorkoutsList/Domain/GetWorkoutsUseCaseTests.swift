//
//  GetWorkoutsUseCaseTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class GetWorkoutsUseCaseTests: XCTestCase {
    func test_whenUseCaseCalled_thenWorkoutsRetrievedSuccessfully() async throws {
        let source: SourceType = .local
        let expectedWorkouts: [WorkoutInformation] = [.makeMock(), .makeMock()]
        let repository = WorkoutsListRepositorySpy(workoutsToReturn: expectedWorkouts)
        let sut = makeSUT(repository: repository)

        let result = try await sut(source: source)

        XCTAssertEqual(repository.getWorkoutsCalls.count, 1)
        XCTAssertEqual(repository.getWorkoutsCalls.first?.source, source)
        XCTAssertEqual(result.count, expectedWorkouts.count)
        XCTAssertEqual(result, expectedWorkouts)
    }

    func test_whenUseCaseCalled_andReceivedError_thenGetWorkoutsFailed() async throws {
        let source: SourceType = .local
        let repository = WorkoutsListRepositorySpy(getWorkoutsErrorToThrow: { MockError.testError })
        let sut = makeSUT(repository: repository)

        do {
            _ = try await sut(source: source)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(repository.getWorkoutsCalls.count, 1)
            XCTAssertEqual(repository.getWorkoutsCalls.first?.source, source)
            XCTAssertTrue(error is MockError)
        }
    }

    func test_whenUseCaseCalled_withEmptyResult_thenReturnsEmptyArray() async throws {
        let source: SourceType = .local
        let repository = WorkoutsListRepositorySpy(workoutsToReturn: [])
        let sut = makeSUT(repository: repository)

        let result = try await sut(source: source)

        XCTAssertEqual(repository.getWorkoutsCalls.count, 1)
        XCTAssertEqual(repository.getWorkoutsCalls.first?.source, source)
        XCTAssertTrue(result.isEmpty)
    }
}

private extension GetWorkoutsUseCaseTests {
    func makeSUT(
        repository: WorkoutsListRepository = WorkoutsListRepositorySpy()
    ) -> some GetWorkoutsUseCase {
        GetWorkoutsLiveUseCase(
            repository: repository
        )
    }
}
