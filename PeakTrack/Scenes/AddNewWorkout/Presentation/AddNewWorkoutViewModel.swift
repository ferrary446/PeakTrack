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
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    @MainActor @Published var nameText: String = ""
    @MainActor @Published var placeText: String = ""
    @MainActor @Published var durationText: String = ""

    private let parameters: Parameters

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    @MainActor
    func cancel() {
        parameters.onAction(.cancel)
    }
}
