import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  group('WeatherService Tests', () {
    late WeatherService weatherService;

    setUp(() {
      weatherService = WeatherService();
    });

    test('getCurrentWeather returns WeatherData', () async {
      final result = await weatherService.getCurrentWeather(0, 0);
      expect(result, isA<WeatherData>());
    });

    test('getForecast returns list of ForecastDay', () async {
      final result = await weatherService.getForecast(0, 0);
      expect(result, isA<List<ForecastDay>>());
    });
  });
}
