//
//  WorkoutDBEntity.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation
import SwiftData

@Model
final class WorkoutDBEntity {
    var id: UUID
    var name: String
    var place: String
    var duration: String

    init(id: UUID, name: String, place: String, duration: String) {
        self.id = id
        self.name = name
        self.place = place
        self.duration = duration
    }
}
