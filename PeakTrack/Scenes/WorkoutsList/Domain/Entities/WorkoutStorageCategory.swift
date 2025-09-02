//
//  WorkoutStorageCategory.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

enum WorkoutStorageCategory: CaseIterable {
    case all
    case local
    case remote
}

extension WorkoutStorageCategory {
    var title: String {
        switch self {
        case .all:
            "All"
        case .local:
            "Local"
        case .remote:
            "Remote"
        }
    }
}
