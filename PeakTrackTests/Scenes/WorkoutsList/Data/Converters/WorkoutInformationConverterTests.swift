//
//  WorkoutInformationConverterTests.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 23.10.2025.
//

@testable import PeakTrack
import XCTest

final class WorkoutInformationConverterTests: XCTestCase {
    func test_givenDBEntity_whenConvert_thenWorkoutInformationMatched() {
        let dbEntity = WorkoutDBEntity(
            id: UUID(),
            name: "name",
            place: "place",
            duration: "duration"
        )
        let sut = makeSUT()

        let information = sut.convert(dbEntity: dbEntity)

        XCTAssertEqual(information.id, dbEntity.id)
        XCTAssertEqual(information.name, dbEntity.name)
        XCTAssertEqual(information.place, dbEntity.place)
        XCTAssertEqual(information.duration, dbEntity.duration)
    }

    func test_givenDTOEntity_whenConvert_thenWorkoutInformationMatched() {
        let dto = WorkoutDTOEntity(
            id: UUID().uuidString,
            name: "name",
            place: "place",
            duration: "duration"
        )
        let sut = makeSUT()

        let information = sut.convert(dto: dto)

        XCTAssertEqual(information.id.uuidString, dto.id)
        XCTAssertEqual(information.name, dto.name)
        XCTAssertEqual(information.place, dto.place)
        XCTAssertEqual(information.duration, dto.duration)
    }

    func test_givenDTOEntity_andIDNotUUID_whenConvert_thenWorkoutInformationMatched() {
        let dto = WorkoutDTOEntity(
            id: "3",
            name: "name",
            place: "place",
            duration: "duration"
        )
        let sut = makeSUT()

        let information = sut.convert(dto: dto)

        XCTAssertNotEqual(information.id.uuidString, dto.id)
        XCTAssertEqual(information.name, dto.name)
        XCTAssertEqual(information.place, dto.place)
        XCTAssertEqual(information.duration, dto.duration)
    }

    func test_givenWorkoutInformation_whenConvert_thenWorkoutDBEntityMatched() {
        let information: WorkoutInformation = .makeMock()
        let sut = makeSUT()

        let dbEntity: WorkoutDBEntity = sut.convert(domainModel: information)

        XCTAssertEqual(dbEntity.id, information.id)
        XCTAssertEqual(dbEntity.name, information.name)
        XCTAssertEqual(dbEntity.place, information.place)
        XCTAssertEqual(dbEntity.duration, information.duration)
    }

    func test_givenWorkoutInformation_whenConvert_thenWorkoutDTOEntityMatched() {
        let information: WorkoutInformation = .makeMock()
        let sut = makeSUT()

        let dbEntity: WorkoutDTOEntity = sut.convert(domainModel: information)

        XCTAssertEqual(dbEntity.id, information.id.uuidString)
        XCTAssertEqual(dbEntity.name, information.name)
        XCTAssertEqual(dbEntity.place, information.place)
        XCTAssertEqual(dbEntity.duration, information.duration)
    }
}

private extension WorkoutInformationConverterTests {
    func makeSUT() -> some WorkoutInformationConverter {
        WorkoutInformationConverterImp()
    }
}
