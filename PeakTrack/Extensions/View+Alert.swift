//
//  View+Alert.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import SwiftUI

extension View {
    func alert(model: Binding<AsyncAlertViewModel?>) -> some View {
        self
            .alert(
                model.wrappedValue?.title ?? "",
                isPresented: Binding(
                    get: { model.wrappedValue != nil },
                    set: { newValue in
                        if !newValue {
                            model.wrappedValue = nil
                        }
                    }
                ),
                actions: {
                    ForEach(model.wrappedValue?.buttons ?? []) { button in
                        Button(button.title, role: button.role) {
                            Task {
                                await button.action()
                            }
                        }
                    }
                },
                message: {
                    if let message = model.wrappedValue?.message {
                        Text(message)
                    }
                }
            )
    }
}
