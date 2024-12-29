import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class CacheService {
  static const String _weatherKey = 'weather_data';
  static const String _forecastKey = 'forecast_data';

  Future<void> cacheWeatherData(WeatherData weather) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherMap = {
      'temperature': weather.temperature,
      'humidity': weather.humidity,
      'windSpeed': weather.windSpeed,
      'description': weather.description,
      'icon': weather.icon,
    };
    await prefs.setString(_weatherKey, json.encode(weatherMap));
  }

  Future<void> cacheForecastData(List<ForecastDay> forecast) async {
    final prefs = await SharedPreferences.getInstance();
    final forecastList = forecast
        .map((day) => {
              'date': day.date.toIso8601String(),
              'minTemp': day.minTemp,
              'maxTemp': day.maxTemp,
              'description': day.description,
              'icon': day.icon,
            })
        .toList();
    await prefs.setString(_forecastKey, json.encode(forecastList));
  }

  Future<WeatherData?> getCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherString = prefs.getString(_weatherKey);
    if (weatherString != null) {
      final weatherMap = json.decode(weatherString);
      return WeatherData(
        temperature: weatherMap['temperature'],
        humidity: weatherMap['humidity'],
        windSpeed: weatherMap['windSpeed'],
        description: weatherMap['description'],
        icon: weatherMap['icon'],
      );
    }
    return null;
  }

  Future<List<ForecastDay>> getCachedForecast() async {
    final prefs = await SharedPreferences.getInstance();
    final forecastString = prefs.getString(_forecastKey);
    if (forecastString != null) {
      final forecastList = json.decode(forecastString) as List;
      return forecastList
          .map((day) => ForecastDay(
                date: DateTime.parse(day['date']),
                minTemp: day['minTemp'],
                maxTemp: day['maxTemp'],
                description: day['description'],
                icon: day['icon'],
              ))
          .toList();
    }
    return [];
  }
}
