# PeakTrack

A SwiftUI workout tracking application built with modern iOS architecture patterns.

## Architecture Overview

PeakTrack follows a **Clean Architecture** pattern with **Dependency Injection**, providing a scalable and maintainable codebase. The app uses Firebase for data persistence and SwiftUI for the user interface.

### Key Architectural Components

- **Clean Architecture**: Separation of concerns across Data, Domain, and Presentation layers
- **Dependency Injection**: Custom DI container for loose coupling and testability
- **Flow-based Navigation**: Coordinated navigation using `NavigationRouter` and flow controllers
- **MVVM Pattern**: ViewModels handle business logic and state management

## Project Structure

```
PeakTrack/
├── App/
│   └── PeakTrackApp.swift              # Main app entry point
├── Architecture/
│   ├── DI/
│   │   ├── DI.swift                    # DI container access point
│   │   ├── DIContainer.swift           # DI container protocol and implementation
│   │   └── DIAssembler.swift           # Main DI assembly coordinator
│   └── Navigation/
│       └── NavigationRouter.swift      # Centralized navigation management
├── Features/
│   ├── WorkoutsList/
│   │   ├── Flow/
│   │   │   └── WorkoutsListFlow.swift  # Flow coordinator for workouts list
│   │   ├── Presentation/
│   │   │   ├── WorkoutsListView.swift
│   │   │   ├── WorkoutsListViewModel.swift
│   │   │   └── WorkoutsListPresenter.swift
│   │   ├── Domain/
│   │   │   └── UseCases/
│   │   └── Data/
│   │       └── Repositories/
│   ├── AddNewWorkout/
│   │   └── [Similar structure to WorkoutsList]
│   └── WorkoutDetail/
│       └── [Similar structure to WorkoutsList]
└── DI Assembly/
    ├── DIAssembler+WorkoutsList.swift  # DI setup for WorkoutsList feature
    ├── DIAssembler+AddNewWorkout.swift # DI setup for AddNewWorkout feature
    ├── DIAssembler+WorkoutDetail.swift # DI setup for WorkoutDetail feature
    ├── DIAssembler+DBManager.swift     # Database manager DI setup
    └── DIAssembler+FirestoreManager.swift # Firestore manager DI setup
```

## Architecture Layers

### 1. Presentation Layer
- **Views**: SwiftUI views that compose the user interface
- **ViewModels**: Handle UI state and user interactions
- **Presenters**: Format data for display in views
- **Flows**: Coordinate navigation and screen transitions

### 2. Domain Layer
- **Use Cases**: Encapsulate business logic and application rules
- **Entities**: Core business objects and data models
- **Repository Protocols**: Define data access interfaces

### 3. Data Layer
- **Repositories**: Implement data access logic
- **Local Data Sources**: Core Data or local storage
- **Remote Data Sources**: Firebase/Firestore integration
- **Converters**: Transform between data models and domain entities

## Key Features

### Flow-based Navigation
Each major feature is organized around a "Flow" that coordinates navigation:

```swift
struct WorkoutsListFlow: View {
    // Handles navigation between:
    // - Workouts list
    // - Add new workout (sheet)
    // - Workout detail (navigation)
}
```

### Dependency Injection
The app uses a custom DI container for managing dependencies:

```swift
// Registration
DI.live.register(identifier: WorkoutsListView.self) { parameters in
    // Create and return configured view
}

// Resolution
let view = DI.live.resolve(
    identifier: WorkoutsListView.self,
    parameters: parameters
)
```

### Navigation Management
Centralized navigation through `NavigationRouter`:

```swift
@MainActor
final class NavigationRouter: ObservableObject {
    @Published var sheetDestination: SheetDestination?
    @Published var path = NavigationPath()
    
    func navigate<D: Hashable>(to destination: D)
    func presentSheet<D: View>(@ViewBuilder destination: @escaping () -> D)
}
```

## Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+
- Firebase account and project setup

### Installation

1. Clone the repository
2. Open `PeakTrack.xcodeproj` in Xcode
3. Configure Firebase:
   - Add your `GoogleService-Info.plist` file to the project
   - Ensure Firebase SDK is properly integrated
4. Build and run

### Firebase Setup
The app uses Firebase for data persistence. Make sure to:
1. Create a Firebase project
2. Enable Firestore Database
3. Configure authentication if needed
4. Download and add the `GoogleService-Info.plist` file

## Development Guidelines

### Adding New Features
1. Create feature folder structure following the established pattern
2. Implement Clean Architecture layers (Presentation → Domain → Data)
3. Create DI assembly extension (`DIAssembler+FeatureName.swift`)
4. Add flow coordinator for navigation
5. Register dependencies in the main assembly method

### Dependency Injection Pattern
- Register all dependencies during app startup in `DIAssembler`
- Use protocols for dependency abstraction
- Pass parameters through dedicated parameter objects
- Resolve dependencies at the composition root

### Navigation Pattern
- Use flows to coordinate navigation within feature boundaries
- Leverage `NavigationRouter` for centralized navigation state
- Handle both push navigation and sheet presentation
- Keep navigation logic separate from business logic

## Testing

The architecture supports easy testing through:
- Dependency injection for mock substitution
- Clean separation of layers
- Protocol-based abstractions
- Isolated business logic in use cases

## Technologies Used

- **SwiftUI**: User interface framework
- **Firebase/Firestore**: Backend and database
- **Swift Concurrency**: Async/await for asynchronous operations
- **Clean Architecture**: Architectural pattern
- **MVVM**: Presentation layer pattern
- **Dependency Injection**: Custom DI container

## Contributing

1. Follow the established architecture patterns
2. Maintain separation of concerns across layers
3. Use dependency injection for all external dependencies
4. Write comprehensive tests for business logic
5. Follow Swift style guidelines and best practices