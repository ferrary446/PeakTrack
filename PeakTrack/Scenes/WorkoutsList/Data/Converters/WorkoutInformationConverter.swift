//
//  WorkoutInformationConverter.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

protocol WorkoutInformationConverter {
    func convert(dbEntity: WorkoutDBEntity) -> WorkoutInformation
    func convert(domainModel: WorkoutInformation) -> WorkoutDBEntity
}

struct WorkoutInformationConverterImp: WorkoutInformationConverter {
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
}
