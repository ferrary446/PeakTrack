# PeakTrack 🏋️‍♀️

A modern iOS workout tracking application built with SwiftUI that helps users manage and track their fitness routines with both local and cloud synchronization.

## Features

- 🏋️ **Workout Management**: Create, view, and delete workout sessions
- 📱 **Native iOS Experience**: Built entirely with SwiftUI for iOS
- ☁️ **Cloud Sync**: Seamless synchronization with Firebase/Firestore
- 📊 **Local Storage**: Offline-first approach with local data persistence
- 🎯 **Clean Architecture**: Modular design with separation of concerns
- 🧪 **Well Tested**: Comprehensive unit tests for business logic

## Architecture

PeakTrack follows Clean Architecture principles with MVVM pattern:

- **Presentation Layer**: SwiftUI views with ViewModels
- **Domain Layer**: Use cases and business logic
- **Data Layer**: Local and remote repositories with Firebase integration
- **Dependency Injection**: Modular DI system for testability

### Key Components

- `WorkoutsListViewModel`: Manages workout list state and operations
- `AddNewWorkoutViewModel`: Handles new workout creation
- `WorkoutDetailView`: Displays detailed workout information
- `NavigationRouter`: Centralized navigation management

## Technologies Used

- **SwiftUI** - Modern iOS UI framework
- **Firebase** - Backend-as-a-Service for data storage and sync
- **Async/Await** - Modern Swift concurrency

## Requirements

- iOS 18.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone [your-repo-url]
cd PeakTrack
```

2. Open the project in Xcode:
```bash
open PeakTrack.xcodeproj
```

3. Configure Firebase:
   - Add your `GoogleService-Info.plist` file to the project
   - Update Firebase configuration in `Constants.swift` with your project details

4. Build and run the project in Xcode

## Usage

### Adding a New Workout
1. Tap the "Add New Workout" button
2. Fill in workout details
3. Save to store locally and sync to cloud

### Managing Workouts
- View all workouts in the main list
- Filter by local or remote workouts
- Swipe to delete unwanted workouts
- Tap on any workout to view details

### Data Synchronization
- Workouts are automatically saved locally for offline access
- Cloud synchronization happens automatically when connected
- View data from both local and remote sources

## Testing

Run the test suite using Xcode's test navigator or via command line:

```bash
xcodebuild test -scheme PeakTrack -destination 'platform=iOS Simulator,name=iPhone 15'
```

The project includes comprehensive unit tests for:
- ViewModels
- Use cases
- Data repositories

## Project Structure

```
PeakTrack/
├── App/
│   ├── PeakTrackApp.swift          # Main app entry point
│   └── ContentView.swift           # Root content view
├── Presentation/
│   ├── WorkoutsListView.swift      # Main workout list
│   ├── AddNewWorkoutView.swift     # Add workout form
│   └── WorkoutDetailView.swift     # Workout details
├── ViewModels/
│   ├── WorkoutsListViewModel.swift # List management logic
│   └── AddNewWorkoutViewModel.swift # Add workout logic
├── Data/
│   ├── Local/
│   └── Remote/                     # Firebase integration
├── Domain/
│   ├── UseCases/                   # Business logic
│   └── Models/                     # Domain models
└── Tests/                          # Unit tests
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Author

Created by Ilya Yushkov

---

*PeakTrack - Track your fitness journey, one workout at a time* 🚀
