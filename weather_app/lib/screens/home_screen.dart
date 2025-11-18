import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../theme/app_theme.dart';

/// Home screen that displays weather information
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  
  // Key for refresh indicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = 
      GlobalKey<RefreshIndicatorState>();
  
  // Future to hold weather data
  late Future<WeatherModel> _weatherFuture;
  
  // Flag to check if using manual city search
  bool _isManualSearch = false;
  
  @override
  void initState() {
    super.initState();
    // Load weather for current location on start
    _weatherFuture = _weatherService.getWeatherForCurrentLocation();
  }
  
  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
  
  /// Refresh weather data
  Future<void> _refreshWeather() async {
    setState(() {
      if (_isManualSearch && _cityController.text.isNotEmpty) {
        _weatherFuture = _weatherService.getWeatherByCity(_cityController.text);
      } else {
        _weatherFuture = _weatherService.getWeatherForCurrentLocation();
      }
    });
  }
  
  /// Search weather by city name
  void _searchByCity() {
    if (_cityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a city name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    setState(() {
      _isManualSearch = true;
      _weatherFuture = _weatherService.getWeatherByCity(_cityController.text.trim());
    });
    
    // Hide keyboard after search
    FocusScope.of(context).unfocus();
  }
  
  /// Use current location
  void _useCurrentLocation() {
    setState(() {
      _isManualSearch = false;
      _cityController.clear();
      _weatherFuture = _weatherService.getWeatherForCurrentLocation();
    });
  }
  
  /// Show search dialog
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search City'),
        content: TextField(
          controller: _cityController,
          decoration: const InputDecoration(
            hintText: 'Enter city name',
            prefixIcon: Icon(Icons.search),
          ),
          textCapitalization: TextCapitalization.words,
          onSubmitted: (_) {
            Navigator.pop(context);
            _searchByCity();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _searchByCity();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search city',
            onPressed: _showSearchDialog,
          ),
          // Current location button
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Use current location',
            onPressed: _useCurrentLocation,
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _refreshWeather,
        child: FutureBuilder<WeatherModel>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Fetching weather data...',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            }
            
            // Error state
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _refreshWeather,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _showSearchDialog,
                        icon: const Icon(Icons.search),
                        label: const Text('Search by city'),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            // Success state - display weather
            if (snapshot.hasData) {
              final weather = snapshot.data!;
              
              return Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.getWeatherGradient(weather.mainCondition),
                ),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    
                    // Weather card
                    WeatherCard(weather: weather),
                    
                    const SizedBox(height: 16),
                    
                    // Pull to refresh hint
                    Center(
                      child: Text(
                        '↓ Pull down to refresh ↓',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
            
            // Default empty state
            return Center(
              child: Text(
                'No data available',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
