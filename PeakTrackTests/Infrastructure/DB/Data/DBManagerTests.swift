//
//  DBManagerTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class DBManagerTests: XCTestCase {
}

extension DBManagerTests {
    @MainActor
    func makeSUT() -> DBManagerful {
        DBManager()
    }
}
