//
//  DIAssembler+FirestoreManager.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 21.10.2025.
//

import FirebaseFirestore

extension DIAssembler {
    @MainActor
    static func assembleFirestoreManager() {
        DI.live.register(identifier: FirestoreManagerful.self) {
            FirestoreManager(store: Firestore.firestore())
        }
    }
}
