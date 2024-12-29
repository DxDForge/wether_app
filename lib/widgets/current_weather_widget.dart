import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherData weather;

  const CurrentWeatherWidget({super.key, required this.weather});

  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@4x.png';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              _getWeatherIconUrl(weather.icon),
              height: 100,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.cloud, size: 100);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            Text(
              '${weather.temperature.round()}°C',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(
                  context,
                  Icons.water_drop_rounded,
                  '${weather.humidity}%',
                  'Humidity',
                ),
                _buildWeatherInfo(
                  context,
                  Icons.air_rounded,
                  '${weather.windSpeed} m/s',
                  'Wind',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
      BuildContext context, IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
