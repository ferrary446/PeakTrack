//
//  FirestoreManager.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 21.10.2025.
//

import FirebaseFirestore
import Foundation

protocol FirestoreManagerful {
    func getDocuments<E: Decodable>(
        collectionID: FirestoreManager.CollectionID,
        type: E.Type
    ) async throws -> [E]
}

final class FirestoreManager: FirestoreManagerful {
    enum CollectionID: String {
        case workouts
    }

    enum Errors: Error {
        case failedToGetDocuments
    }

    private let store: Firestore

    init(store: Firestore) {
        self.store = store
    }

    func getDocuments<E: Decodable>(
        collectionID: FirestoreManager.CollectionID,
        type: E.Type
    ) async throws -> [E] {
        do {
            let snapshot = try await store
                .collection(collectionID.rawValue)
                .getDocuments()

            let data = try snapshot.documents.map { document in
                try document.data(as: type)
            }

            return data
        } catch {
            throw Errors.failedToGetDocuments
        }
    }
//    func getDocuments<E: Decodable>(
//        collectionID: FirestoreManager.CollectionID,
//        type: E.Type
//    ) async throws -> [E] {
//        do {
//            let snapshot = try await store
//                .collection(collectionID.rawValue)
//                .document()
//                .
//
//            let data = try snapshot.documents.map { document in
//                try document.data(as: type)
//            }
//
//            return data
//        } catch {
//            throw Errors.failedToGetDocuments
//        }
//    }
}
