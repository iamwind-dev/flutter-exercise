# News Reader App

A modern Flutter application that fetches and displays the latest news headlines from [NewsAPI.org](https://newsapi.org/). Built with clean architecture, beautiful UI, and smooth user experience.

---

## Features

- **Real-time News**: Fetches the latest top headlines from NewsAPI
- **Pull-to-Refresh**: Swipe down to refresh the news feed
- **Responsive UI**: Clean, modern interface with Material Design 3
- **Image Loading**: Displays article images with loading states and error handling
- **Article Details**: View full article information with one tap
- **Open in Browser**: Read the complete article on the original website
- **Smart Caching**: In-memory caching for better performance (5-minute cache)
- **Date Formatting**: Human-readable publication dates with intl
- **Custom Typography**: Poppins font from Google Fonts throughout the app
- **Error Handling**: Graceful handling of network errors and invalid responses

---

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio with Flutter plugins

### Installation

1. **Clone or navigate to the project directory**:

   ```bash
   cd news_reader_app
   ```
2. **Install dependencies**:

   ```bash
   flutter pub get
   ```
3. **Run the app**:

   ```bash
   flutter run
   ```

---

## 🔑 API Configuration

The app uses NewsAPI.org with a built-in API key. The key is already configured in `lib/services/news_service.dart`:

```dart
static const String _apiKey = '9ec735febb474e539c85479797cefc0a';
```
