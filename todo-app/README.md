# 📝 Flutter Todo App

A complete, feature-rich Todo application built with Flutter using local state management and persistent storage. Perfect for learning StatefulWidget, setState, and local data persistence.

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.0 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone or download this project**

   ```bash
   cd todo_app
   ```
2. **Install dependencies**

   ```bash
   flutter pub get
   ```
3. **Run the app**

   ```bash
   # Run on any available device
   flutter run

   # Run on specific platform
   flutter run -d windows
   flutter run -d chrome
   flutter run -d android
   flutter run -d ios
   ```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Windows
flutter build windows --release

# Web
flutter build web --release
```

## How to Use

### Adding a Task

1. Tap the **+** (FloatingActionButton) at the bottom right
2. Enter your task title in the dialog
3. Tap **Add** or press Enter
4. See a confirmation SnackBar

### Completing a Task

1. Tap the **checkbox** next to any task
2. Completed tasks show with line-through text
3. Tap again to mark as incomplete

### Deleting a Task

1. Tap the **delete icon** (trash can) on any task
2. Confirm deletion in the dialog
3. See a confirmation SnackBar

### Searching Tasks

1. Type in the **search box** at the top
2. Tasks filter in real-time
3. Tap the **X** button to clear search
