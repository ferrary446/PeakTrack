# PeakTrack 🏃‍♂️

A modern iOS workout tracking application built with SwiftUI and Clean Architecture principles. PeakTrack allows users to manage their workout information with both local and remote storage capabilities.

## 📱 Features

- **Workout Management**: Create, view, and delete workout sessions
- **Dual Storage**: Save workouts locally (Swift Data) or remotely (server)
- **Smart Filtering**: Filter workouts by storage location (All, Local, Remote)
- **Modern UI**: Beautiful SwiftUI interface with smooth navigation
- **Offline Support**: Work with workouts even without internet connection
- **Pull-to-Refresh**: Easy data synchronization

## 🏗️ Architecture

PeakTrack follows Clean Architecture principles with a clear separation of concerns:

```
PeakTrack/
├── Scenes/           # Feature-based modules
│   ├── AddNewWorkout/    # Add new workout functionality
│   ├── WorkoutsList/     # Main workouts list
│   └── WorkoutDetail/    # Workout details view
├── DB/               # Database layer (Swift Data)
├── DI/               # Dependency Injection
├── Networking/       # API client for remote operations
├── Navigation/       # Navigation routing
└── UI/              # Shared UI components
```

### Architecture Layers

- **Presentation Layer**: SwiftUI views and view models
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Repositories and data sources
- **Infrastructure**: Database, networking, and DI container

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/PeakTrack.git
cd PeakTrack
```

2. Open `PeakTrack.xcodeproj` in Xcode

3. Build and run the project on your device or simulator

## 📱 App Structure

### Main Screens

1. **Workouts List** - Main screen displaying all workouts with filtering options
2. **Add New Workout** - Form to create new workout entries
3. **Workout Detail** - Detailed view of individual workout information

### Core Features

- **Workout Information**: Track workout name, place, and duration
- **Storage Options**: Choose between local database or remote server
- **Data Persistence**: Automatic saving and retrieval of workout data
- **Navigation**: Intuitive navigation between screens with proper routing

## 🛠️ Technical Details

### Dependencies

- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Local data persistence
- **Combine**: Reactive programming for data binding
- **Dependency Injection**: Custom DI container for testability

### Key Components

- **DIAssembler**: Dependency injection configuration
- **NavigationRouter**: Centralized navigation management
- **APIClient**: Network layer for remote operations
- **WorkoutDBEntity**: SwiftData model for workouts

### Data Flow

1. User interacts with UI
2. ViewModel processes user actions
3. UseCase executes business logic
4. Repository manages data operations
5. Data is stored locally or remotely
6. UI updates reflect changes

## 🧪 Testing

The project is structured to support comprehensive testing:

- **Unit Tests**: Test individual components in isolation
- **Integration Tests**: Test component interactions
- **UI Tests**: Test user interface flows

## 📁 Project Structure

```
PeakTrack/
├── PeakTrackApp.swift              # Main app entry point
├── Scenes/                         # Feature modules
│   ├── AddNewWorkout/             # Add workout feature
│   │   ├── Domain/                # Business logic
│   │   ├── Presentation/          # UI layer
│   │   └── DI/                   # Feature DI
│   ├── WorkoutsList/              # Workouts list feature
│   │   ├── Data/                  # Data layer
│   │   ├── Domain/                # Business logic
│   │   ├── Flow/                  # Feature flow
│   │   ├── Presentation/          # UI layer
│   │   └── DI/                   # Feature DI
│   └── WorkoutDetail/             # Workout detail feature
├── DB/                            # Database layer
├── DI/                            # Dependency injection
├── Extensions/                    # SwiftUI extensions
├── Navigation/                    # Navigation system
├── Networking/                    # Network layer
├── Resources/                     # Assets and resources
└── UI/                           # Shared UI components
```

## 🔧 Configuration

### Database Setup

The app uses SwiftData for local storage. Database configuration is handled automatically through the `DBManager`.

### Network Configuration

API endpoints and network configuration can be modified in the `APIClient` class.

## 📱 Supported Devices

- iPhone (iOS 17.0+)
- iPad (iOS 17.0+)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ilya Yushkov** - [GitHub Profile](https://github.com/ferrary446)

## 🙏 Acknowledgments

- SwiftUI team for the amazing framework
- Apple for SwiftData and iOS development tools
- Clean Architecture community for architectural guidance

---

**Note**: This is a personal project for learning and demonstrating iOS development best practices with Clean Architecture and SwiftUI.
