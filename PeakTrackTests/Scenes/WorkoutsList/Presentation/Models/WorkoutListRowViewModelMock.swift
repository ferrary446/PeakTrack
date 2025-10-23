//
//  WorkoutListRowViewModelMock.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

import Foundation
@testable import PeakTrack

extension WorkoutListRowViewModel {
    static func makeMock(
        id: UUID = UUID(),
        title: String = "Test Workout",
        subtitle: String? = "Test Place • 30 min",
        onTap: @escaping () -> Void = {}
    ) -> WorkoutListRowViewModel {
        WorkoutListRowViewModel(
            id: id,
            title: title,
            subtitle: subtitle,
            onTap: onTap
        )
    }
}
