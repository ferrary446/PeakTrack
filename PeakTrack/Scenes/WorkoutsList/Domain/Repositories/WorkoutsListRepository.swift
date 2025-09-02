//
//  WorkoutsListRepository.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

protocol WorkoutsListRepository {
    func delete(by workoutID: UUID) async throws
    func getWorkouts() async throws -> [WorkoutInformation]
    func save(workout: WorkoutInformation) async throws
}
