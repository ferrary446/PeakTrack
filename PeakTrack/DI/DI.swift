//
//  DI.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

// swiftlint:disable type_name
enum DI {
    static let live: any DIContainer = DIContainerImp()
}
// swiftlint:enable type_name
