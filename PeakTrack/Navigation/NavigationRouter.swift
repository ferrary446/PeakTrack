//
//  NavigationRouter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

@MainActor
final class NavigationRouter: ObservableObject {
    @Published var sheetDestination: SheetDestination?
    @Published var path = NavigationPath()
}

extension NavigationRouter {
    func navigate<D: Hashable>(to destination: D) {
        path.append(destination)
    }

    func back() {
        path.removeLast()
    }

    func finish() {
        path = NavigationPath()
    }
}

extension NavigationRouter {
    func presentSheet<D: View>(@ViewBuilder destination: @escaping () -> D) {
        sheetDestination = SheetDestination(
            content: {
                AnyView(destination())
            }
        )
    }

    func dismissSheet() {
        sheetDestination = nil
    }
}
