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

    func addDocument<C: Codable>(
        collectionID: FirestoreManager.CollectionID,
        document: C
    ) async throws

    func deleteDocument(
        collectionID: FirestoreManager.CollectionID,
        idField: String
    ) async throws
}

final class FirestoreManager: FirestoreManagerful {
    enum CollectionID: String {
        case workouts
    }

    enum Errors: Error {
        case failedToGetDocuments
        case failedToSaveDocument
        case failedToDeleteDocument
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

    func addDocument<C: Codable>(
        collectionID: FirestoreManager.CollectionID,
        document: C
    ) async throws {
        do {
            try await store
                .collection(collectionID.rawValue)
                .addDocument(data: document.asDictionary())
        } catch {
            throw Errors.failedToSaveDocument
        }
    }

    func deleteDocument(
        collectionID: FirestoreManager.CollectionID,
        idField: String
    ) async throws {
        do {
            let documents = try await store
                .collection(collectionID.rawValue)
                .whereField("id", isEqualTo: idField)
                .getDocuments()

            for document in documents.documents {
                try await document.reference.delete()
            }
        } catch {
            throw Errors.failedToDeleteDocument
        }
    }
}
