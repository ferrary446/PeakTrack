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

    @MainActor @Published var alert: AsyncAlertViewModel?
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
    func saveTo(source: SourceType) async {
        guard !nameText.isEmpty else {
            setAlert(message: "Name field is required")
            return
        }

        do {
            let information = WorkoutInformation(
                id: UUID(),
                name: nameText,
                place: placeText,
                duration: durationText
            )

            try await dependencies.saveWorkoutUseCase(source: source, workout: information)
            parameters.onAction(.save)
        } catch {
            print(error.localizedDescription)
        }
    }
}

private extension AddNewWorkoutViewModel {
    @MainActor
    func setAlert(message: String) {
        let alert = AsyncAlertViewModel(
            title: "Warning ⚠️",
            message: message,
            buttons: [
                AsyncAlertViewModel.ButtonViewModel(
                    title: "Confirm",
                    action: { [weak self] in
                        self?.alert = nil
                    }
                )
            ]
        )

        self.alert = alert
    }
}
