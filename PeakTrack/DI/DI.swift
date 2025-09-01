//
//  DI.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

enum DI {
    static let live: any DIContainer = DIContainerImp()
}
