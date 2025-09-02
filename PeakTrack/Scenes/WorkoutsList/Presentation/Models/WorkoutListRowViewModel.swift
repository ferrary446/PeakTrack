//
//  WorkoutListRowViewModel.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

struct WorkoutListRowViewModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String?
    let onTap: () -> Void

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
