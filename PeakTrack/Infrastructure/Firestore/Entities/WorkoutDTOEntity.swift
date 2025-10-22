//
//  WorkoutDTOEntity.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 21.10.2025.
//

import Foundation

struct WorkoutDTOEntity: Decodable {
    let id: String
    let name: String
    let place: String
    let duration: String
}
