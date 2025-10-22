//
//  AddNewWorkoutAlertPresenterSpy.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

@testable import PeakTrack

final class AddNewWorkoutAlertPresenterSpy: AddNewWorkoutAlertPresenter {
    struct Call {
        let message: String
        let onConfirm: () async -> Void
    }

    private(set) var calls = [Call]()

    func present(
        message: String,
        onConfirm: @escaping () async -> Void
    ) -> AsyncAlertViewModel {
        calls.append(Call(message: message, onConfirm: onConfirm))

        return AsyncAlertViewModel(
            title: "title",
            message: message,
            buttons: [
                AsyncAlertViewModel.ButtonViewModel(
                    title: "title",
                    action: onConfirm
                )
            ]
        )
    }
}
