# Weather App 🌤️

A complete Flutter application that fetches and displays real-time weather data based on the user's location using the OpenWeatherMap API.

## Features ✨

- 🌍 **Automatic Location Detection** - Uses GPS to get your current location
- 🌡️ **Real-time Weather Data** - Displays current temperature, conditions, humidity, and wind speed
- 🔍 **City Search** - Manually search weather by city name
- 🔄 **Pull to Refresh** - Refresh weather data with a simple pull-down gesture
- 🎨 **Beautiful UI** - Clean, responsive design with dynamic background gradients
- 📱 **Cross-platform** - Works on Android, iOS, and Web
- ⚡ **Error Handling** - Graceful handling of network errors, location permissions, and API issues

## Screenshots 📸

The app includes:
- Weather card with temperature and condition icon
- City name and last updated time
- Humidity and wind speed indicators
- Dynamic background based on weather conditions
- Search functionality with dialog
- Location permission handling

## Technical Stack 🛠️

- **Flutter SDK**: ^3.9.2
- **http**: ^1.2.0 - For API calls
- **geolocator**: ^10.1.0 - For location services
- **google_fonts**: ^6.1.0 - For custom typography

## Project Structure 📁

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── weather_model.dart       # Weather data model
├── services/
│   └── weather_service.dart     # API and location service
├── screens/
│   └── home_screen.dart         # Main weather screen
├── widgets/
│   └── weather_card.dart        # Reusable weather card widget
└── theme/
    └── app_theme.dart           # App theme and styling
```

## Setup Instructions 🚀

### 1. Prerequisites

- Flutter SDK installed ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio / Xcode for mobile development
- A code editor (VS Code, Android Studio, etc.)

### 2. Get OpenWeatherMap API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Go to "API Keys" section
4. Copy your API key

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Configure API Key

Open `lib/services/weather_service.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String _apiKey = 'YOUR_ACTUAL_API_KEY';
```

### 5. Run the App

```bash
# For Android
flutter run

# For iOS (requires Mac)
flutter run -d ios

# For Web
flutter run -d chrome
```

## Platform-Specific Setup 📱

### Android

Permissions are already configured in `android/app/src/main/AndroidManifest.xml`:
- Internet access
- Fine location
- Coarse location

### iOS

Location permissions are configured in `ios/Runner/Info.plist`:
- NSLocationWhenInUseUsageDescription
- NSLocationAlwaysUsageDescription

### Web

No additional setup required.

## Usage 💡

### Getting Weather by Location

1. Launch the app
2. Grant location permission when prompted
3. Weather data for your current location will be displayed automatically

### Searching by City

1. Tap the search icon in the app bar
2. Enter a city name
3. Tap "Search" or press Enter
4. Weather data for that city will be displayed

### Refreshing Data

Pull down on the screen to refresh the weather data.

### Using Current Location

Tap the location icon in the app bar to switch back to your current location.

## API Information 🌐

This app uses the **OpenWeatherMap Current Weather Data API**:
- Endpoint: `https://api.openweathermap.org/data/2.5/weather`
- Units: Metric (Celsius, m/s)
- Response: JSON format

### API Response Example

```json
{
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky"
    }
  ],
  "main": {
    "temp": 22.5,
    "humidity": 60
  },
  "wind": {
    "speed": 3.5
  },
  "name": "London"
}
```

## Error Handling 🛡️

The app handles various error scenarios:

- **No Internet Connection**: Shows error message with retry option
- **Location Permission Denied**: Prompts to grant permission or search manually
- **Invalid API Key**: Clear error message to check API configuration
- **City Not Found**: User-friendly message when searching invalid city names
- **Location Services Disabled**: Prompts to enable location services

## Features Breakdown 🎯

### WeatherModel (`models/weather_model.dart`)
- Parses JSON from OpenWeatherMap API
- Converts temperature units
- Provides formatted strings for display
- Determines appropriate weather icons

### WeatherService (`services/weather_service.dart`)
- Fetches weather by coordinates
- Fetches weather by city name
- Handles location permissions
- Manages API calls with error handling

### HomeScreen (`screens/home_screen.dart`)
- Main UI with FutureBuilder for async data
- Pull-to-refresh functionality
- Search dialog for manual city entry
- Loading and error states

### WeatherCard (`widgets/weather_card.dart`)
- Reusable card component
- Displays weather information
- Shows humidity and wind speed details

### AppTheme (`theme/app_theme.dart`)
- Custom color schemes
- Google Fonts integration
- Dynamic gradients based on weather

## Customization 🎨

### Changing Colors

Edit `lib/theme/app_theme.dart` to customize colors:

```dart
static const Color primaryColor = Color(0xFF2196F3);
static const Color accentColor = Color(0xFF03A9F4);
```

### Adding Weather Icons Package

For more detailed weather icons, you can add the `weather_icons` package:

```yaml
dependencies:
  weather_icons: ^3.0.0
```

### Temperature Units

To switch between Celsius and Fahrenheit, modify the API call in `weather_service.dart`:

```dart
// For Fahrenheit
final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=imperial');
```

## Troubleshooting 🔧

### Location not working
- Check device location settings are enabled
- Verify location permissions are granted
- Ensure GPS is turned on

### API errors
- Verify your API key is correct
- Check your internet connection
- Ensure you haven't exceeded API rate limits (60 calls/minute for free tier)

### Build errors
- Run `flutter clean` then `flutter pub get`
- Update Flutter: `flutter upgrade`
- Check for any platform-specific issues

## Future Enhancements 🚀

Potential features to add:
- [ ] 7-day weather forecast
- [ ] Hourly forecast
- [ ] Multiple saved locations
- [ ] Weather alerts and notifications
- [ ] Weather maps
- [ ] Dark mode support
- [ ] Animated weather backgrounds
- [ ] Temperature graphs
- [ ] Sunrise/sunset times

## License 📄

This project is open source and available for educational purposes.

## Credits 👏

- **Weather Data**: [OpenWeatherMap API](https://openweathermap.org/)
- **Fonts**: [Google Fonts](https://fonts.google.com/)
- **Framework**: [Flutter](https://flutter.dev/)

## Support 💬

For issues, questions, or contributions, please refer to the project repository.

---

**Built with ❤️ using Flutter**
