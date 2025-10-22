//
//  WorkoutInformationConverter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import Foundation

protocol WorkoutInformationConverter {
    func convert(dto: WorkoutDTOEntity) -> WorkoutInformation
    func convert(dbEntity: WorkoutDBEntity) -> WorkoutInformation
    func convert(domainModel: WorkoutInformation) -> WorkoutDBEntity
    func convert(domainModel: WorkoutInformation) -> WorkoutDTOEntity
}

struct WorkoutInformationConverterImp: WorkoutInformationConverter {
    func convert(dto: WorkoutDTOEntity) -> WorkoutInformation {
        WorkoutInformation(
            id: UUID(uuidString: dto.id) ?? UUID(),
            name: dto.name,
            place: dto.place,
            duration: dto.duration
        )
    }

    func convert(dbEntity: WorkoutDBEntity) -> WorkoutInformation {
        WorkoutInformation(
            id: dbEntity.id,
            name: dbEntity.name,
            place: dbEntity.place,
            duration: dbEntity.duration
        )
    }

    func convert(domainModel: WorkoutInformation) -> WorkoutDBEntity {
        WorkoutDBEntity(
            id: domainModel.id,
            name: domainModel.name,
            place: domainModel.place,
            duration: domainModel.duration
        )
    }

    func convert(domainModel: WorkoutInformation) -> WorkoutDTOEntity {
        WorkoutDTOEntity(
            id: domainModel.id.uuidString,
            name: domainModel.name,
            place: domainModel.place,
            duration: domainModel.duration
        )
    }
}
