//
//  TestService.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

protocol TestService {
    var value: String { get }
}

struct SimpleTestService: TestService {
    let value: String
}

struct ParameterizedTestService: TestService {
    let value: String
    let parameter: String
}
