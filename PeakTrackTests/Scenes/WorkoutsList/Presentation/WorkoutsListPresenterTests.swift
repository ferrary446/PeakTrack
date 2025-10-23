//
//  WorkoutsListPresenterTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class WorkoutsListPresenterTests: XCTestCase {
    func test_whenPresent_thenRowsMatched() {
        let workouts: [WorkoutInformation] = [
            .makeMock(),
            .makeMock()
        ]
        let sut = makeSUT()

        let rows = sut.present(
            workouts: workouts,
            onSelectWorkout: { _ in }
        )

        XCTAssertEqual(rows.count, 2)
    }
}

private extension WorkoutsListPresenterTests {
    func makeSUT() -> some WorkoutsListPresenter {
        WorkoutsListPresenterImp()
    }
}
