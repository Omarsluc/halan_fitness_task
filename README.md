# 🏃‍♂️ Halan Fitness App

A modern, feature-rich Flutter fitness application designed to help users track their workouts, monitor progress, and achieve their fitness goals. Built with clean architecture principles and modern Flutter development practices.

## ✨ Features

### 🎯 Core Functionality
- **Exercise Library**: Browse and search through a comprehensive collection of exercises
- **Workout Tracking**: Log and track your workout sessions with detailed metrics
- **Progress Monitoring**: Visualize your fitness journey with charts and statistics
- **Personal Dashboard**: Personalized fitness dashboard with exercise recommendations

### 🔍 Exercise Management
- **Search & Filter**: Find exercises by body part, equipment, or custom search terms
- **Exercise Details**: Comprehensive exercise information with instructions and images
- **Workout Logging**: Record sets, reps, and weights for each exercise
- **Exercise Sharing**: Share exercises with friends and family

### 📊 Progress Analytics
- **Weekly Charts**: Visual representation of your workout frequency
- **Workout History**: Complete log of all your training sessions
- **Statistics Overview**: Total workouts, duration, and weekly progress
- **Performance Tracking**: Monitor improvements over time

### 🎨 User Experience
- **Responsive Design**: Optimized for all screen sizes using Flutter ScreenUtil
- **Dark/Light Theme**: Customizable app appearance
- **Smooth Animations**: Engaging user interactions and transitions
- **Offline Support**: Local data storage with Hive database

### 🌐 Internet Connectivity
- **Connection Monitoring**: Real-time internet connectivity status monitoring
- **Smart Error Handling**: Automatic connection failure detection and user notification
- **Retry Mechanism**: Built-in retry functionality for failed network requests
- **User-Friendly Dialogs**: Clear connection status messages with actionable options

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a feature-based structure:

```
lib/
├── core/                    # Core functionality and shared components
│   ├── api/                # API services and network layer
│   ├── di/                 # Dependency injection setup
│   ├── models/             # Data models and entities
│   ├── routing/            # Navigation and routing logic
│   ├── services/           # Business logic services
│   ├── theming/            # App themes and styling
│   ├── utilities/          # Helper functions and constants
│   └── widgets/            # Reusable UI components
├── features/               # Feature modules
│   ├── app/                # App-level configuration and theme
│   ├── dashboard/          # Main dashboard and exercise browsing
│   ├── exercise/           # Exercise details and workout logging
│   └── progress/           # Progress tracking and analytics
└── main.dart              # App entry point
```

## 🛠️ Tech Stack

### Frontend Framework
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language

### State Management
- **Flutter Bloc**: State management with BLoC pattern
- **Equatable**: Value equality for immutable objects

### Networking & API
- **Dio**: HTTP client for API requests
- **Pretty Dio Logger**: Network request logging

### Local Storage
- **Hive**: Fast, lightweight NoSQL database
- **Hive Flutter**: Flutter integration for Hive

### UI & Visualization
- **Fl Chart**: Beautiful charts and graphs
- **Cached Network Image**: Image caching and loading
- **Shimmer**: Loading placeholders
- **Flutter ScreenUtil**: Responsive design utilities

### Utilities
- **Get It**: Dependency injection
- **Flutter Local Notifications**: Push notifications
- **Connectivity Plus**: Network connectivity monitoring
- **Intl**: Internationalization support

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.6.0)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/halan_fitnessapp_task.git
   cd halan_fitnessapp_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build Instructions

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

## 📱 Screenshots

*[Add screenshots of your app here]*

## 🔧 Configuration

### Environment Setup
The app uses environment-specific configurations. Make sure to:
- Set up your API endpoints in `lib/core/api/`
- Configure dependency injection in `lib/core/di/`
- Set up your theme preferences in `lib/core/theming/`

### Internet Connectivity Setup
The app includes built-in internet connectivity monitoring:

1. **Automatic Connection Detection**: The app automatically detects when internet connection is lost
2. **User Notification**: Shows a user-friendly dialog when there's no connection
3. **Retry Functionality**: Users can retry failed operations when connection is restored

#### Usage Examples:

**Check connection manually:**
```dart
final connectivityService = InternetConnectivityService.instance;
final hasConnection = await connectivityService.checkConnection();

if (!hasConnection) {
  // Handle no connection scenario
}
```

**Show connection dialog:**
```dart
await ConnectionDialogService.showConnectionDialog(
  context,
  onRetry: () {
    // Retry the failed operation
    loadData();
  },
);
```

**Check connection before API calls:**
```dart
Future<void> loadData() async {
  final hasConnection = await connectivityService.checkConnection();
  
  if (!hasConnection) {
    emit(ErrorState('No internet connection'));
    return;
  }
  
  // Proceed with API call
  final data = await apiService.getData();
  emit(SuccessState(data));
}
```

### API Configuration
Update the API base URL and endpoints in the configuration files:
```dart
// lib/core/api/api_config.dart
class ApiConfig {
  static const String baseUrl = 'YOUR_API_BASE_URL';
  // ... other configurations
}
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

## 📦 Dependencies

### Production Dependencies
- `flutter_bloc: ^8.1.3` - State management
- `dio: ^5.3.2` - HTTP client
- `hive: ^2.2.3` - Local database
- `fl_chart: ^0.71.0` - Charts and graphs
- `flutter_screenutil: ^5.9.3` - Responsive design

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Code quality rules

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and maintainers
- Fitness community for inspiration

## 📞 Support

If you have any questions or need help:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Made with ❤️ using Flutter**
