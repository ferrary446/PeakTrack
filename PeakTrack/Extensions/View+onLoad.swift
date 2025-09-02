//
//  View+onLoad.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

extension View {
    func onLoad(perform action: @escaping () async -> Void) -> some View {
        self
            .modifier(ViewDidLoadModifier(action: action))
    }
}

private struct ViewDidLoadModifier: ViewModifier {
    @State private var hasLoaded = false

    private let action: () async -> Void

    init(action: @escaping () async -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .task {
                guard !hasLoaded else {
                    return
                }

                await action()
                hasLoaded = true
            }
    }
}
