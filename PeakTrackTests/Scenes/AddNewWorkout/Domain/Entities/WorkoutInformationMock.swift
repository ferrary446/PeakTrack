//
//  WorkoutInformationMock.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

import Foundation
@testable import PeakTrack

extension WorkoutInformation {
    static func makeMock(
        id: UUID = UUID(),
        name: String = "name",
        place: String = "place",
        duration: String = "duration"
    ) -> Self {
        WorkoutInformation(
            id: id,
            name: name,
            place: place,
            duration: duration
        )
    }
}
