//
//  PeakTrackApp.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

@main
struct PeakTrackApp: App {
    init() {
        DIAssembler.assembly()
    }

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
