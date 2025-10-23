//
//  WorkoutDBEntityMock.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

extension WorkoutDBEntity {
    static func makeMock(
        id: UUID = UUID(),
        name: String = "name",
        place: String = "place",
        duration: String = "duration"
    ) -> WorkoutDBEntity {
        WorkoutDBEntity(
            id: id,
            name: name,
            place: place,
            duration: duration
        )
    }
}
