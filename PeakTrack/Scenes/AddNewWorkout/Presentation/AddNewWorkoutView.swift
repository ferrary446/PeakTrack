//
//  AddNewWorkoutView.swift
//  PeakTrack
//
//  Created by Ilya Yushkov on 02.09.2025.
//

import SwiftUI

struct AddNewWorkoutView: View {
    enum AddNewWorkoutFocusStates: Equatable {
        case name
        case place
        case duration
    }

    @FocusState private var focusState: AddNewWorkoutFocusStates?
    @StateObject private var viewModel: AddNewWorkoutViewModel

    init(viewModel: AddNewWorkoutViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: viewModel.cancel) {
                Image(systemName: "xmark")
            }
            .padding()

            VStack(spacing: 0) {
                makeWorkoutImageView()
                    .padding(.top, 32)
                    .padding(.bottom, 64)

                makeNewWorkoutContentView()

                Spacer()

                makeArrowContentView()

                Spacer()

                makeButtonsContentView()
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .onTapGesture {
                focusState = nil
            }
        }
        .alert(model: $viewModel.alert)
    }
}

private extension AddNewWorkoutView {
    func makeArrowContentView() -> some View {
        HStack(spacing: 32) {
            Image(systemName: "arrow.down.left")
                .resizable()
                .frame(width: 60, height: 60)

            Image(systemName: "arrow.down.right")
                .resizable()
                .frame(width: 60, height: 60)
        }
    }
}

private extension AddNewWorkoutView {
    func makeWorkoutImageView() -> some View {
        Image(.workout)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
    }
}

private extension AddNewWorkoutView {
    func makeButtonsContentView() -> some View {
        HStack(spacing: 0) {
            Button(
                action: {
                    Task {
                        await viewModel.saveTo(source: .local)
                    }
                },
                label: {
                    Label("Save to DB", systemImage: "server.rack")
                }
            )

            Spacer()

            Button(
                action: {
                    Task {
                        await viewModel.saveTo(source: .remote)
                    }
                },
                label: {
                    Label("Save to Server", systemImage: "network")
                }
            )
        }
    }
}

private extension AddNewWorkoutView {
    func makeNewWorkoutContentView() -> some View {
        VStack(alignment: .leading) {
            Text("New workout")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 16)

            VStack(spacing: 16) {
                TextField("Name", text: $viewModel.nameText)
                    .focused($focusState, equals: .name)

                Divider()

                TextField("Place", text: $viewModel.placeText)
                    .focused($focusState, equals: .place)

                Divider()

                TextField("Duration", text: $viewModel.durationText)
                    .focused($focusState, equals: .duration)
            }
            .autocorrectionDisabled(true)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.blue, lineWidth: 5)
                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
            }
        }
    }
}
