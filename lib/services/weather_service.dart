import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/services/cache_service.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WeatherService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String geoUrl = 'https://api.openweathermap.org/geo/1.0';
  final String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  final CacheService _cacheService = CacheService();

  Future<WeatherData> getCurrentWeather(double lat, double lon) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        final cachedWeather = await _cacheService.getCachedWeather();
        if (cachedWeather != null) {
          return cachedWeather;
        }
        throw Exception('No internet connection and no cached data available');
      }

      final response = await http.get(Uri.parse(
          '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherData = WeatherData(
          temperature: data['main']['temp'].toDouble(),
          humidity: data['main']['humidity'].toDouble(),
          windSpeed: data['wind']['speed'].toDouble(),
          description: data['weather'][0]['description'],
          icon: data['weather'][0]['icon'],
        );

        await _cacheService.cacheWeatherData(weatherData);
        return weatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      final cachedWeather = await _cacheService.getCachedWeather();
      if (cachedWeather != null) {
        return cachedWeather;
      }
      rethrow;
    }
  }

  Future<List<ForecastDay>> getForecast(double lat, double lon) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return await _cacheService.getCachedForecast();
      }

      final response = await http.get(Uri.parse(
          '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<ForecastDay> forecasts = [];
        final Map<String, ForecastDay> dailyForecasts = {};

        // Group forecasts by day
        for (var item in data['list']) {
          final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          final dateString = DateFormat('yyyy-MM-dd').format(date);

          if (!dailyForecasts.containsKey(dateString)) {
            dailyForecasts[dateString] = ForecastDay(
              date: date,
              minTemp: item['main']['temp_min'].toDouble(),
              maxTemp: item['main']['temp_max'].toDouble(),
              description: item['weather'][0]['description'],
              icon: item['weather'][0]['icon'],
            );
          }
        }

        forecasts.addAll(dailyForecasts.values);
        await _cacheService.cacheForecastData(forecasts);
        return forecasts.take(7).toList();
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      return await _cacheService.getCachedForecast();
    }
  }

  Future<Map<String, double>> getCoordinatesForCity(String cityName) async {
    try {
      if (apiKey == null) {
        throw Exception('API key not found. Please check your .env file.');
      }

      final response = await http.get(
        Uri.parse('$geoUrl/direct?q=$cityName&limit=1&appid=$apiKey'),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isEmpty) {
          throw Exception('City not found. Please check the city name.');
        }
        return {
          'lat': data[0]['lat'],
          'lon': data[0]['lon'],
        };
      } else {
        throw Exception(
          'Failed to get city coordinates. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception(
          'Failed to connect to the weather service. Please check your internet connection.');
    }
  }
}
