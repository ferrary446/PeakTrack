//
//  NavigationRouter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

@MainActor
final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()

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
