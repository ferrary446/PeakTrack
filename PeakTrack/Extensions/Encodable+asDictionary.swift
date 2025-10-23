//
//  Encodable+asDictionary.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }

        let dictionary = try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any]

        guard let dictionary else {
            return [:]
        }

        return dictionary
    }
}
