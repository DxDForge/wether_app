class WeatherData {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String description;
  final String icon;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
  });
}

class ForecastDay {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;

  ForecastDay({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
  });
}
