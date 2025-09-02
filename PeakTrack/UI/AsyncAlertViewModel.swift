//
//  AsyncAlertViewModel.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation
import SwiftUI

struct AsyncAlertViewModel {
    struct ButtonViewModel: Identifiable {
        let id = UUID()
        let title: String
        let role: ButtonRole?
        let action: () async -> Void

        init(title: String, role: ButtonRole? = nil, action: @escaping () async -> Void) {
            self.title = title
            self.role = role
            self.action = action
        }
    }

    let title: String
    let message: String?
    let buttons: [ButtonViewModel]

    init(title: String, message: String? = nil, buttons: [ButtonViewModel]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}
