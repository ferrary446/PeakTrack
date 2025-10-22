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
                ScrollView {
                    Text("No workout information")
                        .font(.headline)                    
                }
            case .loading:
                ProgressView()
            case let .content(rows):
                makeContentView(from: rows)
            }
        }
        .onLoad(perform: viewModel.onLoad)
        .refreshable {
            await viewModel.onLoad()
        }
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
    func makeContentView(from rows: [WorkoutListRowViewModel]) -> some View {
        List(rows) { row in
            Button(action: row.onTap) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(row.title)

                        row.subtitle.map { Text($0) }
                    }
                    
                    Spacer()

                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                }
            }
            .swipeActions(
                edge: .trailing,
                allowsFullSwipe: true,
                content: {
                    Button(
                        "Delete",
                        role: .destructive,
                        action: {
                            Task {
                                await viewModel.delete(workoutID: row.id)
                            }
                        }
                    )
                }
            )
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
                            action: { viewModel.filterWorkouts(by: category) },
                            label: {
                                HStack {
                                    Text(category.title)

                                    Spacer()

                                    if viewModel.currentCategory == category {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
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
