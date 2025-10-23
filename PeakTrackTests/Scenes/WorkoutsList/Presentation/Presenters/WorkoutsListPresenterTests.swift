//
//  WorkoutsListPresenterTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
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
        XCTAssertEqual(workouts.first?.id, rows.first?.id)
        XCTAssertEqual(workouts.first?.name, rows.first?.title)
        XCTAssertEqual(workouts.first?.place, rows.first?.subtitle)
    }

    func test_givenEmptyPlace_whenPresent_thenSubtitleNil() {
        let workouts: [WorkoutInformation] = [
            .makeMock(place: "")
        ]
        let sut = makeSUT()

        let rows = sut.present(
            workouts: workouts,
            onSelectWorkout: { _ in }
        )

        XCTAssertNil(rows.first?.subtitle)
    }

    func test_givenPresentedRows_whenRowTapped_thenIDMatched() {
        var receivedIDs = [UUID]()
        let expectedID = UUID()
        let workouts: [WorkoutInformation] = [
            .makeMock(id: expectedID)
        ]
        let sut = makeSUT()
        let rows = sut.present(
            workouts: workouts,
            onSelectWorkout: { id in
                receivedIDs.append(id)
            }
        )

        rows.first?.onTap()

        XCTAssertEqual(receivedIDs.count, 1)
        XCTAssertEqual(receivedIDs.first, expectedID)
    }
}

private extension WorkoutsListPresenterTests {
    func makeSUT() -> some WorkoutsListPresenter {
        WorkoutsListPresenterImp()
    }
}
