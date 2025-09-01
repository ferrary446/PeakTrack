//
//  PeakTrackApp.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

@main
struct PeakTrackApp: App {
    @StateObject private var navigationRouter = NavigationRouter()

    init() {
        DIAssembler.assembly()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.path) {
                EmptyView()
            }
            .environmentObject(navigationRouter)
        }
    }
}
