//
//  WorkoutsListView.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 01.09.2025.
//

import SwiftUI

struct WorkoutsListView: View {
    @StateObject private var viewModel: WorkoutsListViewModel

    init(viewModel: WorkoutsListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .empty:
                Text("No workout information")
                    .font(.headline)
            case .loading:
                ProgressView()
            case .content:
                List {
                    
                }
                .refreshable {
                    await viewModel.onLoad()
                }
            }
        }
        .onLoad(perform: viewModel.onLoad)
        .navigationTitle("Workouts")
        .toolbar {
            filterMenuToolbarContent()
        }
        .toolbar {
            addButtonToolbarContent()
        }
    }
}

// MARK: - ToolbarContent
private extension WorkoutsListView {
    func addButtonToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: viewModel.addNewWorkout) {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .foregroundStyle(.blue)
            }
        }
    }

    func filterMenuToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu(
                content: {
                    ForEach(WorkoutStorageCategory.allCases, id: \.title) { category in
                        Button(
                            category.title,
                            action: { viewModel.filterWorkouts(by: category) }
                        )
                    }
                },
                label: {
                    Text("Filter")
                        .foregroundStyle(.blue)
                }
            )
        }
    }
}
