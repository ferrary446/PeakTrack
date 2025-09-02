//
//  WorkoutInformation.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

struct WorkoutInformation: Hashable {
    let id: UUID
    let name: String
    let place: String
    let duration: String
}
