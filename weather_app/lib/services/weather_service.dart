import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';

/// Service class to handle weather API calls and location services
class WeatherService {
  // Replace with your OpenWeatherMap API key
  // Get your free API key at: https://openweathermap.org/api
  static const String _apiKey = '733ceb443bcac5210da6dc6a647e5355';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  
  /// Fetch weather data by coordinates (latitude, longitude)
  /// Returns WeatherModel on success, throws exception on failure
  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon) async {
    try {
      // Construct API URL with coordinates and metric units
      final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
      
      // Make HTTP GET request
      final response = await http.get(url);
      
      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenWeatherMap API key.');
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
  
  /// Fetch weather data by city name
  /// Returns WeatherModel on success, throws exception on failure
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      // Construct API URL with city name and metric units
      final url = Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric');
      
      // Make HTTP GET request
      final response = await http.get(url);
      
      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenWeatherMap API key.');
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
  
  /// Get current user location
  /// Returns Position with latitude and longitude
  /// Handles permission requests and errors
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable location services.');
    }
    
    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied. Please grant location access.');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      throw Exception(
        'Location permissions are permanently denied. '
        'Please enable them in your device settings.'
      );
    }
    
    // Get current position with high accuracy
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
  
  /// Fetch weather for current location
  /// Combines location fetching and weather data retrieval
  Future<WeatherModel> getWeatherForCurrentLocation() async {
    try {
      // Get current position
      final position = await getCurrentLocation();
      
      // Fetch weather data using coordinates
      return await getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      throw Exception('Error getting weather for current location: $e');
    }
  }
}
