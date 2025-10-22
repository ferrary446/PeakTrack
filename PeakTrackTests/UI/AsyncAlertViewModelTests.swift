//
//  AsyncAlertViewModelTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 22.10.2025.
//

@testable import PeakTrack
import XCTest

final class AsyncAlertViewModelTests: XCTestCase {
    func test_givenInitialized_thenAlertMatched() {
        let title = "Title"
        let message = "Message"
        let buttons = [
            AsyncAlertViewModel.ButtonViewModel(
                title: "ButtonTitle",
                role: nil,
                action: {}
            )
        ]
        let sut = makeSUT(title: title, message: message, buttons: buttons)
 
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.message, message)
        XCTAssertEqual(sut.buttons, buttons)
        XCTAssertEqual(sut.buttons.count, 1)
    }
}

private extension AsyncAlertViewModelTests {
    func makeSUT(
        title: String,
        message: String?,
        buttons: [AsyncAlertViewModel.ButtonViewModel]
    ) -> AsyncAlertViewModel {
        AsyncAlertViewModel(
            title: title,
            message: message,
            buttons: buttons
        )
    }
}
