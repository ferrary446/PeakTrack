//
//  APIClient.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import Foundation

protocol APIClient {
    func run<D: Decodable>() async throws -> D
}

// TODO: -IY- Implementation
struct APIClientImp: APIClient {
    func run<D: Decodable>() async throws -> D {
//        let (data, response) = try await URLSession.shared.data(for: <#T##URLRequest#>)
        let decodedData = try JSONDecoder().decode(D.self, from: Data())
        return decodedData
    }
}
