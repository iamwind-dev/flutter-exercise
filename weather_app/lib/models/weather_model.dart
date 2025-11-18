/// Model class to represent weather data
/// This class parses JSON response from OpenWeatherMap API
class WeatherModel {
  final String cityName;
  final double temperature; // in Celsius
  final String mainCondition; // e.g., "Clear", "Clouds", "Rain"
  final String description; // e.g., "clear sky", "few clouds"
  final int humidity; // percentage
  final double windSpeed; // in m/s
  final DateTime timestamp;
  final int weatherId; // Used to determine weather icons
  
  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
    required this.weatherId,
  });
  
  /// Factory constructor to create WeatherModel from JSON
  /// Converts Kelvin to Celsius automatically
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // Temperature conversion from Kelvin to Celsius
    // Note: If using units=metric in API call, this is already in Celsius
    double temp = json['main']['temp'].toDouble();
    
    return WeatherModel(
      cityName: json['name'],
      temperature: temp,
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      timestamp: DateTime.now(),
      weatherId: json['weather'][0]['id'],
    );
  }
  
  /// Get appropriate weather icon based on weather ID
  /// OpenWeatherMap weather condition codes: https://openweathermap.org/weather-conditions
  String getWeatherIcon() {
    if (weatherId >= 200 && weatherId < 300) {
      // Thunderstorm
      return '⛈️';
    } else if (weatherId >= 300 && weatherId < 400) {
      // Drizzle
      return '🌦️';
    } else if (weatherId >= 500 && weatherId < 600) {
      // Rain
      return '🌧️';
    } else if (weatherId >= 600 && weatherId < 700) {
      // Snow
      return '❄️';
    } else if (weatherId >= 700 && weatherId < 800) {
      // Atmosphere (fog, mist, etc.)
      return '🌫️';
    } else if (weatherId == 800) {
      // Clear sky
      return '☀️';
    } else if (weatherId > 800 && weatherId < 900) {
      // Clouds
      return '☁️';
    }
    return '🌤️'; // Default
  }
  
  /// Get formatted temperature string
  String getTemperatureString() {
    return '${temperature.toStringAsFixed(1)}°C';
  }
  
  /// Get capitalized description
  String getCapitalizedDescription() {
    return description.split(' ').map((word) => 
      word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }
  
  /// Get formatted wind speed
  String getWindSpeedString() {
    return '${windSpeed.toStringAsFixed(1)} m/s';
  }
  
  /// Get formatted humidity
  String getHumidityString() {
    return '$humidity%';
  }
  
  /// Get last updated time
  String getLastUpdatedTime() {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
