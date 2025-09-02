//
//  DIAssembler+DBManager.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

extension DIAssembler {
    @MainActor
    static func assembleDBManager() {
        DI.live.register(identifier: DBManagerful.self) {
            DBManager()
        }
    }
}
