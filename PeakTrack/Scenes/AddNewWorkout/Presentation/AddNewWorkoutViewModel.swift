//
//  AddNewWorkoutViewModel.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

final class AddNewWorkoutViewModel: ObservableObject {
    enum Action {
        case cancel
        case save
    }

    struct Dependencies {
        let saveWorkoutUseCase: SaveWorkoutUseCase
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    @MainActor @Published var nameText: String = ""
    @MainActor @Published var placeText: String = ""
    @MainActor @Published var durationText: String = ""

    private let dependencies: Dependencies
    private let parameters: Parameters

    init(dependencies: Dependencies, parameters: Parameters) {
        self.dependencies = dependencies
        self.parameters = parameters
    }

    @MainActor
    func cancel() {
        parameters.onAction(.cancel)
    }

    @MainActor
    func saveToDB() async {
        guard !nameText.isEmpty || !placeText.isEmpty || !durationText.isEmpty else {
            return
        }

        do {
            let information = WorkoutInformation(
                id: UUID(),
                name: nameText,
                place: placeText,
                duration: durationText
            )

            try await dependencies.saveWorkoutUseCase(workout: information)
            parameters.onAction(.save)
        } catch {
            print(error.localizedDescription)
        }
    }
}
