//
//  AddNewWorkoutAlertPresenter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

protocol AddNewWorkoutAlertPresenter {
    func present(
        message: String,
        onConfirm: @escaping () async -> Void
    ) -> AsyncAlertViewModel
}

struct AddNewWorkoutAlertPresenterImp: AddNewWorkoutAlertPresenter {
    func present(
        message: String,
        onConfirm: @escaping () async -> Void
    ) -> AsyncAlertViewModel {
        AsyncAlertViewModel(
            title: "Warning ⚠️",
            message: message,
            buttons: [
                AsyncAlertViewModel.ButtonViewModel(
                    title: "Confirm",
                    action: onConfirm
                )
            ]
        )
    }
}
