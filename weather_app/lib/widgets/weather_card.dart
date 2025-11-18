import 'package:flutter/material.dart';
import '../models/weather_model.dart';

/// Custom widget to display weather information in a card
class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  
  const WeatherCard({
    Key? key,
    required this.weather,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // City name
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Last updated time
            Text(
              'Last updated: ${weather.getLastUpdatedTime()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // Weather icon (emoji)
            Text(
              weather.getWeatherIcon(),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 16),
            
            // Temperature
            Text(
              weather.getTemperatureString(),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Weather description
            Text(
              weather.getCapitalizedDescription(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Weather details row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Humidity
                _buildWeatherDetail(
                  context,
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: weather.getHumidityString(),
                ),
                
                // Wind speed
                _buildWeatherDetail(
                  context,
                  icon: Icons.air,
                  label: 'Wind',
                  value: weather.getWindSpeedString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Helper method to build weather detail item
  Widget _buildWeatherDetail(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
