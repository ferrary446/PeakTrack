//
//  WorkoutDetailView.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import SwiftUI

struct WorkoutDetailView: View {
    struct Parameters {
        let information: WorkoutInformation
    }

    let parameters: Parameters

    var body: some View {
        VStack(spacing: 16) {
            Text(parameters.information.place)
            Text(parameters.information.duration)
        }
        .navigationTitle(parameters.information.name)
    }
}
