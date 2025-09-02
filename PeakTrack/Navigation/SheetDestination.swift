//
//  SheetDestination.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation
import SwiftUI

struct SheetDestination: Identifiable {
    let id = UUID()
    @ViewBuilder let content: () -> AnyView
}
